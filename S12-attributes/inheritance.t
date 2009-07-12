use v6;
use Test;
plan 3;

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

class Artie61500 {
    has $!p = 61500;
}
#?rakudo todo 'RT #61500'
eval_dies_ok 'class Artay61500 is Artie61500 { method bomb { return $!p } }',
    'Compile error for subclass to access private attribute of parent';

# vim: ft=perl6
