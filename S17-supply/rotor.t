use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 11;

#?rakudo.jvm todo "D: doesn't work in signatures"
dies_ok { Supply.rotor }, 'can not be called as a class method';

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..5).rotor,
      [[1,2],[2,3],[3,4],[4,5],[5]],
      "we can rotor";

    tap_ok Supply.for(1..5).rotor(3,2),
      [[1,2,3],[2,3,4],[3,4,5],[4,5]],
      "we can rotor by number of elements and overlap";

    {
        my $for = Supply.for(1..10);
        my $rotor = $for.rotor(1,0);
        ok $for === $rotor, "rotoring by 1/0 is a noop";
        tap_ok $rotor, [1..10], "noop rotor";
    }
}
