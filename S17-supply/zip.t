use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 22;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        tap_ok $s1.zip($s2, :with( &infix:<~> )),
          [<1a 2b>],
          'zipping taps works',
          :after_tap( {
              $s1.more(1);
              $s1.more(2);
              $s2.more('a');
              $s2.more('b');
              $s2.more('c');
              $s1.done();
              $s2.done();
          } );
    }

    tap_ok Supply.zip(
        Supply.for("a".."e"),
        Supply.for("f".."k"),
        Supply.for("l".."p")
      ),
      [<a f l>,<b g m>,<c h n>,<d i o>,<e j p>],
      "zipping with 3 supplies works";

    {
        my $s = Supply.for(1..10);
        my $z = Supply.zip($s);
        ok $s === $z, "zipping one supply is a noop";
        tap_ok $z, [1..10], "noop rotor";
    }
}
