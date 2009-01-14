use v6;
use Test;
plan 5;

# L<S12/Roles/"Roles may have attributes">

role R1 {
    has $!a1;
    has $.a2 is rw;
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


role R2 {
    has Int $!a;
}

eval_lives_ok 'class C2 does R2 { has Int $!a }', 'Same name, same type will not conflict';
#?rakudo skip 'test passes but Parrot bug gets in the way'
eval_dies_ok 'class C3 does R2 { has $!a }',      'Roles with conflicing attributes';

role R3 {
    has $.x = 42;
}
class C4 does R3 { }
is C4.new.x, 42, 'initializing attributes in a role works';

# vim: syn=perl6
