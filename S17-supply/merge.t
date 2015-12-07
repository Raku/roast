use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;
        tap-ok $s1.Supply.merge($s2.Supply),
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

    tap-ok Supply.merge(
      Supply.from-list(1..5), Supply.from-list(6..10), Supply.from-list(11..15)
     ),
      [1..15], "merging 3 supplies works", :sort;

    {
        my $s = Supply.from-list(1..10);
        my $m = Supply.merge($s);
        ok $s === $m, "merging one supply is a noop";
        tap-ok $m, [1..10], "noop merge";
    }

    throws-like( { Supply.merge(42) },
      X::Supply::Combinator, combinator => 'merge' );
}

# vim: ft=perl6 expandtab sw=4
