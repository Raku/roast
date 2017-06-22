use v6;
use Test;

plan 32;

# L<S32::Containers/List/=item combinations>

is-deeply (1, 2, 3).combinations(1), ((1,), (2,), (3,)),
    "single-item combinations";
is-deeply (1, 2, 3).combinations(2), ((1, 2), (1, 3), (2, 3)),
    "two item combinations";
is-deeply (1, 2, 3).combinations(3), ((1,2,3),),
    "three items of a three-item list";

is-deeply (1, 2, 3).combinations(1..2), ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)),
    "1..2 items";
is-deeply (1, 2, 3).combinations(0..3),
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)), "0..3 items";
is-deeply (1, 2, 3).combinations(2..3), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "2..3 items";
is-deeply (1, 2, 3).combinations(0..0), ((),), "0..0 items";
is-deeply (1, 2, 3).combinations,
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)),
    'defaults to "powerset"';
is-deeply (1, 2, 3).combinations(2..4),
    ((1, 2), (1, 3), (2, 3), (1, 2, 3)), "2..4 items (range autofit)";
is-deeply (1, 2, 3).combinations(2..^5), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "2..^5 items (range autofit)";

# open end-points
is-deeply (1, 2, 3).combinations(1..^3),
    ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)), "1..^3 items";
is-deeply (1, 2, 3).combinations(-1^..3),
    ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)), "-1^..3 items";
is-deeply (1, 2, 3).combinations(1^..3), ((1, 2), (1, 3), (2, 3), (1, 2, 3)),
    "1^..3 items";
is-deeply (1, 2, 3).combinations(1^..^3), ((1, 2), (1, 3), (2, 3)), "1^..^3 items";

is-deeply combinations(3,2), ((0, 1), (0, 2), (1, 2)), "combinations function";
is-deeply combinations(3,0), ((),), "zero k combinations function";

 # Pathological cases
is-deeply (1, 2, 3).combinations(4), (),
    "combinations 4 items from 3 item list is empty";

is-deeply (1, 2, 3).combinations(1..0), (), "1..0 items is empty";
is-deeply (1, 2, 3).combinations(1^..0), (), "1^..0 items is empty";
is-deeply (1, 2, 3).combinations(1..^0), (), "1..^0 items is empty";
is-deeply (1, 2, 3).combinations(0^..0), (), "0^..0 items is empty";
is-deeply (1, 2, 3).combinations(0..^0), (), "0..^0 items is empty";
is-deeply (1, 2, 3).combinations(0^..^0), (), "0^..^0 items is empty";
is-deeply (1, 2, 3).combinations(-1..-2), (), "-1..-2 items is empty";
is-deeply (1, 2, 3).combinations(-2..-1), (), "-2..-1 items is empty";

is-deeply combinations(3,-1), (), "negative k combinations function is empty";
is-deeply combinations(3,4), (), "too high k combinations function is empty";

# RT #127778
{
    is-deeply combinations(-2,2), (),
        'negative $n in sub combinations (1)';
    is-deeply combinations(-9999999999999999999,2), (),
        'negative $n in sub combinations (2)';
    is-deeply combinations(2,-2), (),
        'negative $k in sub combinations gives empty list (1)';
    is-deeply combinations(-2,-2), (),
        'negative $k in sub combinations gives empty list (2)';
}

# RT #127779
subtest {
    plan 12;

    is-deeply combinations(  2, 0.5), ((),), 'Rat in $k';
    is-deeply combinations(0.5,   2), (),    'Rat in $n';
    is-deeply combinations(0.5, 0.5), ((),), 'Rat in $n and $k';

    is-deeply combinations( -2,  -0.5), ((),), 'Rat in $k (negatives)';
    is-deeply combinations(-0.5,   -2), (),    'Rat in $n (negatives)';
    is-deeply combinations(-0.5, -0.5), ((),), 'Rat in $n and $k (negatives)';

    is-deeply combinations(3, 2.5),   ((0, 1), (0, 2), (1, 2),),
        'Rat in $k (non-zero .Int)';
    is-deeply combinations(3.5, 2),   ((0, 1), (0, 2), (1, 2),),
        'Rat in $n (non-zero .Int)';
    is-deeply combinations(3.5, 2.5), ((0, 1), (0, 2), (1, 2),),
        'Rat in $n and $k (non-zero .Int)';

    is-deeply combinations(3.5e0, 2.5e0),  ((0, 1), (0, 2), (1, 2),),
        'Num in $n and $k';
    is-deeply combinations(|<3.5 2e0>),     ((0, 1), (0, 2), (1, 2),),
        'RatStr/NumStr in $n and $k';
    is-deeply combinations(3.5+0i, 2.5+0i), ((0, 1), (0, 2), (1, 2),),
        'Complex in $n and $k';
}, 'Non-Int values in combinations';
