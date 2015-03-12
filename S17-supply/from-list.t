use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 13;

dies_ok { Supply.new.for(1..10) }, 'can not be called as an instance method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s = Supply.for(1..10);
        tap_ok $s, [1..10], "On demand publish worked";
        tap_ok $s, [1..10], "Second tap gets all the values";

        ok $s.Supply === $s, '.Supply on a Supply is a noop';
    }

    tap_ok (1..10).Supply,
      [1..10], "Supply coercer worked on Range";

    tap_ok (1,2,3,4,5,6,7,8,9,10).Supply,
      [1..10], "Supply coercer worked on Parcel";

    tap_ok "food".Supply,
      [<food>], "Supply coercer worked on scalar";
}
