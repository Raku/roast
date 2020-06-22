use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 4;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

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

# vim: expandtab shiftwidth=4
