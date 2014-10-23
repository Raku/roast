use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 5;

#?rakudo.jvm todo "?"
dies_ok { Supply.words }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for(<a bb ccc dddd eeeee>).words,
      ['abbcccddddeeeee'],
      "handle a simple list of words";

    {
        my $s = Supply.new;
        tap_ok $s.words,
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
