use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 290;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s = Supply.new;
    
        my @vals;
        my $saw_done;
        my $tap = $s.tap( -> $val { @vals.push($val) },
          done => { $saw_done = True });

        $s.more(1);
        is ~@vals, "1", "Tap got initial value";
        nok $saw_done, "No done yet";

        $s.more(2);
        $s.more(3);
        $s.done;
        is ~@vals, "1 2 3", "Tap saw all values";
        ok $saw_done, "Saw done";
    }

    {
        my $s = Supply.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $s.tap(-> $val { @tap1_vals.push($val) });

        $s.more(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $s.tap(-> $val { @tap2_vals.push($val) });
        $s.more(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        $tap1.close;
        $s.more(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
    }

    tap_ok Supply.for(1..14).batch(:elems(5)),
      [[1..5],[6..10],[11..14]],
      "we can batch by number of elements";

    {
        my $seconds = 5;
        my $s = Supply.new;
        my $b = $s.batch( :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap_ok $b,
          [[$base xx 10],[$base+1 xx 10]],
          "we can batch by time",
          :timeout(3 * $seconds),
          :after_tap( {
              $s.more( time div $seconds ) for ^10;
              sleep $seconds;            # wait until in the next period
              $s.more( time div $seconds ) for ^10;
              $s.done;
          } );
    }

    {
        my $seconds = 5;
        my $elems   = 7;
        my $spurt   = 10;
        my $rest    = $spurt - $elems;
        my $s = Supply.new;
        my $b = $s.batch( :$elems, :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap_ok $b,
          [[$base   xx $elems],[$base   xx $rest],
           [$base+1 xx $elems],[$base+1 xx $rest]],
          "we can batch by time and elems",
          :timeout(3 * $seconds),
          :after_tap( {
              $s.more( time div $seconds ) for ^$spurt;
              sleep $seconds;            # wait until in the next period
              $s.more( time div $seconds ) for ^$spurt;
              $s.done;
          } );
    }

    {
        my $f = Supply.for(1..10);
        my $b = $f.batch(:elems(1)),
        ok $f === $b, "batch by 1 is a noop";
        tap_ok $b, [1..10], "noop batch";
    }

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
