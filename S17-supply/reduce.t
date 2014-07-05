use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.reduce( {...} ) }, 'can not be called as a class method';
dies_ok { Supply.new.reduce(23) }, 'must be code if specified';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for(1..5).reduce( {$^a + $^b} ), [1,3,6,10,15],
      "simple reduce works";
    tap_ok Supply.for(42).reduce( {$^a * $^b} ), [42],
      "minimal reduce works";
    tap_ok Supply.for("a".."e").reduce(&infix:<~>),
      [<a ab abc abcd abcde>],
      "reducing with concatenate works";

    {
        my $s = Supply.new;
        tap_ok $s.reduce( &infix:<(+)> ),
        [
          {a =>  1, b => 2},
          (a =>  1, b => 4, c => 42).Bag,
          (a => 13, b => 4, c => 42, e => 10).Bag,
        ],
        "reducing bag union works",
#        :live,
        :after-tap( {
            $s.more( { a =>  1, b => 2 } );
            $s.more( { c => 42, b => 2 } );
            $s.more( { a => 12, e => 10 } );
        } );
    }
}
