use v6.c;
use Test;

plan 6;

my $hostname = 'localhost';
my $port; # With dynamic server port, refresh this on each new .tap

# hardcoded port on invalid hostname
try {
    my $sync = Promise.new;
    IO::Socket::Async.listen('veryunlikelyhostname.bogus', 5000).tap(quit => {
        ok $_ ~~ Exception, 'Async listen on bogus hostname';
        $sync.keep(1);
    });
    await $sync;
}

# random (hopefully invalid) port on localhost
my $random-port = (5_000..10_000).pick;
await IO::Socket::Async.connect($hostname, $random-port).then(-> $sr {
    is $sr.status, Broken, 'Async connect to unavailable server breaks promise';
});

# use dynamic port ...
my $server = IO::Socket::Async.listen($hostname, 0);

my $echoTap = $server.tap(-> $c {
    $c.Supply.tap(-> $chars {
        $c.print($chars).then({ $c.close });
    }, quit => { say $_; });
});

# ... get actual port number used.
$port = await $echoTap.socket-port;

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

my $message = [~] flat '0'..'z', "\n";
my $echoResult = await client($message);
$echoTap.close;
ok $echoResult eq $message, 'Echo server';

my $discardTap = $server.tap(-> $c {
    $c.Supply.tap(-> $chars { $c.close });
});

$port = await $discardTap.socket-port;
my $discardResult = await client($message);
$discardTap.close;
ok $discardResult eq '', 'Discard server';

my Buf $binary = slurp( 't/spec/S32-io/socket-test.bin', bin => True );
my $binaryTap = $server.tap(-> $c {
    sleep 0.1;
    $c.write($binary).then({ $c.close });
});

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

$port = await $binaryTap.socket-port;
my $received = await client($binary);
$binaryTap.close;
ok $binary eqv $received, 'bytes-supply';
