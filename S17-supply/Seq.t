use v6;

use Test;

plan 9;

is-deeply Supply.list, (Supply,).Seq, 'can list a Supply type object';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    my @a;
    for Supply.from-list(2..6).Seq { @a.push($_) };
    is-deeply @a, [2..6], "Supply.list works in for";
    my @b = Supply.from-list(42..50).Seq;
    is-deeply @b, [42..50], "Supply.list can be stored in array";
    isa-ok Supply.from-list(2..6)   .Seq, Seq, "Supply.Seq should return a Seq";
    isa-ok Supply.from-list(42..50) .Seq, Seq, "Supply.Seq should return a Seq";
}

# vim: expandtab shiftwidth=4
