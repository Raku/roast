use v6;

use Test;

plan 9;

is-deeply Supply.list, (Supply,).Seq, 'can list a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    my @a;
    for Supply.from-list(2..6).list { @a.push($_) };
    is-deeply @a, [2..6], "Supply.list works in for";
    my @b = Supply.from-list(42..50).list;
    is-deeply @b, [42..50], "Supply.list can be stored in array";
    isa-ok Supply.from-list(2..6)   .list, List, "Supply.list should return a List";
    isa-ok Supply.from-list(42..50) .list, List, "Supply.list should return a List";
}

# vim: ft=perl6 expandtab sw=4
