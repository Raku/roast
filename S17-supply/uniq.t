use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 50;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    tap_ok Supply.for(1..10,1..10).uniq,
      [1,2,3,4,5,6,7,8,9,10],
      "uniq tap works";

    tap_ok Supply.for(1..10).uniq(:as(* div 2)),
      [1,2,4,6,8,10],
      "uniq with as tap works";

    tap_ok Supply.for(<a A B b c C>).uniq( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c>],
      "uniq with with tap works";

    tap_ok Supply.for(<a AA B bb cc C>).uniq(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc>],
      "uniq with as and with tap works";

    {
        my $s = Supply.new;
        tap_ok $s.uniq( :expires(2) ),
          [1,2,3,1,2],
          'uniq with expiry works',
          :after-tap( {
              $s.more(1);
              sleep 1;
              $s.more(2);
              sleep 1;
              $s.more(3);
              sleep 1;
              $s.more(1);
              $s.more(2);
              $s.more(3); # twice within expiration time
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.uniq( :as( * div 2 ), :expires(2) ),
          [1,2,1,2],
          'uniq with as and expiry works',
          :after-tap( {
              $s.more(1);
              sleep 1;
              $s.more(2);
              sleep 1;
              $s.more(3); # same as 2
              sleep 1;
              $s.more(1);
              $s.more(2);
              $s.more(3); # twice within expiration time
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.uniq( :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a b c B>],
          'uniq with as and expiry works',
          :after-tap( {
              $s.more("a");
              sleep 1;
              $s.more("b");
              sleep 1;
              $s.more("B"); # same as "b"
              sleep 1;
              $s.more("c");
              $s.more("B");
              $s.more("b"); # same as "B"
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.uniq(
          :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a bb c B>],
          'uniq with as and expiry works',
          :after-tap( {
              $s.more("a");
              sleep 1;
              $s.more("bb");
              sleep 1;
              $s.more("B"); # same as "bb"
              sleep 1;
              $s.more("c");
              $s.more("B");
              $s.more("bb"); # same as "B"
          } );
    }
}
