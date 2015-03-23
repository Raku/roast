use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

my @simple  = <a b c d e>;
my @original;
my @endings = "\n", "\r", "\r\n";

plan 21;

dies_ok { Supply.lines }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap_ok Supply.from-list( @simple.map: * ~ "\n" ).lines,
      @simple,
      "handle a simple list of lines with LF";
    tap_ok Supply.from-list( @original = @simple.map: * ~ "\n" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with LF without chomping";

    tap_ok Supply.from-list( @simple.map: * ~ "\r" ).lines,
      @simple,
      "handle a simple list of lines with CR";
    tap_ok Supply.from-list( @original = @simple.map: * ~ "\r" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with CR without chomping";

    tap_ok Supply.from-list( @simple.map: * ~ "\r\n" ).lines,
      @simple,
      "handle a simple list of lines with CRLF";
    tap_ok Supply.from-list( @original = @simple.map: * ~ "\r\n" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with CRLF without chomping";

    tap_ok Supply.from-list( @simple.map: * ~ @endings.pick ).lines,
      @simple,
      "handle a simple list of lines with mixed line ending";
    tap_ok Supply.from-list(@original= @simple.map: * ~ @endings.pick).lines(:!chomp),
      @original,
      "handle a simple list of lines with mixed line ending w/o chomping";

    {
        my $s = Supply.new;
        tap_ok $s.lines,
          [<a b c d>, '', 'eeee'],
          "handle chunked lines",
          :after-tap( {
              $s.emit( "a\nb\r" );
              $s.emit( "\nc\rd\n" );
              $s.emit( "\ne" );
              $s.emit( "eee" );
              $s.done;
          } );
    }

    {
        my $s = Supply.new;
        tap_ok $s.lines(:!chomp),
          ["a\n","b\r\n","c\r","d\n","\n","eeee"],
          "handle chunked lines",
          :after-tap( {
              $s.emit( "a\nb\r" );
              $s.emit( "\nc\rd\n" );
              $s.emit( "\ne" );
              $s.emit( "eee" );
              $s.done;
          } );
    }
}
