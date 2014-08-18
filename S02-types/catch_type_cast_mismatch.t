use v6;

use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped.

=end description

plan 11;

my $ref = { val => 42 };
isa_ok($ref, Hash);
nok $ref ~~ Positional, "It's not a positional";
cmp_ok $ref, '===', $ref[0], 'So [0] returns itself';

{
    $ref = [ 42 ];
    isa_ok($ref, Array);
    #?niecza skip "Failure NYI"
    throws_like { EVAL '$ref<0>' }, X::AdHoc, 'Accessing array as hash fails';
}

# Also test that scalars give up their container types - this time a
# regression in rakudo

{
    # scalar -> arrayref and back
    my $x = 2;
    lives_ok { $x = [0] }, 'Can assign an arrayref to a scalar';
    my $y = [0];
    lives_ok { $y = 3   }, 'Can assign a number to scalar with an array ref';
}

{
    # scalar -> hashref and back
    my $x = 2;
    lives_ok { $x = {a => 1} }, 'Can assign an hashref to a scalar';
    my $y = { b => 34 };
    lives_ok { $y = 3   },   'Can assign a number to scalar with an hashref';
}

{
    # hash -> array and back
    my $x = [0, 1];
    lives_ok { $x = { a => 3 } }, 'can assign hashref to scalar that held an array ref';
    my $y = { df => 'dfd', 'ui' => 3 };
    lives_ok { $y = [0, 7] }, 'can assign arrayref to scalar that held an hashref';
}

# vim: ft=perl6
