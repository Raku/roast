use v6;
use Test;

my @endings =
  "\n"   => "LF",
  "\r\n" => "CRLF",
#  "\r"   => "CR",   # CR later
                     # other line endings later still
;

plan @endings * (1 + 3 * ( (3 * 7) + 7));

my $filename = 't/spec/S16-io/lines.testing';
my @text = <zero one two three four>;

for @endings -> (:key($eol), :value($EOL)) {
    unlink $filename;  # make sure spurt will work

    my $text = @text.join($eol);
    ok $filename.IO.spurt($text), "could we spurt a file with $EOL";

    for (), '', :chomp, '', :!chomp, $eol -> $chomp, $end {
        my $status = "{$chomp.gist} / $EOL";

        for (), True, :close, False, :!close, True -> $closing, $open {
            my $handle = open($filename, |$chomp);
            isa-ok $handle, IO::Handle;

            my $status = OUTER::<$status> ~ " / {$open ?? 'open' !! 'close'}";

            my $first;
            for $handle.lines -> $line {
                is $line,"@text[0]$end", "read first line: $status";
                $first = $line;
                last;
            }

            is $handle.ins, 1, "read one line: $status";
            my @lines = $first, |$handle.lines(|$closing);
            is @lines.join, @text.join($end), "rest of file: $status";

            is $handle.ins, ($open ?? 5 !! 1), "read five lines: $status";
            is $handle.opened, $open, "handle still open: $status";
            ok $handle.close, "closed handle: $status";
        }

        # slicing
        my $handle = open($filename, |$chomp);
        isa-ok $handle, IO::Handle;

        my @lines = $handle.lines[1,2];
        is @lines.join, @text[1,2].join($end) ~ $end, "handle 1,2: $status";
        is $handle.ins, 3, "handle read three lines: $status";

        is $handle.lines[*-1], @text[*-1], "handle last line: $status";

        # slicing on IO::Path
        #?rakudo skip "Reading from filehandle failed: bad file descriptor"
        is $filename.IO.lines(|$chomp)[1,2].join($end),
          @text[1,2].join($end) ~ $end,
          "path 1,2: $status";

        is $filename.IO.lines(|$chomp)[*-1],
          @text[*-1],
          "path last line: $status";

        is $filename.IO.lines(|$chomp).elems, +@text, "path elems: $status";
    }
}

unlink $filename; # cleanup

# vim: ft=perl6
