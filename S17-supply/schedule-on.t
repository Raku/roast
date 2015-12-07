use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

dies-ok { Supply.schedule-on($*SCHEDULER) },
  'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $other_scheduler = CurrentThreadScheduler.new;
        ok $other_scheduler ~~ Scheduler, 'did we get a Scheduler';
        my $master = Supplier.new;

        tap-ok $master.Supply.schedule-on($other_scheduler),
          [1,2,3],
          'did we get the original values',
          :live,
          :after-tap( {
            $master.emit(1);
            $master.emit(2);
            $master.emit(3);
            $master.done;
          } );
    }
}

# vim: ft=perl6 expandtab sw=4
