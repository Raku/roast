use v6.c;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 7;

dies-ok { Supply.map({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..10).map( * * 5 ),
      [5,10,15,20,25,30,35,40,45,50],
      "mapping tap with single values works";

    tap-ok Supply.from-list(1..5).map( {[$_]} ),
      [[1],[2],[3],[4],[5]], "On demand publish with arrays will not flatten them";

    tap-ok Supply.from-list( [1,2],[3,4,5] ).map( {.reverse.Str} ),
      ["2 1", "5 4 3"], "Same if we get lists";
}

# vim: ft=perl6 expandtab sw=4
