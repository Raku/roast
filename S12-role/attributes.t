use v6;
use Test;
plan 2;

role R1 {
    has $!a1;
    has $.a2;
};

class C1 does R1 {
    method set_a1($val) {
        $!a1 = $val;
    }
    method get_a1 {
        $!a1
    }
};

my $x = C1.new();

$x.set_a1('abc');
is $x.get_a1,   'abc',      'Can set and get class-private attr from role';

$x.a2 = 'xyz';
is $x.a2,       'xyz',      'Public attribute gets accessor/mutator composed';

# vim: syn=perl6
