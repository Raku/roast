use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Tap;

plan 7;

is-deeply Supply.sort, (Supply,).Seq, 'can sort a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(10...1).sort, [1..10], "we can sort numbers";
    tap-ok Supply.from-list("z"..."a").sort, ["a" .. "z"], "we can sort strings";
    tap-ok Supply.from-list(flat("a".."d", "A" .. "D")).sort( {
        $^a.lc cmp $^b.lc || $^b cmp $^a
    } ), [<a A b B c C d D>], "we can sort in special ways";
}

# vim: ft=perl6 expandtab sw=4
