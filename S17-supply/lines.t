use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

my @simple  = <a b c d e>;
my @original;
my @endings = "\n", "\r", "\r\n";

plan 23;

dies-ok { Supply.lines }, 'can not be called as a class method';

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.WHAT.perl}";

    tap-ok Supply.from-list( @simple.map: * ~ "\n" ).lines,
      @simple,
      "handle a simple list of lines with LF";
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\n" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with LF without chomping";

    tap-ok Supply.from-list( @simple.map: * ~ "\r" ).lines,
      @simple,
      "handle a simple list of lines with CR";
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\r" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with CR without chomping";

    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @simple.map: * ~ "\r\n" ).lines,
      @simple,
      "handle a simple list of lines with CRLF";
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @original = @simple.map: * ~ "\r\n" ).lines(:!chomp),
      @original,
      "handle a simple list of lines with CRLF without chomping";

    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list( @simple.map: * ~ @endings.pick ).lines,
      @simple,
      "handle a simple list of lines with mixed line ending";
    #?rakudo.jvm todo '\r\n not yet handled as grapheme'
    tap-ok Supply.from-list(@original= @simple.map: * ~ @endings.pick).lines(:!chomp),
      @original,
      "handle a simple list of lines with mixed line ending w/o chomping";

    {
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        tap-ok $s.Supply.lines,
          ['a','b','c','d', '', 'eeee'],
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
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        tap-ok $s.Supply.lines(:!chomp),
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

    # See 97b93c3.
    {
        my $s = Supplier.new;
        #?rakudo.jvm todo '\r\n not yet handled as grapheme'
        my $l = $s.Supply.lines(:!chomp);
        my @res;
        $l.tap({ @res.push: $_ });
        $s.emit("a\r");
        $s.emit("\n");
        for ^50 { last if @res; sleep .1 }
        is-deeply(@res, ["a\r\n"], "handle chunked line endings");
        $s.done;
    }
}
