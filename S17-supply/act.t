use v6;

use Test;

plan 9;

dies-ok { Supply.act({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my @seen;
        my $tap = Supply.from-list(1..10).act( { @seen.push($_) } );
        isa-ok $tap, Tap, 'we got a Tap';
        sleep .1 until @seen == 10;
        is-deeply @seen, [1..10], 'we got all of the values';
    }

    {
         my $s = Supplier.new;
         my $done = False;
         $s.Supply.act: -> $ { }, done => { $done = True };
         $s.emit(42);
         nok $done, 'done callback does not fire before done event';
         $s.done;
         ok $done, 'done callback fires on done event';
    }
}
