use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 9;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.last }, 'can not be called as a class method';
#?rakudo todo "we don't have Natural numbers yet"
dies_ok { Supply.new.last(0) }, 'cannot have 0 last';
dies_ok { Supply.new.last("foo") }, 'cannot have "foo" last';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for(1..10).last, [10], "the last one works";
    tap_ok Supply.for(1..10).last(5), [6..10], "the last five works";
    tap_ok Supply.for(1..10).last(15), [1..10], "the last 15 works";
}
