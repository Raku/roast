use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 14;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(flat(1..10,1..10)).squish,
      [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10],
      "squish tap with 2 ranges works";

    tap-ok Supply.from-list(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).squish,
      [1,2,3,4,5,6,7,8,9,10],
      "squish tap with doubling range works";

    tap-ok Supply.from-list(1..10).squish(:as(* div 2)),
      [1,2,4,6,8,10],
      "squish with as tap works";

    tap-ok Supply.from-list(<a A B b c C A>).squish( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c A>],
      "squish with with tap works";

    tap-ok Supply.from-list(<a AA B bb cc C AA>).squish(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc AA>],
      "squish with as and with tap works";

    tap-ok Supply.from-list(<a>).squish( :with( -> $a, $b {1} )),
      [<a>],
      "squish with with that always says it's the same, tap works";

    tap-ok Supply.from-list(<a>).squish( :as({1}) ),
      [<a>],
      "squish with as that always returns the same value, tap works";
}

# vim: expandtab shiftwidth=4
