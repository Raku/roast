use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 14;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(flat(1..10,1..10)).repeated,
      [1..10],
      "repeated tap with 2 ranges works";

    tap-ok Supply.from-list(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).repeated,
      [2,3,4,5,6,7,8,9],
      "repeated tap with doubling range works";

    tap-ok Supply.from-list(1..10).repeated(:as(* div 2)),
      [3,5,7,9],
      "repeated with 'as' tap works";

    tap-ok Supply.from-list(<a A B b c C A>).repeated(:with({$^a.lc eq $^b.lc})),
      [<A b C A>],  # first A is seen as "a"
      "repeated with 'with' tap works";

    tap-ok Supply.from-list(<a AA B bb cc C AA>).repeated(
        :as( *.substr(0,1).lc ), :with( {$^a eq $^b} )
      ),
      [<AA bb C AA>],
      "repeated with 'as' and with 'with' tap works";

    tap-ok Supply.from-list(<a>).repeated( :with( -> $a, $b {1} )),
      [],
      "repeated with with that always says it's the same, tap works";

    tap-ok Supply.from-list(<a>).repeated( :as({1}) ),
      [],
      "repeated with as that always returns the same value, tap works";
}

# vim: expandtab shiftwidth=4
