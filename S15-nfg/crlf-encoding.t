use v6.c;
use Test;

plan 32;

my $temp-file = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;

for <utf-8 ascii latin-1 windows-1252> -> $encoding {
    my $buf = "\r\n".encode($encoding);
    is $buf.elems, 2, "CRLF encodes to 2 bytes ($encoding)";
    is $buf[0], 0x0D, "first byte is correct ($encoding)";
    is $buf[1], 0x0A, "second byte is correct ($encoding)";

    my $str = $buf.decode($encoding);
    is $str.chars, 1, "decoding it gives back one grapheme ($encoding)";
    is $str, "\r\n", "decoding it gives back the correct grapheme ($encoding)";

    given open($temp-file, :w, enc => $encoding) {
        .print: "goat\r\nboat\r\n";
        .close;
    }
    is $temp-file.IO.s, 12, "Wrote file of correct length ($encoding)";

    given open($temp-file, :r, :bin) {
        my $buf = .read(12);
        my $str = $buf.decode($encoding);
        is $str.chars, 10, "Read file and got expected number of chars ($encoding)";
        is $str, "goat\r\nboat\r\n", "Chars read from file were correct ($encoding)";
        .close;
    }
}
