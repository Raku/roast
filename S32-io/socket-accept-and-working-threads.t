use Test;

plan 15;

# RT #129213
{
    my class Dummy { has ($.a, $.b, $.c, $.d, $.e) }

    my $c = Channel.new;
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(:listen, :localport(10333));
        $ready.keep(True);
        loop {
            my $conn = $listen.accept;
            while my $buf = $conn.recv(:bin) {
                $conn.write: $buf;
                start {
                    Dummy.new(:1a, :2b, :3c, :4d, :5e) for ^3000;
                    $c.send('ok');
                }
            }
            $conn.close;
        }
    }


    await $ready;
    for ^5 {
        my $conn = IO::Socket::INET.new(:host<127.0.0.1>, :port(10333));
        $conn.print: "Don't hang up";
        is $conn.recv, "Don't hang up", "Server responded ($_)";
        $conn.close;
    }

    for ^5 {
        is $c.receive, 'ok', "Started work was completed ($_)";
    }
}

# MoarVM #165 (could not recv in a thread besides where the socket was
# accepted)
{
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(:listen, :localport(10334));
        $ready.keep(True);
        loop {
            my $conn = $listen.accept;
            start {
                while my $buf = $conn.recv(:bin) {
                    $conn.write: $buf;
                }
                $conn.close;
            }
        }
    }

    await $ready;
    for ^5 {
        my $conn = IO::Socket::INET.new(:host<127.0.0.1>, :port(10334));
        $conn.print: "Can be handled on a thread";
        is $conn.recv, "Can be handled on a thread",
            "Server with recv on different thread responded ($_)";
        $conn.close;
    }
}
