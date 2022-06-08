use v6;
use Test;

# L<S06/Parameters and arguments>
# TODO: better smart-linking

plan 12;

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
        $x++ for $a.list;
        return $x;
    }

    is count2((1,2,3)),           3, 'count2((1,2,3))';
}

{
    sub pa(@a) { @a.WHAT; }
    my @b = 2, 3;
    isa-ok pa(@b), Array, 'basic array type sanity';
    dies-ok { EVAL('pa(3)') }, 'non-slurpy array does not take a single Int';

    sub ph(%h) { 1 }   #OK not used
    dies-ok { EVAL('ph(3)') }, 'an Int is not a Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/605
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

# A Rakudo regression

{
    sub ro_a(@a) { };   #OK not used
    sub ro_b(@a) { ro_a(@a) };
    my @x = 1, 2, 4;
    lives-ok { ro_b(@x) },   'can pass parameter Array on to next function';
    lives-ok { @x = 5, 6 }, '... and that did not make the caller Array ro';
}

# Positional Bind Failover
# https://github.com/rakudo/rakudo/issues/4864
subtest "Positional Bind Failover" => {
    #| @-siglled
    my sub pos_a(@a) { @a.List }
    #| Positional-typed
    my sub pos_p(Positional $p) { $p.List }
    #| List-typed
    my sub pos_l(List $l) { $l }

    my @data = ((1...10), (1..10).hyper, (1..10).race);

    for &pos_a, &pos_p, &pos_l -> &pbf {
        subtest "PBF on {&pbf.WHY}" => {
            for @data -> $seq {
                my $out;
                subtest $seq.^name ~ " argument" => {
                    #?rakudo 2 todo "unclear whether this is valid behaviour"
                    lives-ok { $out = pbf($seq) }, "argument is accepted";
                    is-deeply $out, (1..10).List, "parameter value";
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
