use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 3;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.flat }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for( [1,2],[3,4,5] ).flat,
      [1..5], "On demand publish with flat";
}
