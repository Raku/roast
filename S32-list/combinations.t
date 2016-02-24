use v6;
use Test;

plan 8;

# L<S32::Containers/List/=item combinations>

is (1, 2, 3).combinations(1).list.perl, ((1,), (2,), (3,)).perl, "single-item combinations";
is (1, 2, 3).combinations(2).list.perl, ((1, 2), (1, 3), (2, 3)).perl, "two item combinations";
is (1, 2, 3).combinations(3).list.perl, ((1,2,3),).perl, "three items of a three-item list";

is (1, 2, 3).combinations(1..2).list.perl, ((1,), (2,), (3,), (1, 2), (1, 3), (2, 3)).perl, "1..2 items";
is (1, 2, 3).combinations(0..3).list.perl, ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, "0..3 items";
is (1, 2, 3).combinations(2..3).list.perl, ((1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, "2..3 items";
is (1, 2, 3).combinations.list.perl, ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3)).perl, 'defaults to "powerset"';

is combinations(3,2).list.perl, ((0, 1), (0, 2), (1, 2)).perl, "combinations function";
