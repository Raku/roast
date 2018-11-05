use v6;
use Test;

plan 41;

my $hostname = 'localhost';
my $port = 5000;

try {
    my $sync = Promise.new;
    IO::Socket::Async.listen('veryunlikelyhostname.bogus', $port).tap(quit => {
        ok $_ ~~ Exception, 'Async listen on bogus hostname';
        $sync.keep(1);
    });
    await $sync;
}

await IO::Socket::Async.connect($hostname, $port).then(-> $sr {
    is $sr.status, Broken, 'Async connect to unavailable server breaks promise';
});

my $server = IO::Socket::Async.listen($hostname, $port);

my $echoTap = $server.tap(-> $c {
    $c.Supply.tap(-> $chars {
        $c.print($chars).then({ $c.close });
    }, quit => { say $_; });
});

await IO::Socket::Async.connect($hostname, $port).then(-> $sr {
    is $sr.status, Kept, 'Async connect to available server keeps promise';
    $sr.result.close() if $sr.status == Kept;
});

multi sub client(&code) {
    my $p = Promise.new;
    my $v = $p.vow;

    my $client = IO::Socket::Async.connect($hostname, $port).then(-> $sr {
        if $sr.status == Kept {
            my $socket = $sr.result;
            code($socket, $v);
        }
        else {
            $v.break($sr.cause);
        }
    });
    $p
}

multi sub client(Str $message) {
    client(-> $socket, $vow {
    $socket.print($message).then(-> $wr {
        if $wr.status == Broken {
            $vow.break($wr.cause);
            $socket.close();
        }
    });
    my @chunks;
    $socket.Supply.tap(-> $chars { @chunks.push($chars) },
        done => {
            $socket.close();
            $vow.keep([~] @chunks);
        },
        quit => { $vow.break($_); })
    });
}

multi sub client(Blob $message, Blob $second?) {
    client(-> $socket, $vow {
        $socket.write($message).then(-> $wr {
            if $wr.status == Broken {
                $vow.break($wr.cause);
                $socket.close();
            }
            elsif $second {
                $socket.write($second).then(-> $wr {
                    if $wr.status == Broken {
                        $vow.break($wr.cause);
                        $socket.close();
                    }
                });
            }
        });
        my $buf = Buf[uint8].new;
        $socket.Supply(:bin).act(-> $bytes {
                $buf ~= $bytes;
            },
            done => {
                $socket.close();
                $vow.keep($buf);
            },
            quit => { $vow.break($_); });
    });
}

my $message = [~] flat '0'..'z', "\n";
my $echoResult = await client($message);
is $echoResult, $message, 'Echo server';
$echoTap.close;

{
    my $firstReceive;
    my $splitGraphemeTap = $server.tap(-> $c {
        $c.Supply.tap(
            -> $msg { $firstReceive = $msg; $c.close; }
        );
    });
    await client('u'.encode('utf-8'), "\c[COMBINING DOT ABOVE]\n".encode('utf-8'));
    $splitGraphemeTap.close;
    is $firstReceive, "u̇\n", 'Coped with grapheme split across packets';
}

#?rakudo.jvm todo 'IllegalStateException: Current state = CODING_END, new state = CODING'
{
    my $echo2Tap = $server.tap(-> $c {
        $c.Supply.tap(-> $chars {
            $c.print($chars).then({ $c.close });
        }, quit => { say $_; });
    });
    my $encMessage = "пиво\n".encode('utf-8');
    my $splitResult = await client($encMessage.subbuf(0, 3), $encMessage.subbuf(3));
    $echo2Tap.close;
    is $splitResult.decode('utf-8'), "пиво\n", 'Coped with UTF-8 bytes split across packets';
}

# RT #128862
#?rakudo.jvm skip 'hangs on JVM'
{
    my $failed = False;
    my $badInputTap = $server.tap(-> $c {
        $c.Supply.tap(
            -> $chars { },
            quit => { $failed = True; $c.close; }
        );
    });
    try await client(Buf.new(0xFF, 0xFF));
    $badInputTap.close;
    ok $failed, 'Bad UTF-8 causes quit on Supply (but program survives)';
}

{
    my $discardTap = $server.tap(-> $c {
        $c.Supply.tap(-> $chars { $c.close });
    });
    my $discardResult = await client($message);
    $discardTap.close;
    ok $discardResult eq '', 'Discard server';
}

{
    my Buf $binary = slurp( $?FILE.IO.parent.child('socket-test.bin'), bin => True );
    my $binaryTap = $server.tap(-> $c {
        $c.write($binary).then({ $c.close });
    });

    #?rakudo.jvm todo 'unknown problem, did hang (sometimes) RT #127948'
    {
        my $received = await client(Buf.new);
        ok $binary eqv $received, 'bytes-supply';
    }
    $binaryTap.close;
}

{
    my $latin1server = IO::Socket::Async.listen($hostname, $port, :enc('latin-1'));
    my $latin1Tap = $latin1server.tap(-> $c {
        $c.Supply.tap(-> Str $msg { $c.print($msg).then({ $c.close }) });
    });
    my $latin1Buf = "Öl\n".encode('latin-1');
    my $received = await client($latin1Buf);
    ok $received.list eqv $latin1Buf.list, 'Server socket configured with latin-1 handles it';
    $latin1Tap.close;
}

