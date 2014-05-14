use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 9;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.sort }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(10...1).sort, [1..10], "we can sort numbers";
    tap_ok Supply.for("z"..."a").sort, ["a" .. "z"], "we can sort strings";
    tap_ok Supply.for("a".."d", "A" .. "D").sort( {
        $^a.lc cmp $^b.lc || $^b cmp $^a
    } ), [<a A b B c C d D>], "we can sort in special ways";
}
