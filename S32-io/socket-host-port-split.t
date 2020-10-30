use v6;
use Test;

# https://github.com/Raku/old-issue-tracker/issues/5960

plan 2;

{
    my $localhost = '0.0.0.0:5014';
    my $host      = '127.0.0.1:5014';
    my $family    = PF_INET;
    split-host-port :$localhost, :$host, :$family;
}

#?rakudo skip 'Hangs on boxes without IPv6 support'
#?DOES 1
{
    my $localhost = '[::]:5014';
    my $host      = '[::1]:5014';
    my $family    = PF_INET6;
    split-host-port :$localhost, :$host, :$family;
}

sub split-host-port(:$localhost, :$host, :$family) is test-assertion {
    my $c     = Channel.new;
    my $ready = Promise.new;

    start {
        my $listen = IO::Socket::INET.new(
            :$localhost,
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
        :$host,
        :$family,
    );

    $connection.print: "Don't hang up";
    is $connection.recv, "Don't hang up",
        "{ $family == PF_INET ?? 'IPv4'
            !! $family == PF_INET6 ?? 'IPv6'
            !! die 'Invalid INET family value'} server responded";
    $connection.close;
}

# vim: expandtab shiftwidth=4
