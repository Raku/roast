use v6.c;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

dies-ok { Supply.produce( {...} ) }, 'can not be called as a class method';
dies-ok { Supplier.new.Supply.produce(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..5).produce( {$^a + $^b} ), [1,3,6,10,15],
      "simple produce works";
    tap-ok Supply.from-list(42).produce( {$^a * $^b} ), [42],
      "minimal produce works";
    tap-ok Supply.from-list("a".."e").produce(&infix:<~>),
      [<a ab abc abcd abcde>],
      "producing with concatenate works";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.produce( &infix:<(+)> ),
        [
          {a =>  1, b => 2},
          (a =>  1, b => 4, c => 42).Bag,
          (a => 13, b => 4, c => 42, e => 10).Bag,
        ],
        "producing bag union works",
#        :live,
        :after-tap( {
            $s.emit( { a =>  1, b => 2 } );
            $s.emit( { c => 42, b => 2 } );
            $s.emit( { a => 12, e => 10 } );
            $s.done;
        } );
    }
}

# vim: ft=perl6 expandtab sw=4
