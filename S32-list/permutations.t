use v6;
use Test;

plan 10;

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

# https://github.com/Raku/old-issue-tracker/issues/5195
is-deeply permutations(-1), ((),).Seq, '&permutations with negative argument';

subtest '&permutations with Iterable first argument match calls with method form' => {
    plan +my @i := do with <a b c>.Seq { .cache; $_ }, <a b c>, [<a b c>],
        2..4, 2^..4, 2^..^4, 2..^4,
        %(:42foo, :70bar, :12ber), Map.new: (:42foo, :70bar, :12ber);

    is-deeply permutations($_).sort, .permutations.sort, .raku for @i;
}

# vim: expandtab shiftwidth=4
