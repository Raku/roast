use v6;
use Test;

plan 20;

for <utf-8 ascii latin-1 windows-1252> -> $encoding {
    my $buf = "\r\n".encode($encoding);
    is $buf.elems, 2, "CRLF encodes to 2 bytes ($encoding)";
    is $buf[0], 0x0D, "first byte is correct ($encoding)";
    is $buf[1], 0x0A, "second byte is correct ($encoding)";

    my $str = $buf.decode($encoding);
    is $str.chars, 1, "decoding it gives back one grapheme ($encoding)";
    is $str, "\r\n", "decoding it gives back the correct grapheme ($encoding)";
}
