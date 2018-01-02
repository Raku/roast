use v6;
use Test;

plan 9;

# L<S32::Containers/List/=item permutations>

is-deeply (1, 2, 3).permutations,
    ((1, 2, 3), (1, 3, 2), (2, 1, 3), (2, 3, 1), (3, 1, 2), (3, 2, 1)).Seq, 'permutations method';
is-deeply permutations(3),
    ((0, 1, 2), (0, 2, 1), (1, 0, 2), (1, 2, 0), (2, 0, 1), (2, 1, 0)).Seq, 'permutations function';

is-deeply (1,).permutations, ((1,),).Seq, 'method on single-element list';
is-deeply ()  .permutations, ((),)  .Seq, 'method on empty list';
is-deeply permutations(1),   ((0,),).Seq, 'sub with 1 for its argument';
is-deeply permutations(0),   ((),)  .Seq, 'sub with 0 for its argument';

is-deeply +().permutations, 1, 'there is 1 .permutation of empty list';
is-deeply +permutations(0), 1, 'there is 1 &permutation with 0 values';

# RT #127777
is-deeply permutations(-1), ((),).Seq, '&permutations with negative argument';
