use v6;
use Test;

plan 13;

# L<S32::Containers/List/=item combinations>

is (1, 2, 3).combinations(1).list.perl, ((1,), (2,), (3,)).perl, "single-item combinations";
is (1, 2, 3).combinations(2).list.perl, ((1, 2), (1, 3), (2, 3)).perl, "two item combinations";
is (1, 2, 3).combinations(3).list.perl, ((1,2,3),).perl, "three items of a three-item list";

is (1, 2, 3).combinations(1..2).list.perl, ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)).perl, "1..2 items";
is (1, 2, 3).combinations(0..3).list.perl, ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, "0..3 items";
is (1, 2, 3).combinations(2..3).list.perl, ((1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, "2..3 items";
is (1, 2, 3).combinations.list.perl, ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, 'defaults to "powerset"';

is combinations(3,2).list.perl, ((0, 1), (0, 2), (1, 2)).perl, "combinations function";

# RT #127778
{
    is combinations(-2,2).list.perl, ((),).perl,
        'negative $n in sub combinations (1)';
    is combinations(-9999999999999999999,2).list.perl, ((),).perl,
        'negative $n in sub combinations (2)';
    is combinations(2,-2).list.perl, ().perl,
        'negative $k in sub combinations gives empty list (1)';
    is combinations(-2,-2).list.perl, ().perl,
        'negative $k in sub combinations gives empty list (2)';
}

# RT #127779
subtest {
    plan 12;

    is combinations(  2, 0.5), ((),), 'Rat in $k';
    is combinations(0.5,   2), ((),), 'Rat in $n';
    is combinations(0.5, 0.5), ((),), 'Rat in $n and $k';

    is combinations( -2,  -0.5), ((),), 'Rat in $k (negatives)';
    is combinations(-0.5,   -2), ((),), 'Rat in $n (negatives)';
    is combinations(-0.5, -0.5), ((),), 'Rat in $n and $k (negatives)';
    
    is combinations(3, 2.5),   ((0, 1), (0, 2), (1, 2),),
        'Rat in $k (non-zero .Int)';
    is combinations(3.5, 2),   ((0, 1), (0, 2), (1, 2),),
        'Rat in $n (non-zero .Int)';
    is combinations(3.5, 2.5), ((0, 1), (0, 2), (1, 2),),
        'Rat in $n and $k (non-zero .Int)';
        
    is combinations(3.5e0, 2.5e0),  ((0, 1), (0, 2), (1, 2),),
        'Num in $n and $k';
    is combinations(|<3.5 2e0>),     ((0, 1), (0, 2), (1, 2),),
        'RatStr/NumStr in $n and $k';
    is combinations(3.5+0i, 2.5+0i), ((0, 1), (0, 2), (1, 2),),
        'Complex in $n and $k';
}, 'Non-Int values in combinations';
