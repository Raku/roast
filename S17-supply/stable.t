use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.stable(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

#?rakudo skip "doesn't work or can't test"
{
        my $s = Supply.new;
        tap_ok $s.stable(2),
          [1,4],
          ".stable worked",
          :after-tap( {
               $s.more(1);
               sleep 1;
               $s.more(1);
               sleep 1;
               $s.more(2);
               $s.more(3);
               sleep 1;
               $s.more(4);
               $s.done;
          } ),
          :live;
}

    {
        my $for   = Supply.for(1..10);
        my $stable = $for.stable(0);
        ok $for === $stable, "stable by 0 is a noop";
        tap_ok $stable, [1..10], "noop stable";
    }
}
