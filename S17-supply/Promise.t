use v6;

use Test;

plan 13;

dies-ok { Supply.Promise }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s  = Supplier.new;
        my $p1 = $s.Supply.Promise;
        isa-ok $p1, Promise, 'we got a Promise';
        is $p1.status, Planned, 'Promise still waiting';
        $s.emit(42);
        is $p1.status, Planned, 'Promise is still Planned after emit';

        $s.emit(43);
        $s.done();
        is $p1.status, Kept, 'Promise is kept after done';
        is $p1.result, 43, 'got last emitted value';

        $s = Supplier.new;
        my $p2 = $s.Supply.Promise;
        $s.quit('oops');
        is $p2.status, Broken, 'Promise is broken after quit';
    }
}
