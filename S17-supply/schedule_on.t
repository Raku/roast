use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 17;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.schedule_on($*SCHEDULER) },
  'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $other_scheduler = CurrentThreadScheduler.new;
        ok $other_scheduler ~~ Scheduler, 'did we get a Scheduler';
        my $master = Supply.new;
        ok $master ~~ Supply, 'Did we get a master Supply?';

        tap_ok $master.schedule_on($other_scheduler),
          [1,2,3],
          'did we get the original values',
          :live,
          :after-tap( {
            $master.more(1);
            $master.more(2);
            $master.more(3);
            $master.done;
          } );
    }
}
