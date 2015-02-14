use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 11;

dies_ok { Supply.squish }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for(1..10,1..10).squish,
      [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10],
      "squish tap with 2 ranges works";

    tap_ok Supply.for(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).squish,
      [1,2,3,4,5,6,7,8,9,10],
      "squish tap with doubling range works";

    tap_ok Supply.for(1..10).squish(:as(* div 2)),
      [1,2,4,6,8,10],
      "squish with as tap works";

    tap_ok Supply.for(<a A B b c C A>).squish( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c A>],
      "squish with with tap works";

    tap_ok Supply.for(<a AA B bb cc C AA>).squish(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc AA>],
      "squish with as and with tap works";
}
