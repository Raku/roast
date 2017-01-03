use v6;
use Test;

# The UTF-8 Clean 8-bit encoding is used to ensure we can roundtrip any
# 8-bit octet stream given to us by OSes that don't promise anything about
# the character encoding of filenames and so forth.

plan 52;

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

{
    my $test-file = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;
    LEAVE unlink $test-file;

    given open($test-file, :w, :bin) {
        .write: Buf.new(ord('A'), 0xFA, ord('B'), 0xFB, 0xFC, ord('C'), 0xFD);
        .close;
    }

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

# RT #125420
if $*DISTRO.is-win {
    skip('Not clear how to recreate this situation on Windows', 2);
}
else {
    {
        my $cmd = Q{env - ACME=$'L\xe9on' } ~ $*EXECUTABLE ~ Q{ -e 'say("lived")'};
        my $proc = shell $cmd, :out;
        is $proc.out.get, 'lived', 'Can run Perl 6 with non-UTF-8 environment';
    }
    {
        my $cmd = Q{echo 'say(42)' > $'L\xe9on' && } ~ $*EXECUTABLE ~ Q{ $'L\xe9on' && rm $'L\xe9on'};
        my $proc = shell $cmd, :out;
        is $proc.out.get, '42', 'Can run Perl 6 sourcefile with non-UTF-8 name';
    }
}

# RT #126756
is Buf.new(0xFE).decode('utf8-c8').chars, 1, 'Decoding Buf with just 0xFE works';

# RT #128184
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

    my $test-file = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;
    END try unlink $test-file;

    for @bufs.kv -> $i, $buf {
        is-deeply Buf.new($buf.decode('utf8-c8').encode('utf8-c8').list), $buf,
            ".decode.encode roundtrips correctly for utf8-c8 [Buf #{$i+1}]";

        spurt $test-file, $buf, :bin;
        my $fh = open $test-file, :enc<utf8-c8>;
        my $from-file = $fh.slurp-rest;
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
                note Buf.new(.encode('utf8-c8').list).perl ~ "\n", @bufs[0].perl;
            }
        }
        $fh.close;
        is $ok, 10000, 'Can read lines correctly using utf8-c8';
    }
}
