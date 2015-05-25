use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

dies-ok { Supply.stable(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

#?rakudo skip "doesn't work or can't test RT #124822"
{
        my $s = Supply.new;
        tap-ok $s.stable(2),
          [1,4],
          ".stable worked",
          :after-tap( {
               $s.emit(1);
               sleep 1;
               $s.emit(1);
               sleep 1;
               $s.emit(2);
               $s.emit(3);
               sleep 1;
               $s.emit(4);
               $s.done;
          } ),
          :live;
}

    {
        my $for   = Supply.from-list(1..10);
        my $stable = $for.stable(0);
        ok $for === $stable, "stable by 0 is a noop";
        tap-ok $stable, [1..10], "noop stable";
    }
}
