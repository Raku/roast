use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 11;

dies_ok { Supply.batch(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

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
          :after-tap( {
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
          :after-tap( {
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
}
