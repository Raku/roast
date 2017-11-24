use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Tap;

plan 7;

dies-ok { Supplier.new.Supply.on-demand(1..10) }, 'can not be called as an instance method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supply.on-demand( -> \s { s.emit($_) for 1..10; s.done } );
        tap-ok $s, [1..10], :!live, "On demand publish worked";
        tap-ok $s, [1..10], :!live, "Second tap gets all the values";

        ok $s.Supply === $s, '.Supply on a Supply is a noop';
    }
}

# vim: ft=perl6 expandtab sw=4
