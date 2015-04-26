use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 14;

dies_ok { Supply.rotor }, 'can not be called as a class method';
#?rakudo todo 'only deprecated so far'
dies_ok { Supply.from-list(1..5).rotor }, 'no param version illegal';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..5).rotor(3 => -2),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor by number of elements and overlap";

    tap_ok Supply.from-list(1..5).rotor(:!partial),
      [[1,2],[2,3],[3,4],[4,5]],
      "we can rotor without partial";

    tap_ok Supply.from-list(1..5).rotor(3 => -2,:!partial),
      [[1,2,3],[2,3,4],[3,4,5]],
      "we can rotor by number of elements and overlap without partial";

    tap_ok Supply.from-list(1..5).rotor(3 => -2,:partial),
      [[1,2,3],[2,3,4],[3,4,5],[4,5]],
      "we can rotor by number of elements and overlap with partial";

    {
        my $for = Supply.from-list(1..10);
        my $rotor = $for.rotor( 1 => 0 );
        ok $for === $rotor, "rotoring by 1/0 is a noop";
        tap_ok $rotor, [1..10], "noop rotor";
    }
}
