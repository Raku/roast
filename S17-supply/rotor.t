use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 24;

dies_ok { Supply.rotor }, 'can not be called as a class method';
#?rakudo todo 'only deprecated so far'
dies_ok { Supply.from-list(1..5).rotor }, 'no param version illegal';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..5).rotor(3 => -2),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor with negative gap and overlap";

    tap_ok Supply.from-list(1..5).rotor(3 => -2,:!partial),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor with negative gap and overlap without partial";

    tap_ok Supply.from-list(1..5).rotor(3 => -2,:partial),
      [[1,2,3],[2,3,4],[3,4,5],[4,5]],
      "we can rotor with negative gap and overlap with partial";

    tap_ok Supply.from-list(1..10).rotor(3 => 0),
      [[1,2,3],[4,5,6],[7,8,9]],
      "we can rotor without gap and overlap";

    tap_ok Supply.from-list(1..10).rotor(3 => 0,:!partial),
      [[1,2,3],[4,5,6],[7,8,9]],
      "we can rotor without gap and overlap without partial";

    tap_ok Supply.from-list(1..10).rotor(3 => 0,:partial),
      [[1,2,3],[4,5,6],[7,8,9],[10]],
      "we can rotor without gap and overlap with partial";

    tap_ok Supply.from-list(1..10).rotor(3 => 1),
      [[1,2,3],[5,6,7]],
      "we can rotor with positive gap and overlap";

    tap_ok Supply.from-list(1..10).rotor(3 => 1,:!partial),
      [[1,2,3],[5,6,7]],
      "we can rotor with positive gap and overlap without partial";

    tap_ok Supply.from-list(1..10).rotor(3 => 1,:partial),
      [[1,2,3],[5,6,7],[9,10]],
      "we can rotor with positive gap and overlap with partial";

    {
        my $for = Supply.from-list(1..10);
        my $rotor = $for.rotor( 1 => 0 );
        ok $for === $rotor, "rotoring by 1/0 is a noop";
        tap_ok $rotor, [1..10], "noop rotor";
    }
}
