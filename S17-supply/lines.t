use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

my @simple  = <a b c d e>;
my @endings = "\n", "\r", "\r\n";

plan 11;

dies_ok { Supply.lines }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.for( @simple.map: * ~ "\n" ).lines,
      @simple,
      "we can handle a simple list of lines with LF";

    tap_ok Supply.for( @simple.map: * ~ "\r" ).lines,
      @simple,
      "we can handle a simple list of lines with CR";

    tap_ok Supply.for( @simple.map: * ~ "\r\n" ).lines,
      @simple,
      "we can handle a simple list of lines with CRLF";

    tap_ok Supply.for( @simple.map: * ~ @endings.pick ).lines,
      @simple,
      "we can handle a simple list of lines with mixed line ending";

    {
        my $s = Supply.new;
        tap_ok $s.lines,
          [<a b c d>, '', 'eeee'],
          "handle chunked lines",
          :after-tap( {
              $s.more( "a\nb\r" );
              $s.more( "\nc\rd\n" );
              $s.more( "\ne" );
              $s.more( "eee" );
              $s.done;
          } );
    }
}
