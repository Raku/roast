use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

dies_ok { Supply.grep({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps with a Callable works";

    tap_ok Supply.from-list(1..10,"a".."z").grep(Int),
      [1..10],
      "grepping taps with a Type works";

    tap_ok Supply.from-list("a".."z").grep(/<[a..e]>/),
      ["a".."e"],
      "grepping taps with a Regex works";
}
