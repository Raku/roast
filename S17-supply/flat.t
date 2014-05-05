use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.flat }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for( [1,2],[3,4,5] ).flat,
      [1..5], "On demand publish with flat";
}
