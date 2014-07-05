use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 9;

#?rakudo.jvm todo "D: doesn't work in signatures RT #122229"
dies_ok { Supply.map({...}) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for( (1..5).map( {[$_]} ) ),
      [[1],[2],[3],[4],[5]], "On demand publish with arrays";

    tap_ok Supply.for( [1,2],[3,4,5] ).map( {.flat} ),
      [1..5], "On demand publish with flattened arrays";

    tap_ok Supply.for(1..10).map( * * 5 ),
      [5,10,15,20,25,30,35,40,45,50],
      "mapping tap with single values works";

    tap_ok Supply.for(1..10).map( { $_ xx 2 } ),
      [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10],
      "mapping tap with multiple values works";
}
