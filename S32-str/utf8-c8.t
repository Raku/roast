use v6;
use Test;

# The UTF-8 Clean 8-bit encoding is used to ensure we can roundtrip any
# 8-bit octet stream given to us by OSes that don't promise anything about
# the character encoding of filenames and so forth.

plan 32;

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
