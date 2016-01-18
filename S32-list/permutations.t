use Test;

plan 8;

# L<S32::Containers/List/=item permutations>

is (1, 2, 3).permutations.list.perl, ((1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)).perl, "permutations method";
is permutations(3).list.perl, ((0, 1, 2), (0, 2, 1), (1, 0, 2), (1, 2, 0), (2, 0, 1), (2, 1, 0)).perl, "permutations function";

is (1,).permutations.list.perl, ((1,),).perl, "permutations method on single element list";
is permutations(1).list.perl, ((0,),).perl, "permutations function with 1 for its argument";

is ().permutations.list.perl, ((),).perl, "permutations method on empty list";
is permutations(0).list.perl, ((),).perl, "permutations function with 0 for its argument";

is +().permutations, 1, "there is 1 permutation of empty list";
is +permutations(0), 1, "there is 1 permutation with 0 values";
