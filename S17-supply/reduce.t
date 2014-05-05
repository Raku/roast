use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 44;

dies_ok { Supply.reduce( {...} ) }, 'can not be called as a class method';
dies_ok { Supply.new.reduce(23) }, 'must be code if specified';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..5).reduce( {$^a + $^b} ), [1,3,6,10,15],
      "simple reduce works";
    tap_ok Supply.for(42).reduce( {$^a * $^b} ), [42],
      "minimal reduce works";
    tap_ok Supply.for("a".."e").reduce(&infix:<~>),
      [<a ab abc abcd abcde>],
      "reducing with concatenate works";

    {
        my $s = Supply.new;
        tap_ok $s.reduce( {$^a (+) $^b} ),
        [
          (a =>  1, b => 2).Bag,
          (a =>  1, b => 4, c => 42).Bag,
          (a => 13, b => 4, c => 42, e => 10).Bag,
        ],
        "reducing bag union works",
#        :live,
        :after-tap( {
            $s.more( ( a =>  1, b => 2 ).Bag );
            $s.more( ( c => 42, b => 2 ).Bag );
            $s.more( ( a => 12, e => 10 ).Bag );
        } );
    }
}
