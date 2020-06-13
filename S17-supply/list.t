use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

is-eqv Supply.list, (Supply,), 'can list a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @a;
    for Supply.from-list(2..6).list { @a.push($_) };
    is-deeply @a, [2..6], "Supply.list works in for";
    my @b = Supply.from-list(42..50).list;
    is-deeply @b, [42..50], "Supply.list can be stored in array";
    isa-ok Supply.from-list(2..6)   .list, List, "Supply.list should return a List";
    isa-ok Supply.from-list(42..50) .list, List, "Supply.list should return a List";
}

# vim: expandtab shiftwidth=4
