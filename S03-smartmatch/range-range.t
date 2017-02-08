use v6;
use Test;
plan 19;

#L<S03/Smart matching/Range Range subset range>
{
    # .bounds.all ~~ X (mod ^'s)
    # means:
    # check whether both .min and .max are inside of the Range X
    # (though this is only true to a first approximation, as
    # those .min and .max values might be excluded)

    is-deeply 2..3 ~~ 1..4,     True,  'proper inclusion +';
    is-deeply 1..4 ~~ 2..3,     False, 'proper inclusion -';
    is-deeply 2..4 ~~ 1..4,     True,  'inclusive vs inclusive right end';
    is-deeply 2..^4 ~~ 1..4,    True,  'exclusive vs inclusive right end';
    is-deeply 2..4 ~~ 1..^4,    False, 'inclusive vs exclusive right end';
    is-deeply 2..^4 ~~ 1..^4,   True,  'exclusive vs exclusive right end';
    is-deeply 2..3 ~~ 2..4,     True,  'inclusive vs inclusive left end';
    is-deeply 2^..3 ~~ 2..4,    True,  'exclusive vs inclusive left end';
    is-deeply 2..3 ~~ 2^..4,    False, 'inclusive vs exclusive left end';
    is-deeply 2^..3 ~~ 2^..4,   True,  'exclusive vs exclusive left end';
    is-deeply 2..3 ~~ 2..3,     True,  'inclusive vs inclusive both ends';
    is-deeply 2^..^3 ~~ 2..3,   True,  'exclusive vs inclusive both ends';
    is-deeply 2..3 ~~ 2^..^3,   False, 'inclusive vs exclusive both ends';
    is-deeply 2^..^3 ~~ 2^..^3, True,  'exclusive vs exclusive both ends';
}

is-deeply '2'..'3' ~~ 0..10,    True, "Can smart match string Range's which hold numbers and Ranges which are numbers";
is-deeply 1..Inf ~~ -1/0..1/0,  True, "Can smart match Range's 1..Inf and -1/0..1/0";
is-deeply 1..Inf ~~  1/0, True, "Can smart match Range 1..Inf and 1/0";
#?rakudo todo "Can't smart match two Ranges with numbers on left side and strings on right"
# RT 30745
is-deeply '0'..'3' ~~ 0..9,     True, "Can smart match string Range's with strings on left and numbers on right";
is-deeply '0'..'9' ~~ 0..3,     True, "Can smart match string Range's with numbers on left and strings on right";

# vim: ft=perl6
