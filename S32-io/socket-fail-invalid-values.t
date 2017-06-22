use Test;

# RT #130473, #130475

constant HOST = 'localhost';

constant FAMILY_VALUE_TOO_LOW  = 1;
constant FAMILY_VALUE_TOO_HIGH = 4;

constant PORT_VALUE_VALID       = 5018;
constant PORT_VALUE_TOO_LOW     = -1;
constant PORT_VALUE_TOO_HIGH    = 65_536;

plan 4;

dies-ok &port-too-low,    'Fails when port is too low';

dies-ok &port-too-high,   'Fails when port is too high';

dies-ok &family-too-low,  'Fails when family is too low';

dies-ok &family-too-high, 'Fails when family is too high';

done-testing;

sub port-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :localhost(HOST),
        :localport(PORT_VALUE_TOO_LOW),
    );
}

sub port-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :localhost(HOST),
        :localport(PORT_VALUE_TOO_HIGH),
    );
}

sub family-too-low() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :localhost(HOST),
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_LOW),
    );
}

sub family-too-high() {
    my $listen = IO::Socket::INET.new(
        :listen,
        :localhost(HOST),
        :localport(PORT_VALUE_VALID),
        :family(FAMILY_VALUE_TOO_HIGH),
    );
}
