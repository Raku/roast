use Test;

plan 2;

# L<S32::Containers/List/=item permutations>

ok [[1, 2, 3].permutations] eqv [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]], "permutations method";
ok [permutations(3)] eqv [[0, 1, 2], [0, 2, 1], [1, 0, 2], [1, 2, 0], [2, 0, 1], [2, 1, 0]], "permutations function";
