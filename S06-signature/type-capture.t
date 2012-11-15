use v6;
use Test;

plan 8;

# TODO: move to S02?
# L<S02/Generic types/>

# Check it captures built-in types.
sub basic_capture(::T $x) { T }   #OK not used
isa_ok(basic_capture(42),  Int, 'captured built-in type');
isa_ok(basic_capture(4.2), Rat, 'captured built-in type');

# User defined ones too.
class Foo { }
isa_ok(basic_capture(Foo.new), Foo, 'captured user defined type');

# Check you can use captured type later in the signature.
sub two_the_same(::T $x, T $y) { 1 }   #OK not used
ok(two_the_same(42, 42), 'used captured type later in the sig');
my $ok = 1;
try {
    two_the_same(42, 4.2);
    $ok = 0;
}
ok($ok, 'used captured type later in the sig');

# Check you can use them to declare variables.
sub declare_cap_type(::T $x) {   #OK not used
    my T $y = 4.2;   #OK not used
    1
}
#?rakudo skip 'nom regression'
ok(declare_cap_type(3.3), 'can use captured type in declaration');
$ok = 1;
try {
    declare_cap_type(42);
    $ok = 0;
}
ok($ok, 'can use captured type in declaration');

#RT #114216
eval_lives_ok q':(::T $x)', "No error on type capture";
# vim: ft=perl6
