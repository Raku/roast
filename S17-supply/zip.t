use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 10;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        tap_ok $s1.zip($s2, :with( &infix:<~> )),
          [<1a 2b>],
          'zipping taps works',
          :after-tap( {
              $s1.emit(1);
              $s1.emit(2);
              $s2.emit('a');
              $s2.emit('b');
              $s2.emit('c');
              $s1.done();
              $s2.done();
          } );
    }

    tap_ok Supply.zip(
        Supply.from-list("a".."e"),
        Supply.from-list("f".."k"),
        Supply.from-list("l".."p")
      ),
      [<a f l>,<b g m>,<c h n>,<d i o>,<e j p>],
      "zipping with 3 supplies works";

    {
        my $s = Supply.from-list(1..10);
        my $z = Supply.zip($s);
        ok $s === $z, "zipping one supply is a noop";
        tap_ok $z, [1..10], "noop zip";
    }

    throws_like( { Supply.zip(42) },
      X::Supply::Combinator, combinator => 'zip' );

}
