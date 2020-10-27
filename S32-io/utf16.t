use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 39;
# This is a test for the utf16, utf16be and utf16le encodings. We make sure
# to test .encode, .decode, .slurp, .spurt. We also make sure .read reads the
# file properly and that utf16 will get rid of a BOM at the start of the file.

# "Raku's utf16 format specifier will use the endianness of host system when
# encoding. When decoding it will look for a byte order mark and if it is there
# use that to set the endianness. If there is no byte order mark it will assume
# the file uses the same endianness as the host system."
# Hence for testing a file without a BOM, we must pick the correct ordering:

my $matching_utf16 = $*KERNEL.endian == LittleEndian
    ?? 'sample-UTF-16LE.txt' !! 'sample-UTF-16BE.txt';

# TODO:
# * Check that BOM other places other than the start of the file get passed
#   through with 'utf16'.
# * Test .lines with both single and multiple lines
my %enc =
    utf8    => <sample-UTF-8.txt>,
    utf16   => ('sample-UTF-16LE-bom.txt', 'sample-UTF-16BE-bom.txt', $matching_utf16),
    utf16le => <sample-UTF-16LE-bom.txt sample-UTF-16LE.txt>,
    utf16be => <sample-UTF-16BE-bom.txt sample-UTF-16BE.txt>
;
# "LATIN CAPITAL LETTER A, LATIN CAPITAL LETTER L WITH STROKE, HANGUL CHOSEONG IEUNG-KIYEOK, CHAKMA DANDA, BUTTERFLY, <control-0000>";
my $text = (0x41, 0x141, 0x1141, 0x11141, 0x1F98B, 0x0).chrs;
my $text_bom = 0xFEFF.chr ~ $text;
# Return the proper text we are trying to match based on the encoding and the filename
sub proper-text (Str:D $encoding, Str:D $filename) {
    if $encoding eq 'utf16be' | 'utf16le' && $filename.ends-with('bom.txt') {
        return $text_bom;
    }
    return $text;
}
# Convenience function to get the IO::Path of the file by name
sub get-filename (Str:D $filename --> IO::Path:D) {
    return $?FILE.IO.parent.child('utf16-test').child($filename);
}
for <utf16le utf16be> -> $enc-name {
    my $buf;
    my $filename = %enc{$enc-name}[1];
    lives-ok { $buf = proper-text($enc-name, $filename).encode($enc-name) }, "lives-ok .encode('$enc-name')";
    my $fh = open get-filename($filename), :r;
    is $buf, $fh.read, "Buf.encode('$enc-name') gives correct output";
    $fh.close;
}
for %enc.kv -> $enc-name, $filenames {
    for $filenames.list -> $filename {
        my $need-text = proper-text($enc-name, $filename);
        # Reading with .slurp
        {
            my $fh = open get-filename($filename), :enc($enc-name), :r;
            my $got = $fh.slurp;
            is-deeply $got, $need-text, "decodestream($enc-name): $filename";
            $fh.close;
        }
        # Reading as binary data and then decoding
        {
            my $fh = open get-filename($filename), :r;
            my $bin = $fh.read;
            $fh.close;
            my $got-decode = $bin.decode($enc-name);
            is-deeply $got-decode, $need-text, "decode($enc-name): $filename";
        }
        # .readchars one at a time
        {
            my $fh = open get-filename($filename), :enc($enc-name), :r;
            my @chars;
            for ^$need-text.chars {
                push @chars, $fh.readchars(1);
            }
            my @want = $need-text.comb;
            my $rtrn = is-deeply @chars, @want, ".readchars(1) {$text.chars} times. $filename :enc($enc-name)";
        }
        {
            my $temp-file = make-temp-path();
            my $fh = open $temp-file, :enc($enc-name), :w;
            $fh.print($text);
            $fh.close;
            $fh = open $temp-file, :enc($enc-name), :r;
            is $fh.slurp, $text, "Writing text to a file in encoding $enc-name reads properly";
        }

    }

}
my $temp = make-temp-path();
my $le_bom = Buf[uint8].new(0xFF, 0xFE);
my $be_bom = Buf[uint8].new(0xFE, 0xFF);
{
    my $fh = open $temp, :w, :enc<utf16>;
    $fh.print: $text;
    $fh.close;
}
{
    my $fh = open $temp, :r, :bin;
    my $buf = $fh.read;
    # At the moment there is no way to check the endianess we are on. So for now just
    # Accept a BOM of either type.
    my $test-text = "writing utf16 file has BOM and bytes are in the right order";
    my $temp2 = make-temp-path();
    $temp2.spurt($text, :enc<utf16>);
    my $fh2 = open $temp2, :r, :bin;
    my $buf2 = $fh2.read;
    if $*VM.config<be> == 0 {
        is-deeply $buf, get-filename('sample-UTF-16LE-bom.txt').slurp(:bin), $test-text;
        is-deeply $buf2, get-filename('sample-UTF-16LE-bom.txt').slurp(:bin), "$test-text (spurt)";
    }
    else {
        is-deeply $buf, get-filename('sample-UTF-16BE-bom.txt').slurp(:bin), $test-text;
        is-deeply $buf, get-filename('sample-UTF-16BE-bom.txt').slurp(:bin), "$test-text (spurt)";
    }
}
# Here we test that a BOM is written when we are appending a file. We make sure
# that a BOM is only added if the file has no data in it. If we open a file for
# write that already has data, we need to not add a BOM.
{
    my $temp = make-temp-path();
    my $fh = open $temp, :a, :enc<utf16>;
    $fh.close;
    $fh = open $temp, :a, :enc<utf16>;
    $fh.close;
    my $fh2 = open $temp, :a, :enc<utf16>;
    my $buf = $temp.slurp(:bin);
    if $*VM.config<be> == 0 {
        is-deeply $buf, $le_bom, "utf16: BOM is written correctly with append, and written only once";
    }
    else {
        is-deeply $buf, $be_bom, "utf16: BOM is written correctly with append, and written only once";
    }
}

# vim: expandtab shiftwidth=4
