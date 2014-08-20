use Test;

plan 8;

# L<S32::Containers/List/=item combinations>

is_deeply [[1, 2, 3].combinations(1)], [[1], [2], [3]], "single-item combinations";
is_deeply [[1, 2, 3].combinations(2)], [[1, 2], [1, 3], [2, 3]], "two item combinations";
is_deeply [[1, 2, 3].combinations(3)], [[1,2,3],], "three items of a three-item list";

is_deeply [[1, 2, 3].combinations(1..2)], [[1], [2], [3], [1, 2], [1, 3], [2, 3]], "1..2 items";
is_deeply [[1, 2, 3].combinations(0..3)], [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]], "0..3 items";
is_deeply [[1, 2, 3].combinations(2..3)], [[1, 2], [1, 3], [2, 3], [1, 2, 3]], "2..3 items";
is_deeply [[1, 2, 3].combinations], [[], [1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]], 'defaults to "powerset"';

is_deeply [combinations(3,2)], [[0, 1], [0, 2], [1, 2]], "combinations function";
