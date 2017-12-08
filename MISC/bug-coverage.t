use v6.c;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 1;

subtest '.count-only accounts for iterated content' => {
    plan 10;

    subtest 'List.iterator' => {
        plan 6;
        with <a b c>.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'List.reverse.iterator' => {
        plan 6;
        with <a b c>.reverse.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';

        }
    }

    subtest 'Array.iterator' => {
        plan 6;
        with [<a b c>].iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Buf.iterator' => {
        plan 6;
        with Buf.new(1, 2, 3).iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Hash.keys' => {
        plan 6;
        with %(:42foo, :70bar, :10bar, :2meow).keys.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Hash.kv' => {
        plan 7;
        with %(:42foo, :70bar).keys.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 4, 'initial';
                .pull-one; cmp-ok .count-only, '==', 3, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 2, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '3rd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '4th iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 5 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Combinations' => {
        plan 6;
        with combinations(4,1).iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 3, 'initial';
                .pull-one; cmp-ok .count-only, '==', 2, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 1, '2nd iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '3rd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 4 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Permutations' => {
        plan 5;
        with permutations(2).iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 2, 'initial';
                .pull-one; cmp-ok .count-only, '==', 1, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '2nd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 3 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Pair' => {
        plan 4;
        with :42foo.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 1, 'initial';
                .pull-one; cmp-ok .count-only, '==', 0, '1st iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 2 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }

    subtest 'Pair.kv' => {
        plan 5;
        with :42foo.kv.iterator {
            .^can('bool-only') ?? ok .bool-only, '.bool-only before iterations'
                               !! skip '.bool-only not implemented';

            if .^can: 'count-only' {
                cmp-ok .count-only, '==', 2, 'initial';
                .pull-one; cmp-ok .count-only, '==', 1, '1st iteration';
                .pull-one; cmp-ok .count-only, '==', 0, '2nd iteration';
            }
            else { .sink-all; skip '.count-only is not implemented', 3 }

            .^can('bool-only') ?? nok .bool-only, '.bool-only after iterations'
                               !! skip '.bool-only not implemented';
        }
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
