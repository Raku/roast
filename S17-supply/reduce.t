use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

dies-ok { Supply.reduce( {...} ) }, 'can not be called as a class method';
dies-ok { Supplier.new.Supply.reduce(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..5).reduce( {$^a + $^b} ), [1,3,6,10,15],
      "simple reduce works";
    tap-ok Supply.from-list(42).reduce( {$^a * $^b} ), [42],
      "minimal reduce works";
    tap-ok Supply.from-list("a".."e").reduce(&infix:<~>),
      [<a ab abc abcd abcde>],
      "reducing with concatenate works";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.reduce( &infix:<(+)> ),
        [
          {a =>  1, b => 2},
          (a =>  1, b => 4, c => 42).Bag,
          (a => 13, b => 4, c => 42, e => 10).Bag,
        ],
        "reducing bag union works",
#        :live,
        :after-tap( {
            $s.emit( { a =>  1, b => 2 } );
            $s.emit( { c => 42, b => 2 } );
            $s.emit( { a => 12, e => 10 } );
        } );
    }
}
