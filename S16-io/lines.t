use v6;
use Test;

my @endings =
  "\n"               => "LF",
  "\r\n"             => "CRLF",
  "\r"               => "CR",
  ";"                => "semi-colon",
  ":\n:"             => "colons",
  ("\n","\r\n","\r") => "multi",
;

plan @endings * (1 + 3 * ( (3 * 5) + 6));

my $filename = 't/spec/S16-io/lines.testing';
my @text = <zero one two three four>;

for @endings -> (:key($eol), :value($EOL)) {
    unlink $filename;  # make sure spurt will work

    my $text = @text.join($eol[0]);
    ok $filename.IO.spurt($text), "could we spurt a file with $EOL";

    for (), '', :chomp, '', :!chomp, $eol -> $chomp, $end {
        my $status = "{$chomp.gist} / $EOL";

        for (), True, :close, False, :!close, True -> $closing, $open {
            my $handle = open($filename, :nl-in($eol), |$chomp);
            isa-ok $handle, IO::Handle;

            my $status = OUTER::<$status> ~ " / {$open ?? 'open' !! 'close'}";

            my $first;
            for $handle.lines(|$closing) -> $line {
                is $line,"@text[0]$end[0]", "read first line: $status";
                $first = $line;
                last;
            }

            my @lines = $first, |$handle.lines(|$closing);
            is @lines.join, @text.join($end[0]), "rest of file: $status";

            is $handle.opened, $open, "handle still open: $status";
            ok $handle.close, "closed handle: $status";
        }

        # slicing
        my $handle = open($filename, :nl-in($eol), |$chomp);
        isa-ok $handle, IO::Handle;

        my @lines = $handle.lines[1,2];
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

# vim: ft=perl6
