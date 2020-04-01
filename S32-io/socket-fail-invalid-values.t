use Test;

# https://github.com/Raku/old-issue-tracker/issues/5959
# https://github.com/Raku/old-issue-tracker/issues/5961

my $localhost = '0.0.0.0';

constant FAMILY_VALUE_TOO_LOW  = -1;
constant FAMILY_VALUE_TOO_HIGH = 9999999;

constant PORT_VALUE_VALID       = 5018;
constant PORT_VALUE_TOO_LOW     = -1;
constant PORT_VALUE_TOO_HIGH    = 65_536;

plan 4;

fails-like &port-too-low,    X::AdHoc, 'Fails when port is too low';
fails-like &port-too-high,   X::AdHoc, 'Fails when port is too high';
fails-like &family-too-low,  X::AdHoc, 'Fails when family is too low';
fails-like &family-too-high, X::AdHoc, 'Fails when family is too high';

sub port-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_LOW),
    );
}

sub port-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_TOO_HIGH),
    );
}

sub family-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_LOW),
    );
}

sub family-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :$localhost,
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_HIGH),
    );
}

# vim: ft=perl6
