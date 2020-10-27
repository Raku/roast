use v6;

use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped.

=end description

plan 11;

my $ref = { val => 42 };
isa-ok($ref, Hash);
nok $ref ~~ Positional, "It's not a positional";
cmp-ok $ref, '===', $ref[0], 'So [0] returns itself';

{
    $ref = [ 42 ];
    isa-ok($ref, Array);
    throws-like { EVAL '$ref<0>' }, Exception, 'Accessing array as hash fails';
}

# Also test that scalars give up their container types - this time a
# regression in rakudo

{
    # scalar -> arrayitem and back
    my $x = 2;
    lives-ok { $x = [0] }, 'Can assign an arrayitem to a scalar';
    my $y = [0];
    lives-ok { $y = 3   }, 'Can assign a number to scalar with an array ref';
}

{
    # scalar -> hashitem and back
    my $x = 2;
    lives-ok { $x = {a => 1} }, 'Can assign an hashitem to a scalar';
    my $y = { b => 34 };
    lives-ok { $y = 3   },   'Can assign a number to scalar with an hashitem';
}

{
    # hash -> array and back
    my $x = [0, 1];
    lives-ok { $x = { a => 3 } }, 'can assign hashitem to scalar that held an array ref';
    my $y = { df => 'dfd', 'ui' => 3 };
    lives-ok { $y = [0, 7] }, 'can assign arrayitem to scalar that held an hashitem';
}

# vim: expandtab shiftwidth=4
