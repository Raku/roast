use v6;
use Test;
plan 2;

# test relation between attributes and inheritance

class A {
    has $.a;
}

class B is A {
    method accessor {
        return $.a
    }
}

my $o;
lives_ok {$o = B.new(a => 'blubb') }, 'Can initialize inherited attribute';
is $o.accessor, 'blubb',              'accessor can use inherited attribute';

# vim: ft=perl6
