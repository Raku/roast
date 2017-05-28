use v6;
use lib <t/spec/packages/>;
use Test;
use Test::Util;

my @endings =
  "\n"               => "LF",
  "\r"               => "CR",
  ";"                => "semi-colon",
  ":\n:"             => "colons",
  ("\n","\r\n","\r") => "multi",
;

plan 8 + @endings * (1 + 3 * ( 5 + 6));

my $filename = 't/spec/S16-io/lines.testing';
my @text = <zero one two three four>;

for @endings -> (:key($eol), :value($EOL)) {
    unlink $filename;  # make sure spurt will work

    my $text = @text.join($eol[0]);
    ok $filename.IO.spurt($text), "could we spurt a file with $EOL";

    for (), '', :chomp, '', :!chomp, $eol -> $chomp, $end {
        my $status = "{$chomp.gist} / $EOL";

        my $handle = open($filename, :nl-in($eol), |$chomp);
        isa-ok $handle, IO::Handle;

        my $first;
        for $handle.lines -> $line {
            is $line,"@text[0]$end[0]", "read first line: $status";
            $first = $line;
            last;
        }

        my @lines = $first, |$handle.lines;
        is @lines.join, @text.join($end[0]), "rest of file: $status";

        ok $handle.opened, "handle still open";
        ok $handle.close, "closed handle";

        # slicing
        $handle = open($filename, :nl-in($eol), |$chomp);
        isa-ok $handle, IO::Handle;

        @lines = $handle.lines[1,2];
        is @lines.join, @text[1,2].join($end[0]) ~ $end[0],
          "handle 1,2: $status";

        is $handle.lines[*-1], @text[*-1], "handle last line: $status";

        $handle.close;

        # slicing on IO::Path
        is $filename.IO.lines(:nl-in($eol), |$chomp)[1,2,*-1][^2].join($end[0]),
          @text[1,2].map({ $_ ~ $end[0] }).join($end[0]),
          "path 1,2: $status";

        is $filename.IO.lines(:nl-in($eol), |$chomp)[*-1],
          @text[*-1],
          "path last line: $status";

        is $filename.IO.lines(:nl-in($eol), |$chomp).elems,
          +@text,
          "path elems: $status";
    }
}

unlink $filename; # cleanup

# RT #127370
{
    try shell(:out, :err, $*EXECUTABLE ~ ’ -pe '' /proc/$$/statm‘)
        .out.slurp;
    pass 'Attempting to read lines in from `/proc/$$/statm` does not hang';
}

{
    # RT #130430
    my $file = 't/spec/S16-io/lines.testing'.IO;
    $file.spurt: join "\n", <a b c>;
    is-deeply $file.lines(2000), ('a', 'b', 'c'),
        'we stop when data ends, even if limit has not been reached yet';
    unlink $file;
}

{
    # https://irclog.perlgeek.de/perl6-dev/2017-01-21#i_13962764
    my $file = 't/spec/S16-io/lines.testing'.IO;
    $file.spurt: join "\n", <a b c>;
    is_run 'lines; lines', :args[$file], {
        :out(''), :err(''), :0status,
    }, 'calling lines() after exhausting previous input does not crash';
    unlink $file;
}

# https://irclog.perlgeek.de/perl6-dev/2017-01-27#i_13996365
lives-ok {
    # we set the batch to 1+els, to ensure we get a partial
    # list, which is where the bug hid
    .lines.rotor(:partial, 1 + .lines.elems).eager with $*PROGRAM.IO
}, '.lines does not crash with partial .rotor';

{ # https://github.com/rakudo/rakudo/commit/0c6281518e
    is-deeply run(:out, $*EXECUTABLE, '-e', ｢.say for ^3｣).out.lines(*).List,
              ("0", "1", "2"), 'can use Whatever as limit to IO::Pipe.lines';

    lives-ok { run(:out, $*EXECUTABLE, "-e", "1.say").out.lines.sink },
        'can sink-all IO::Pipe.lines';
}

# https://github.com/rakudo/rakudo/commit/bf399380c1
subtest '$limit works right with any combination of args' => {
    plan 5;
    my $file = make-temp-file :content("foo\nbar\nber");
    my $exp = ('foo', 'bar').Seq;
    is-deeply $file.lines(2), $exp, 'IO::Path.lines($limit)';
    subtest 'IO::Handle.lines($limit)' => { plan 2;
        with $file.open {
            is-deeply .lines(2), $exp, 'right lines';
            is-deeply .opened, True, 'left handle opened';
            .close;
        }
    }
    subtest 'IO::Handle.lines($limit, :close)' => { plan 2;
        with $file.open {
            is-deeply .lines(2, :close), $exp, 'right lines';
            is-deeply .opened, False, 'closed handle';
        }
    }
    subtest '&lines($fh, $limit)' => { plan 2;
        with $file.open {
            is-deeply lines($_, 2), $exp, 'right lines';
            is-deeply .opened, True, 'left handle opened';
            .close;
        }
    }
    subtest '&lines($fh, $limit, :close)' => { plan 2;
        with $file.open {
            is-deeply lines($_, 2, :close), $exp, 'right lines';
            is-deeply .opened, False, 'closed handle';
        }
    }
}

{
    my $file = make-temp-file :content("foo\nbar\nber\nmeow\nPerl 6");
    # we spin up another perl6 and do 1500 x 2 .lines calls; if the handle
    # isn't closed; we can expect some errors to show up in the output
    is_run ｢my $i = 0; my @lines; with ｣ ~ $file.perl ~ ｢ {
            loop {
                last if ++$i > 1500;
                @lines.append: .lines;
                @lines.append: .lines(2);
            }
        }; print "all ok $i"｣,
        {:err(''), :out('all ok 1501'), :0status},
    'heuristic for testing whether handle is closed';
}

# vim: ft=perl6
