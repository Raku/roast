use v6.c;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

dies-ok { Supply.elems }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(42..51).elems, [1..10], "just tracing elems works";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.elems(1),
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

# vim: ft=perl6 expandtab sw=4
