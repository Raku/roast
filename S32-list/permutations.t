use Test;

plan 2;

# L<S32::Containers/List/=item permutations>

is_deeply [[1, 2, 3].permutations], [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]], "permutations method";
is_deeply [permutations(3)], [[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0]], "permutations function";
