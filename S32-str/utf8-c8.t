use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

# The UTF-8 Clean 8-bit encoding is used to ensure we can roundtrip any
# 8-bit octet stream given to us by OSes that don't promise anything about
# the character encoding of filenames and so forth.

plan 66;

{
    my $test-str;
    lives-ok { $test-str = Buf.new(ord('A'), 0xFE, ord('Z')).decode('utf8-c8') },
        'Can decode byte buffer with 0xFE in it as utf8-c8';
    is $test-str.chars, 3, 'Got expected number of chars';
    is $test-str.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $test-str.substr(2, 1), 'Z', 'Got last char, which was valid UTF-8';
    is $test-str.encode('utf8-c8').list, (ord('A'), 0xFE, ord('Z')),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $test-str;
    lives-ok { $test-str = Buf.new(ord('A'), 0xFE, 0xFD, ord('Z')).decode('utf8-c8') },
        'Can decode byte buffer with 0xFE 0xFD bytes in middle as utf8-c8';
    is $test-str.chars, 4, 'Got expected number of chars';
    is $test-str.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $test-str.substr(3, 1), 'Z', 'Got last char, which was valid UTF-8';
    is $test-str.encode('utf8-c8').list, (ord('A'), 0xFE, 0xFD, ord('Z')),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $test-str;
    lives-ok { $test-str = Buf.new(ord('A'), ord('B'), 0xFC).decode('utf8-c8') },
        'Can decode byte buffer with 0xFC at end as utf8-c8';
    is $test-str.chars, 3, 'Got expected number of chars';
    is $test-str.substr(0, 1), 'A', 'Got first char, which was valid UTF-8';
    is $test-str.substr(1, 1), 'B', 'Got second char, which was valid UTF-8';
    is $test-str.encode('utf8-c8').list, (ord('A'), ord('B'), 0xFC),
        'Encoding back to utf8-c8 round-trips';
}

{
    my $test-str = "D\c[COMBINING DOT ABOVE]\c[COMBINING DOT BELOW]";
    my $buf;
    lives-ok { $buf = $test-str.encode('utf8-c8') },
        'utf8-c8 can cope with ordinary synthetics';
    is $buf.decode('utf8-c8'), $test-str,
        'utf8-c8 round-trips ordinary synthetics';
}

{
    my $test-str;
    lives-ok { $test-str = Buf.new(ord('L'), 0xE9, ord('o'), ord('n')).decode('utf8-c8') },
        'Can decode byte buffer with 0xE9 in middle as utf8-c8';
    is $test-str.chars, 4, 'Got expected number of chars';
    is $test-str.substr(0, 1), 'L', 'Got first char, which was valid UTF-8';
    is $test-str.substr(2, 1), 'o', 'Got third char, which was valid UTF-8';
    is $test-str.substr(3, 1), 'n', 'Got forth char, which was valid UTF-8';
    is $test-str.encode('utf8-c8').list, (ord('L'), 0xE9, ord('o'), ord('n')),
        'Encoding back to utf8-c8 round-trips';
}

#?rakudo.js.browser skip "slurp doesn't work in the browser"
{
    my $test-file := make-temp-path content => Buf.new:
        ord('A'), 0xFA, ord('B'), 0xFB, 0xFC, ord('C'), 0xFD;

    my $test-str;
    lives-ok { $test-str = slurp($test-file, enc => 'utf8-c8') },
        'Can slurp file with non-UTF-8 octets as utf8-c8';
    is $test-str.chars, 7, 'Slurped correct number of chars';
    is $test-str.substr(0, 1), 'A', 'First valid UTF-8 char OK';
    is $test-str.substr(2, 1), 'B', 'Second valid UTF-8 char OK';
    is $test-str.substr(5, 1), 'C', 'Third valid UTF-8 char OK';
    is $test-str.encode('utf8-c8').list,
        (ord('A'), 0xFA, ord('B'), 0xFB, 0xFC, ord('C'), 0xFD),
        'Encoding back to utf8-c8 roundtrips';
}

