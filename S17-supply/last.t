use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 11;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.last }, 'can not be called as a class method';
#?rakudo todo "we don't have Natural numbers yet"
dies_ok { Supply.new.last(0) }, 'cannot have 0 last';
dies_ok { Supply.new.last("foo") }, 'cannot have "foo" last';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10).last, [10], "the last one works";
    tap_ok Supply.for(1..10).last(5), [6..10], "the last five works";
    tap_ok Supply.for(1..10).last(15), [1..10], "the last 15 works";
}
