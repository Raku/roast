use v6;

use Test;

plan 13;

dies_ok { Supply.Promise }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s  = Supply.new;
        my $p1 = $s.Promise;
        isa_ok $p1, Promise, 'we got a Promise';
        is $p1.status, Planned, 'Promise still waiting';
        $s.more(42);
        is $p1.status, Kept, 'Promise is kept';
        is $p1.result, 42, 'got first mored value';

        my $p2 = $s.Promise;
        $s.more(43);
        $s.more(44);
        is $p2.result, 43, 'got second mored value';

        my $p3 = $s.Promise;
        $s.done;
        is $p3.status, Broken, 'Promise is broken';
    }
}
