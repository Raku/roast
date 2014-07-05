use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.elems }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for(42..51).elems, [1..10], "just tracing elems works";

    {
        my $s = Supply.new;
        tap_ok $s.elems(1),
          [1,2,5],
          'works in 1 second increments',
#          :live,
          :after-tap( {
              sleep now.Int + 1 - now;  # start of next second
              $s.more(42); # fires
              sleep 1;
              $s.more(43); # fires
              $s.more(44);
              $s.more(45);
              sleep 1;
              $s.more(46); # fires
              $s.done;
          } );
    }
}
