use v6;

use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped.

=end description

plan 10;

my $ref = { val => 42 };
isa_ok($ref, Hash);
#?rakudo todo "die or fail?"
#?niecza todo "questionable test"
dies_ok { $ref[0] }, 'Hash !~~ Positional';

{
    $ref = [ 42 ];
    isa_ok($ref, Array);
    #?niecza skip "Failure NYI"
    ok( $ref<0> ~~ Failure, 'Accessing an array as a hash fails');
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
