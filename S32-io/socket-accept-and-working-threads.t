use Test;

# RT #129213

plan 10;

class Dummy { has ($.a, $.b, $.c, $.d, $.e) }

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