# https://github.com/Raku/old-issue-tracker/issues/4327
if $*DISTRO.is-win {
    skip('Not clear how to recreate this situation on Windows', 2);
}
elsif $*DISTRO.name eq 'browser' {
    skip('Calling the shell doesn\'t work ', 2);
}
else {
    {
        my $cmd = Q{env ACME=$'L\xe9on' } ~ $*EXECUTABLE ~ Q{ -e 'say("lived")'};
        my $proc = shell $cmd, :out;
        is $proc.out.get, 'lived', 'Can run Raku with non-UTF-8 environment';
    }
    {
        my $filename = "L\xe9on";
        spurt $filename, 'say(42)';
        LEAVE { try unlink $filename }
        my $proc = run $*EXECUTABLE, $filename, :out;
        is $proc.out.get, '42', 'Can run Raku sourcefile with non-UTF-8 name';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4794
is Buf.new(0xFE).decode('utf8-c8').chars, 1, 'Decoding Buf with just 0xFE works';

#?rakudo.js.browser skip "writing to files doesn't work in the browser"
# @bufs.elems * 2 + 2
#?DOES 20
# https://github.com/Raku/old-issue-tracker/issues/5330
{
    my @bufs =
        Buf.new(61,29,61,200,30,99,107,150,71,11,253,134,110,27,35,227,88,140,
            180,158,209),
        Buf.new(61,2,71,91,58,252,6,247,88,58,121,32,124,129,191,126,36,222,
            185,109,213),
        Buf.new(61,147,135,8,82,78,208,66,205,164,204,162,140,97,175,37,108,
            194,27,192,119),
        Buf.new(61,10,0,56,143,36,56,119,182,81,88,70,88,139,28,119,142,151,
            108,12,215),
        Buf.new(61,93,12,110,139,89,42,134,251,165,68,32,104,225,44,112,194,
            178,75,64,243),
        Buf.new(61,185,242,97,170,122,52,182,62,236,186,222,213,63,189,203,241,
            176,1,149,233),
        Buf.new(61,125,17,108,54,202,12,120,39,225,91,9,125,124,163,24,100,110,
            156,192,137),
        Buf.new(61,57,204,118,97,221,164,168,63,30,168,197,108,198,67,28,111,192,
            161,122,96),
        Buf.new(61,180,192,142,191,171,181,101,4,238,122,232,11,194,77,144,221,
            109,108,228,192);

    my $test-file := make-temp-path;

    for @bufs.kv -> $i, $buf {
        is-deeply Buf.new($buf.decode('utf8-c8').encode('utf8-c8').list), $buf,
            ".decode.encode roundtrips correctly for utf8-c8 [Buf #{$i+1}]";

        spurt $test-file, $buf;
        my $fh = open $test-file, :enc<utf8-c8>;
        my $from-file = $fh.slurp;
        $fh.close;
        is-deeply Buf.new($from-file.encode('utf8-c8').list), $buf,
            "Also round-trips correct from a file [Buf #{$i+1}]";
    }

    {
        my $fh = open $test-file, :w, :bin;
        for ^10000 {
            $fh.write: @bufs[0];
            $fh.write: "\n".encode('ascii');
        }
        $fh.close;

        lives-ok { slurp $test-file, :enc<utf8-c8> },
            'Can slurp long file using utf8-c8 encoding';

        $fh = open $test-file, :enc<utf8-c8>;
        my $ok = 0;
        for $fh.lines {
            $ok++ if Buf.new(.encode('utf8-c8').list) eqv @bufs[0];
            unless Buf.new(.encode('utf8-c8').list) eqv @bufs[0] {
                note $ok;
                note Buf.new(.encode('utf8-c8').list).raku ~ "\n", @bufs[0].raku;
            }
        }
        $fh.close;
        is $ok, 10000, 'Can read lines correctly using utf8-c8';
    }
}

# MoarVM #482
#?rakudo.js.browser skip "writing to files doesn't work in the browser"
{
    is Buf.new('“'.encode('utf8')).decode('utf8-c8'), '“',
        'Valid and NFC UTF-8 comes out fine (string case)';

    my $test-file = make-temp-file;
    spurt $test-file, '“';
    my $fh = open $test-file, :enc<utf8-c8>;
    is $fh.slurp, '“', 'Valid and NFC UTF-8 comes out fine (file case)';
    $fh.close;
}

# https://github.com/Raku/old-issue-tracker/issues/5165

if $*DISTRO.is-win {
    skip('Not clear if there is an alternative to this issue on Windows', 4);
} elsif $*DISTRO.name eq 'browser' {
    skip('We don\'t have directories in the browser', 4);
} elsif $*DISTRO.name eq 'macosx' {
    skip('Some problems on MacOS', 4);
} else {
    my $test-dir = make-temp-dir;
    # ↑ normal directory in TMPDIR to hide our scary stuff
    my $file = ("$test-dir/".encode ~ Buf.new(0x06, 0xAB)).decode('utf8-c8');
    # ↑ a file with a name that is somewhat weird
    LEAVE { try unlink $file }
    spurt $file, 'hello'; # create the file
    lives-ok {
        my @files = $test-dir.IO.dir;
        is @files.elems, 1, 'dir returns something when encountering malformed utf8 names';
        my $roundtrip = @files[0].basename.encode('utf8-c8');
        is-deeply $roundtrip.list, (0x06, 0xAB), 'utf8-c8 name roundtripped through dir';
        is @files.IO.slurp, 'hello', 'can slurp a file with utf8-c8 name';
    }, 'dir lives with malformed utf8 names';
}

# MoarVM #664
# UTF8-C8 string changes under concatenation/substr
{
    my @ints = 103, 248, 111, 217, 210, 97;
    my $b = Buf.new(@ints);
    my Str $u = $b.decode("utf8-c8");
    is-deeply $u.chars, $u.subst("a", "a").chars, "UTF8-C8 retains the same number of ‘chars’ after .subst operation";
}
# Can encode surrogates and codepoints above 0x10FFFF
# ( 0 <= cp && cp <= 0x10FFFF)
#    && (cp < 0xD800 || 0xDFFF < cp); /*
{
    my @ints = 0x10FFFF, 0x10FFFE, 0x12FFFF, 0xD800, 0xDFFF;
    my $b = Buf.new(@ints);
    my Str $u;
    lives-ok { $u = $b.decode('utf8-c8') }, "lives-ok when decoding Unicode Surrogates and values higher than 0x10FFFF";
}
{
# utf8-c8 codepoints combine with other codepoints
    my $c8 := Buf.new(255).decode(<utf8-c8>);
    is (      'L' ~ $c8) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (end)";
    is ($c8 ~ 'L' ~ $c8) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (start/end)";
    is ($c8 ~ 'L'      ) ~~ /L/, 'L',
        "Regex still matches when utf8-c8 graphemes are adjacent (start)";
}
# https://github.com/Raku/old-issue-tracker/issues/5408
{
    is-deeply Blob[uint8].new(233).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(233), 'utf8-c8 does not generate spurious NUL 1';
    is-deeply Blob[uint8].new(233, 128).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(233, 128), 'utf8-c8 does not generate spurious NUL 2';
}
# https://github.com/Raku/old-issue-tracker/issues/5409
{
    is-deeply Blob[uint8].new(101, 204, 129).decode("utf8-c8").encode("utf8-c8"), Blob[uint8].new(101, 204, 129), 'Non normalized NFC is not mangled by utf-c8';
}

# vim: expandtab shiftwidth=4
