use v6;
use Test;

# RT #130474

constant HOST_PORT_IPV4 = '127.0.0.1:5014';
constant HOST_PORT_IPV6 = '[::1]:5016';

plan 2;

split-host-port :uri(HOST_PORT_IPV4), :family(PF_INET);

#?rakudo skip 'Hangs on boxes without IPv6 support'
#?DOES 1
{
    split-host-port :uri(HOST_PORT_IPV6), :family(PF_INET6);
}

done-testing;

sub split-host-port(:$uri, :$family) {
    my $c     = Channel.new;
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(
            :localhost($uri),
            :listen,
            :$family,
        );

        $ready.keep(True);

        loop {
            my $connection = $listen.accept;
            while my $buffer = $connection.recv(:bin) {
                $connection.write: $buffer;
                start {
                    $c.send('ok');
                }
            }

            $connection.close;
        }
    }

    await $ready;

    my $connection = IO::Socket::INET.new(
        :host($uri),
        :$family,
    );

    $connection.print: "Don't hang up";
    is $connection.recv, "Don't hang up",
        "{ $family == PF_INET ?? 'IPv4'
            !! $family == PF_INET6 ?? 'IPv6'
            !! die 'Invalid INET family value'} server responded";
    $connection.close;
}

# vim: ft=perl6
