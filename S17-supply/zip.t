use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 11;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.raku}";

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;

        tap-ok $s1.Supply.zip($s2.Supply, :with( &infix:<~> )),
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

    tap-ok Supply.zip(
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
        tap-ok $z, [1..10], "noop zip";
    }

    throws-like( { Supply.zip(42) },
      X::Supply::Combinator, combinator => 'zip' );
}

#?rakudo.jvm skip 'UnwindException in thread "main"'
#?DOES 1
{
  subtest {
    my $*SCHEDULER = ThreadPoolScheduler.new;
    react {
        whenever Promise.in(5) {
            flunk "zip timed out";
            done;
        }
        whenever Supply.zip: Supply.from-list(^2), Supply.interval: .01 -> $l {
            if $l eqv ((0, 0) | (1, 1)) {
                pass "zip is ok"
            } else {
                flunk "invalid value: $l"
            }
            LAST { done }
        }
    }
  }, "zip will be done when any supply become done"
}

# vim: expandtab shiftwidth=4
