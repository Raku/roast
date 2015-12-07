use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

dies-ok { Supply.words }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list(<a bb ccc dddd eeeee>).words,
      ['abbcccddddeeeee'],
      "handle a simple list of words";

    {
        my $s = Supplier.new;
        tap-ok $s.Supply.words,
          [<a b cc d eeee fff>],
          "handle chunked lines",
          :after-tap( {
              $s.emit( "   a b c" );
              $s.emit( "c d " );
              $s.emit( " e" );
              $s.emit( "eee" );
              $s.emit( "   " );
              $s.emit( " fff  " );
              $s.done;
          } );
    }
}

# vim: ft=perl6 expandtab sw=4
