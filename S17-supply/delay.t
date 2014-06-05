use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.delay(1) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

#?rakudo skip "doesn't work or can't test"
{
        my $delay = 2;
        my $now   = now;
        my $seen;
        tap_ok $now.Supply.delay($delay),
          [$now],
          ".delay with on-demand Supply worked",
          :more( { $seen = now } ),
        ;
        ok $seen && $seen >= $now + $delay, "on-demand sufficiently delayed";
}

#?rakudo skip "doesn't work or can't test"
{
        my $delay = 2;
        my $s     = Supply.new;
        my $now   = now;
        my $seen;
        tap_ok $s.delay($delay),
          [$now],
          ".delay with live Supply worked",
          :live,
          :more( { $seen = now } ),
          :after-tap( {
              $s.more($now);
              sleep 2;  # makes this pass, should go!
              $s.done;
          } ),
        ;
        ok $seen && $seen >= $now + $delay, "live sufficiently delayed";
}

    {
        my $for   = Supply.for(1..10);
        my $delay = $for.delay(0);
        ok $for === $delay, "delaying by 0 is a noop";
        tap_ok $delay, [1..10], "noop delay";
    }
}
