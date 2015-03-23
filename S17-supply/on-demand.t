use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

dies_ok { Supply.new.on-demand(1..10) }, 'can not be called as an instance method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supply.on-demand( -> \s { s.emit($_) for 1..10; s.done } );
        tap_ok $s, [1..10], :!live, "On demand publish worked";
        tap_ok $s, [1..10], :!live, "Second tap gets all the values";

        ok $s.Supply === $s, '.Supply on a Supply is a noop';
    }
}
