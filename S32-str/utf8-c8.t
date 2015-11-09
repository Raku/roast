use v6;
use Test;

# The UTF-8 Clean 8-bit encoding is used to ensure we can roundtrip any
# 8-bit octet stream given to us by OSes that don't promise anything about
# the character encoding of filenames and so forth.

plan 23;

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
