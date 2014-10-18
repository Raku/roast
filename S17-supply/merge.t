use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 8;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;
        tap_ok $s1.merge($s2),
          [1,2,'a',3,'b'],
          "merging supplies works",
          :after-tap( {
              $s1.emit(1);
              $s1.emit(2);
              $s2.emit('a');
              $s1.emit(3);
              $s1.done();
              $s2.emit('b');
              $s2.done();
          } );
    }

    tap_ok Supply.merge(
      Supply.for(1..5), Supply.for(6..10), Supply.for(11..15)
     ),
      [1..15], "merging 3 supplies works", :sort;

    {
        my $s = Supply.for(1..10);
        my $m = Supply.merge($s);
        ok $s === $m, "merging one supply is a noop";
        tap_ok $m, [1..10], "noop rotor";
    }
}
