use v6;
use Test;

plan 7;

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

my $message = [~] '0'..'z';
my $echoResult = await client($message);
$echoTap.close;
ok $echoResult eq $message, 'Echo server';

my $discardTap = $server.tap(-> $c {
    $c.Supply.tap(-> $chars { $c.close });
});

my $discardResult = await client($message);
$discardTap.close;
ok $discardResult eq '', 'Discard server';

my Buf $binary = slurp( 't/spec/S32-io/socket-test.bin', bin => True );
my $binaryTap = $server.tap(-> $c {
    sleep 0.1;
    $c.write($binary).then({ $c.close });
});

#?rakudo.jvm skip 'hangs (sometimes) RT #127948'
{
    multi sub client(Buf $message) {
        client(-> $socket, $vow {
            my $buf = Buf[uint8].new;
            $socket.Supply(:bin).act(-> $bytes { 
                    $buf ~= $bytes;
                    $socket.close();
                    $vow.keep($buf);
                },
                quit => { $vow.break($_); });
        });
    }

    my $received = await client($binary);
    $binaryTap.close;
    ok $binary eqv $received, 'bytes-supply';
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
