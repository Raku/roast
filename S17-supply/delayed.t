use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

dies-ok { Supply.delayed(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

#?rakudo skip "doesn't work or can't test RT #124826"
{
        my $delay = 2;
        my $now   = now;
        my $seen;
        tap-ok $now.Supply.delayed($delay),
          [$now],
          ".delay with on-demand Supply worked",
          :emit( { $seen = now } ),
        ;
        ok $seen && $seen >= $now + $delay, "on-demand sufficiently delayed";
}

#?rakudo skip "doesn't work or can't test RT #124827"
{
        my $delay = 2;
        my $s     = Supply.new;
        my $now   = now;
        my $seen;
        tap-ok $s.delayed($delay),
          [$now],
          ".delay with live Supply worked",
          :live,
          :emit( { $seen = now } ),
          :after-tap( {
              $s.emit($now);
              sleep 2;  # makes this pass, should go!
              $s.done;
          } ),
        ;
        ok $seen && $seen >= $now + $delay, "live sufficiently delayed";
}

    {
        my $for   = Supply.from-list(1..10);
        my $delay = $for.delayed(0);
        ok $for === $delay, "delaying by 0 is a noop";
        tap-ok $delay, [1..10], "noop delay";
    }
}
