use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

dies_ok { Supply.elems }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(42..51).elems, [1..10], "just tracing elems works";

    {
        my $s = Supply.new;
        tap_ok $s.elems(1),
          [1,2,5],
          'works in 1 second increments',
#          :live,
          :after-tap( {
              sleep now.Int + 1 - now;  # start of next second
              $s.emit(42); # fires
              sleep 1;
              $s.emit(43); # fires
              $s.emit(44);
              $s.emit(45);
              sleep 1;
              $s.emit(46); # fires
              $s.done;
          } );
    }
}
