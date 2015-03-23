use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 17;

dies_ok { Supply.unique }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list(1..10,1..10).unique,
      [1,2,3,4,5,6,7,8,9,10],
      "unique tap works";

    tap_ok Supply.from-list(1..10).unique(:as(* div 2)),
      [1,2,4,6,8,10],
      "unique with as tap works";

    tap_ok Supply.from-list(<a A B b c C>).unique( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c>],
      "unique with with tap works";

    tap_ok Supply.from-list(<a AA B bb cc C>).unique(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc>],
      "unique with as and with tap works";

    {
        my $s = Supply.new;
        tap_ok $s.unique( :expires(2) ),
          [1,2,3,1,2],
          'unique with expiry works',
          :after-tap( {
              $s.emit(1);
              sleep 1;
              $s.emit(2);
              sleep 1;
              $s.emit(3);
              sleep 1;
              $s.emit(1);
              $s.emit(2);
              $s.emit(3); # twice within expiration time
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.unique( :as( * div 2 ), :expires(2) ),
          [1,2,1,2],
          'unique with as and expiry works',
          :after-tap( {
              $s.emit(1);
              sleep 1;
              $s.emit(2);
              sleep 1;
              $s.emit(3); # same as 2
              sleep 1;
              $s.emit(1);
              $s.emit(2);
              $s.emit(3); # twice within expiration time
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.unique( :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a b c B>],
          'unique with as and expiry works',
          :after-tap( {
              $s.emit("a");
              sleep 1;
              $s.emit("b");
              sleep 1;
              $s.emit("B"); # same as "b"
              sleep 1;
              $s.emit("c");
              sleep 1;
              $s.emit("B");
              $s.emit("b"); # same as "B"
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.unique(
          :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} ), :expires(2) ),
          [<a bb c B>],
          'unique with as and expiry works',
          :after-tap( {
              $s.emit("a");
              sleep 1;
              $s.emit("bb");
              sleep 1;
              $s.emit("B"); # same as "bb"
              sleep 1;
              $s.emit("c");
              $s.emit("B");
              $s.emit("bb"); # same as "B"
          } );
    }
}
