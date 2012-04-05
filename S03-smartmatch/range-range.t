use v6;
use Test;
plan 14;

#L<S03/Smart matching/Range Range subset range>
{
    # .bounds.all ~~ X (mod ^'s)
    # means:
    # check whether both .min and .max are inside of the Range X
    # (though this is only true to a first approximation, as
    # those .min and .max values might be excluded)

    ok  (2..3 ~~ 1..4),     'proper inclusion +';
    ok !(1..4 ~~ 2..3),     'proper inclusion -';
    ok  (2..4 ~~ 1..4),     'inclusive vs inclusive right end';
    ok  (2..^4 ~~ 1..4),    'exclusive vs inclusive right end';
    ok !(2..4 ~~ 1..^4),    'inclusive vs exclusive right end';
    ok  (2..^4 ~~ 1..^4),   'exclusive vs exclusive right end';
    ok  (2..3 ~~ 2..4),     'inclusive vs inclusive left end';
    ok  (2^..3 ~~ 2..4),    'exclusive vs inclusive left end';
    ok !(2..3 ~~ 2^..4),    'inclusive vs exclusive left end';
    ok  (2^..3 ~~ 2^..4),   'exclusive vs exclusive left end';
    ok  (2..3 ~~ 2..3),     'inclusive vs inclusive both ends';
    ok  (2^..^3 ~~ 2..3),   'exclusive vs inclusive both ends';
    ok !(2..3 ~~ 2^..^3),   'inclusive vs exclusive both ends';
    ok  (2^..^3 ~~ 2^..^3), 'exclusive vs exclusive both ends';
}

done;

# vim: ft=perl6
