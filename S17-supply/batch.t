use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 9;

dies-ok { Supply.batch(1000) }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(1..14).batch(:elems(5)),
      [(1,2,3,4,5),(6,7,8,9,10),(11,12,13,14)],
      "we can batch by number of elements";

    {
        my $seconds = 5;
        my $s = Supplier.new;
        my $b = $s.Supply.batch( :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap-ok $b,
          [($base xx 10).List,($base+1 xx 10).List],
          "we can batch by time",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^10;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^10;
              $s.done;
          } );
    }

    {
        my $seconds = 5;
        my $elems   = 7;
        my $spurt   = 10;
        my $rest    = $spurt - $elems;
        my $s = Supplier.new;
        my $b = $s.Supply.batch( :$elems, :$seconds );
        sleep $seconds - now % $seconds; # wait until next $sleep second period
        my $base = time div $seconds;
        tap-ok $b,
          [($base   xx $elems).List,($base   xx $rest).List,
           ($base+1 xx $elems).List,($base+1 xx $rest).List],
          "we can batch by time and elems",
          :timeout(3 * $seconds),
          :after-tap( {
              $s.emit( time div $seconds ) for ^$spurt;
              sleep $seconds;            # wait until in the next period
              $s.emit( time div $seconds ) for ^$spurt;
              $s.done;
          } );
    }

    {
        my $f = Supply.from-list(1..10);
        my $b = $f.batch(:elems(1)),
        tap-ok $b, [ (1..10)>>.List ], "batch by 1 creates 1 element lists";
    }
}

# vim: ft=perl6 expandtab sw=4
