use v6;

use Test;

plan 7;

dies_ok { Supply.list }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

#?rakudo.jvm skip "hangs"
{
        my @a;
        for Supply.for(2..6).list { @a.push($_) };
        is_deeply @a, [2..6], "Supply.list works in for";
        my @b = Supply.for(42..50).list;
        is_deeply @b, [42..50], "Supply.list can be stored in array";
}
}
