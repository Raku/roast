use v6;

use Test;

plan 5;

dies_ok { Supply.list }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

{
        my @a;
        for Supply.from-list(2..6).list { @a.push($_) };
        is-deeply @a, [2..6], "Supply.list works in for";
        my @b = Supply.from-list(42..50).list;
        is-deeply @b, [42..50], "Supply.list can be stored in array";
}
}
