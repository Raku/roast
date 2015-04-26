use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 32;

dies_ok { Supply.rotor }, 'can not be called as a class method';
#?rakudo todo 'only deprecated so far'
dies_ok { Supply.from-list(1..5).rotor }, 'no param version illegal';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..5).rotor(3 => -2),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor with negative gap";

    tap-ok Supply.from-list(1..5).rotor(3 => -2,:!partial),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor with negative gap without partial";

    tap-ok Supply.from-list(1..5).rotor(3 => -2,:partial),
      [[1,2,3],[2,3,4],[3,4,5],[4,5]],
      "we can rotor with negative gap with partial";

    for 3, 3 => 0 -> $what {
        tap-ok Supply.from-list(1..10).rotor(3 => 0),
          [[1,2,3],[4,5,6],[7,8,9]],
          "we can rotor without gap with $what.perl()";

        tap-ok Supply.from-list(1..10).rotor(3 => 0,:!partial),
          [[1,2,3],[4,5,6],[7,8,9]],
          "we can rotor without gap without partial with $what.perl()";

        tap-ok Supply.from-list(1..10).rotor(3 => 0,:partial),
          [[1,2,3],[4,5,6],[7,8,9],[10]],
          "we can rotor without gap with partial with $what.perl()";
    }

    tap-ok Supply.from-list(1..10).rotor(3 => 1),
      [[1,2,3],[5,6,7]],
      "we can rotor with positive gap";

    tap-ok Supply.from-list(1..10).rotor(3 => 1,:!partial),
      [[1,2,3],[5,6,7]],
      "we can rotor with positive gap without partial";

    tap-ok Supply.from-list(1..10).rotor(3 => 1,:partial),
      [[1,2,3],[5,6,7],[9,10]],
      "we can rotor with positive gap with partial";

    tap-ok Supply.from-list(1..10).rotor(3 => 1, 2 => -1),
      [[1,2,3],[5,6],[6,7,8]],
      "we can rotor with multiple different gaps";

    tap-ok Supply.from-list(1..10).rotor(3 => 1, 2 => -1,:!partial),
      [[1,2,3],[5,6],[6,7,8]],
      "we can rotor with multiple different gaps without partial";

    tap-ok Supply.from-list(1..10).rotor(3 => 1, 2 => -1,:partial),
      [[1,2,3],[5,6],[6,7,8],[10]],
      "we can rotor with multiple different gaps with partial";
}