{
    my $transcodeServer = IO::Socket::Async.listen($hostname, $port, :enc('utf-8'));
    my $transcodeTap = $transcodeServer.tap(-> $c {
        $c.Supply(:enc('latin-1')).tap(-> Str $msg { $c.print($msg).then({ $c.close }) });
    });
    my $latin1Buf = "Öl\n".encode('latin-1');
    my $utf8Buf = "Öl\n".encode('utf-8');
    my $received = await client($latin1Buf);
    ok $received.list eqv $utf8Buf.list, 'Can set encoding on incoming Supply separately';
    $transcodeTap.close;
}

{
    my $byteCountTap = $server.tap(-> $c {
        $c.Supply(:bin).tap(-> Blob $b { $c.write("Öl,$b.elems()\n".encode('latin-1')).then({ $c.close }) });
    });
    my $latin1Client = await IO::Socket::Async.connect($hostname, $port, :enc('latin-1'));
    my $received = Promise.new;
    my $receivedStr = '';
    $latin1Client.Supply.tap({ $receivedStr ~= $_ }, done => { $received.keep($receivedStr) });
    $latin1Client.print("Öl\n");
    is await($received), "Öl,3\n", 'Latin-1 client socket correctly encodes';
    $byteCountTap.close;
}

# RT#132135
for '127.0.0.1', '::1' -> $host {
    my $port = 5001;
    diag("host=$host");

    my $s = IO::Socket::Async.listen($host, $port);

    my $s_conn_promise = Promise.new;
    my $s_tap = $s.tap({ $s_conn_promise.keep($_) });
    my $c_conn = await IO::Socket::Async.connect($host, $port);
    my $s_conn = await $s_conn_promise;

    is(($s_conn, $c_conn).map({ |(.peer-host, .socket-host) }).unique,
      $host, '*-host accessors are right');

    is($c_conn.peer-port, $port, "client's peer-port is right");
    is($s_conn.socket-port, $port, "server's socket-port is right");
    cmp-ok($c_conn.socket-port, '>', 1024, "client's socket-port seems right");
    cmp-ok($s_conn.peer-port, '>', 1024, "server's peer-port seems right");

    $c_conn.close(); $s_tap.close();
}

{
    my $anotherPort = 6000;
    my $badServer = IO::Socket::Async.listen($hostname, $anotherPort);
    my $failed = Promise.new;
    my $t1 = $badServer.tap();
    my $t2 = $badServer.tap(quit => { $failed.keep });
    await Promise.anyof($failed, Promise.in(5));
    ok $failed, 'Address already in use results in a quit';
}

{
    my $t = IO::Socket::Async.listen("localhost", 5007).tap: -> $conn { };
    my $conn = await IO::Socket::Async.connect("localhost", 5007);
    lives-ok { for ^5 { $conn.close; sleep 0.05; } },
        'Multiple close of an IO::Socket::Async silently coped with';
    dies-ok { await $conn.write("42".encode("ascii")) },
        'Write of a socket after close dies in catachable way when awaited';
    is-deeply $conn.Supply.list, (),
        'Read Supply on a closed socket is immediately done';
    $t.close
}

{
    my $lis = IO::Socket::Async.listen("localhost", 0);

    my @first-got;
    my @second-got;

    my $first-done = Promise.new;
    my $second-done = Promise.new;

    my $first  = $lis.tap: -> $conn {
        @first-got.append:  $conn.Supply.list;
        $first-done.keep;
        CATCH { $first-done.break($_) };
    }
    my $second = $lis.tap: -> $conn {
        @second-got.append: $conn.Supply.list;
        $second-done.keep;
        CATCH { $second-done.break($_) };
    }

    isnt $first.socket-port.result, 0, "socket port isn't zero (first)";
    isnt $second.socket-port.result, 0, "socket port isn't zero (second)";

    isnt $first.socket-port.result, $second.socket-port.result, "socket ports of first and second connection aren't the same";

    for $first, $second {
        diag try .socket-host.result;
        diag try .socket-port.result;
    }

    my $fconn;
    my $sconn;
    lives-ok { $fconn = await IO::Socket::Async.connect("localhost", $first.socket-port.result) }, "can connect to first port on localhost";
    lives-ok { $sconn = await IO::Socket::Async.connect($second.socket-host.result, $second.socket-port.result) }, "can connect to second port on given host and port";

    lives-ok { await $fconn.write("hello first".encode("ascii")) }, "send message to first connection";
    lives-ok { await $sconn.write("hello second".encode("ascii")) }, "send message to second connection";

    lives-ok { $fconn.close }, "close first connection";
    lives-ok { $sconn.close }, "close second connection";

    $first.close;
    $second.close;

    lives-ok { await $first-done, $second-done }, "both receivers finished without exception";

    is @first-got.join(""), "hello first", "first server socket got the right message";
    is @second-got.join(""), "hello second", "second server socket got the right message";
}

#?rakudo.jvm skip 'nqp::filenofh not yet implemented on the JVM'
{
    my Promise $p .= new;
    my $v = $p.vow;

    my $s = IO::Socket::Async.listen('localhost', 0).tap(-> $c {
        cmp-ok $c.native-descriptor, '>', -1, 'server peer file descriptor makes sense';
        $v.keep: 1;
    });
    cmp-ok $s.native-descriptor, '>', -1, 'server file descriptor makes sense';

    my $c = await IO::Socket::Async.connect: 'localhost', await $s.socket-port;
    cmp-ok $c.native-descriptor, '>', -1, 'client file descriptor makes sense';

    await $p;
    $s.close;
    $c.close;
}
