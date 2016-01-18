use Test;

plan 4;

# L<S32::Containers/List/=item permutations>

is (1, 2, 3).permutations.list.perl, ((1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)).perl, "permutations method";
is permutations(3).list.perl, ((0, 1, 2), (0, 2, 1), (1, 0, 2), (1, 2, 0), (2, 0, 1), (2, 1, 0)).perl, "permutations function";

is (1,).permutations.list.perl, ((1,),).perl, "permutations method on single element list";
is permutations(1).list.perl, ((0,),).perl, "permutations function with 1 for its argument";
