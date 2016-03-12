use v6;
use Test;

plan 2;

# L<S32::Containers/List/=item permutations>

is (1, 2, 3).permutations.list.perl, ((1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)).perl, "permutations method";
is permutations(3).list.perl, ((0, 1, 2), (0, 2, 1), (1, 0, 2), (1, 2, 0), (2, 0, 1), (2, 1, 0)).perl, "permutations function";
