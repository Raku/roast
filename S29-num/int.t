use v6;
use Test;
plan 61;

# L<S29/Num/"=item truncate">
# truncate and int() are synonynms. 
# Possibly more tests for truncate should be added here, too. 

=begin pod

Basic tests for the int() builtin

=end pod

# basic sanity:
is(-0, 0, '-0 is the same as 0 - hey, they are integers ;-)');

is(int(-1), -1, "int(-1) is -1");
is(int(0), 0, "int(0) is 0");
is(int(1), 1, "int(1) is 1");
is(int(3.14159265), 3, "int(3.14159265) is 3");
is(int(-3.14159265), -3, "int(-3.14159265) is -3");

is(int(0.999), 0, "int(0.999) is 0");
is(int(0.51), 0, "int(0.51) is 0");
is(int(0.5), 0, "int(0.5) is 0");
is(int(0.49), 0, "int(0.49) is 0");
is(int(0.1), 0, "int(0.1) is 0");
is(int(0.1).WHAT, 'Int', 'int(0.1) returns an Int');

is(int(-0.999), 0, "int(-0.999) is 0");
is(int(-0.51),  0, "int(-0.51) is 0");
is(int(-0.5),   0, "int(-0.5) is 0");
is(int(-0.49),  0, "int(-0.49) is 0");
is(int(-0.1),   0, "int(-0.1) is 0");
is(int(-0.1).WHAT, 'Int', 'int(-0.1) returns an Int');

is(int(1.999), 1, "int(1.999) is 1");
is(int(1.51), 1, "int(1.51) is 1");
is(int(1.5), 1, "int(1.5) is 1");
is(int(1.49), 1, "int(1.49) is 1");
is(int(1.1), 1, "int(1.1) is 1");

is(int(-1.999), -1, "int(-1.999) is -1");
is(int(-1.51), -1, "int(-1.51) is -1");
is(int(-1.5), -1, "int(-1.5) is -1");
is(int(-1.49), -1, "int(-1.49) is -1");
is(int(-1.1), -1, "int(-1.1) is -1");

is(int('-1.999'), -1, "int('-1.999') is -1");
is(int('0x123'), 0x123, "int('0x123') is 0x123");
is(int('0d456'), 0d456, "int('0d456') is 0d456");
is(int('0o678'), 0o67, "int('0o678') is 0o67");
is(int('3e4d5'), 3e4, "int('3e4d5') is 3e4");

{
    sub __int( $s ) {
        my $pos = $s.index('.');
        if ($pos > 0) { return substr($s, 0, $pos); }
        return $s;
    };

    # Check the defaulting to $_ 

    for 0, 0.0, 1, 50, 60.0, 99.99, 0.4, 0.6, -1, -50, -60.0, -99.99 {
        my $int = __int($_);
        is(.int, $int, "integral value for $_ is $int");
        isa_ok(.int, "Int");
    }
}

#?DOES 1
# Special values
is(int(1.9e3), 1900, "int 1.9e3 is 1900");
#?pugs 3 todo 'bug'
#?rakudo 3 skip 'Inf and NaN not yet implemented'
is(int(Inf),    Inf, "int Inf is Inf");
is(int(-Inf),  -Inf, "int -Inf is -Inf");
is(int(NaN),    NaN, "int NaN is NaN");

# vim: ft=perl6
