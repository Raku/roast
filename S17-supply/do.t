use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.do({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $seen;
        tap_ok Supply.for(1..10).do( {$seen++} ),
          [1..10], ".do worked";
        is $seen, 10, "did the side effect work";
    }
}
