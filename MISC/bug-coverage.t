use v6.c;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# This file is for random bugs that don't really fit well in other places.
# Feel free to move the tests to more appropriate places.

plan 1;

subtest '.count-only/.bool-only for iterated content' => {
    plan 2;

    sub iters {                                    # values / desc
        <a b c>.iterator                        => [3, 'List.iterator'],
        <a b c>.reverse.iterator                => [3, 'List.reverse.iterator'],
        [<a b c>].iterator                      => [3, 'Array.iterator'],
        Buf.new(1, 2, 3).iterator               => [3, 'Buf.iterator'],
        %(:42foo, :70bar, :2meow).keys.iterator => [3, 'Hash.keys.iterator'],
        %(:42foo, :70bar).kv.iterator           => [4, 'Hash.kv.iterator'],
        combinations(4,1).iterator              => [4, 'Combinations'],
        permutations(2).iterator                => [2, 'Permutations'],
        :42foo.iterator                         => [1, 'Pair.iterator'],
        :42foo.kv.iterator                      => [2, 'Pair.kv.iterator'],
    }

    subtest '.count-only' => {
        plan +my @iters = iters;
        for @iters -> (:key($iter), :value(($count, $desc))) {
            unless $iter.^can: 'count-only' {
                skip '.count-only is not implemented';
                next;
            }

            subtest $desc => {
                plan 2 + $count;
                cmp-ok $iter.count-only, '==', $count, 'before iterations';
                for 1..$count -> $iteration {
                    $iter.pull-one;
                    cmp-ok $iter.count-only, '==', $count - $iteration,
                        "iteration $iteration";
                }
                $iter.pull-one;
                cmp-ok $iter.count-only, '==', 0,
                    "one more pull, after all iterations";
            }
        }
    }

    subtest '.bool-only' => {
        plan +my @iters = iters;
        for @iters -> (:key($iter), :value(($count, $desc))) {
            unless $iter.^can: 'bool-only' {
                skip '.bool-only is not implemented';
                next;
            }

            subtest $desc => {
                plan 2 + $count;
                ok $iter.bool-only, 'before iterations';
                for 1..$count -> $iteration {
                    $iter.pull-one;
                    is-deeply $iter.bool-only, so($count - $iteration),
                        "iteration $iteration";
                }
                $iter.pull-one;
                nok $iter.count-only, "one more pull, after all iterations";
            }
        }
    }
}

# vim: expandtab shiftwidth=4 ft=perl6
