use v6;
use Test;

# L<S06/Parameters and arguments>
# TODO: better smart-linking

plan 9;

{
    sub count(@a) {
        my $x = 0;
        $x++ for @a;
        return $x;
    }

    is count([1, 2, 3, 4]),       4, 'count([1, 2, 3, 4])';
    is count(my @b = 1, 2, 3, 4), 4, 'count(my @b = 1, 2, 3)';
    is count((1, 2, 3)),          3, 'count((1, 2, 3))';

    sub count2($a) {
        my $x = 0;
        $x++ for $a;
        return $x;
    }

    is count2((1,2,3)),           1, 'count2((1,2,3))';
}

{
    sub pa(@a) { @a.WHAT; }
    my @b = 2, 3;
    isa_ok pa(@b), Array, 'basic array type sanity';
    dies_ok { pa(3) }, 'non-slurpy array does not take a single Int';

    sub ph(%h) { 1 }
    dies_ok { ph(3) }, 'an Int is not a Hash';
}

# this used to be a rakudobug, RT #62172
{
    my @a = 1..8;
    sub t1(@a) { return +@a };
    sub t2(@a) { return t1(@a) };
    is t2(@a), 8, 'can pass arrays through multiple subs';
}

{
    sub test_two_array(@a,@b)
    {
        return @a[0] + @b[0];
    }

    is(test_two_array([100,5],[20,300]), 120, 
    "Passing array references to functions accepting arrays works.");
}
