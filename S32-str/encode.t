use v6;
use Test;

# L<S32::Containers/Buf>

plan 44;

ok 'ab'.encode('ASCII') ~~ blob8, '$str.encode returns a blob8';
ok ('ab'.encode('ASCII') eqv blob8.new(97, 98)),  'encoding to ASCII';
is 'ab'.encode('ASCII').elems, 2, 'right length of Buf';
ok ('ö'.encode('UTF-8') eqv utf8.new(195, 182)), 'encoding to UTF-8';
is 'ab'.encode('UTF-8').elems, 2, 'right length of Buf';
is 'ö'.encode('UTF-8')[0], 195, 'indexing a utf8 gives correct value (1)';
is 'ö'.encode('UTF-8')[1], 182, 'indexing a utf8 gives correct value (1)';
is '€‚ƒ„…†‡ˆ‰Š‹ŒŽ'.encode('windows-1252').values, (0x80,0x82..0x8c,0x8e), 'cp1252 encodes most C1 substitutes';
#?rakudo.jvm todo 'builtin JVM cp1252 code folds these RT #124686'
is ''.encode('windows-1252').values, (0x81,0x8d,0x8f), 'cp1252 encode tolerates unassigned C1 characters';

# RT#107204
#?rakudo.jvm todo 'JVM builtin code folds these RT #124686'
throws-like '"aouÄÖÜ".encode("latin1").decode("utf8")', Exception, message => rx:s:i/line 1 col\w* 4/;
#?rakudo.jvm todo 'JVM builtin code folds these RT #124686'
throws-like '"ssß".encode("latin1").decode("utf8")', Exception, message => rx:s:i/term/;
#?rakudo todo 'RT#107204 should say line and column or mention term(ination)'
throws-like '"aoaou".encode("latin1").decode("utf16")', Exception, message => rx:s:i/line 1 col\w* 2|term/;
#?rakudo todo 'RT#107204 should say line and column'
throws-like '"aouÄÖÜ".encode("latin1").decode("utf16")', Exception, message => rx:s:i/line 1 col\w* 2/;

is 'abc'.encode()[0], 97, 'can index one element in a Buf';
is-deeply 'abc'.encode()[1, 2], (98, 99), 'can slice-index a Buf';

# verified with Perl 5:
# perl -CS -Mutf8 -MUnicode::Normalize -e 'print NFD("ä")' | hexdump -C
#?rakudo skip 'We do not handle NDF yet RT #124687'
ok ('ä'.encode('UTF-8', 'D') eqv Buf.new(:16<61>, :16<cc>, :16<88>)),
                'encoding to UTF-8, with NFD';

ok ('ä'.encode('UTF-8') eqv utf8.new(:16<c3>, :16<a4>)),
                'encoding ä utf8 gives correct numbers';

ok Buf.new(195, 182).decode ~~ Str, '.decode returns a Str';
is Buf.new(195, 182).decode, 'ö', 'decoding a Buf with UTF-8';
is Buf.new(246).decode('ISO-8859-1'), 'ö', 'decoding a Buf with Latin-1';
is Buf.new(0x80,0x82..0x8c,0x8e).decode('windows-1252'),'€‚ƒ„…†‡ˆ‰Š‹ŒŽ', 'cp1252 decodes most C1 substitutes';
#?rakudo.jvm todo 'builtin JVM cp1252 code folds these RT #124686'
is Buf.new(0x81,0x8d,0x8f).decode('windows-1252'), '', 'cp1252 decode tolerates unassigned C1 characters';

ok Buf ~~ Stringy, 'Buf does Stringy';
ok Buf ~~ Positional, 'Buf does Positional';

is 'abc'.encode('ascii').list.join(','), '97,98,99', 'Buf.list gives list of codepoints';

{
    my $temp;

    ok $temp = "\x1F63E".encode('UTF-16'), 'encode a string to UTF-16 surrogate pair';
    ok $temp = utf16.new($temp),           'creating utf16 Buf from a surrogate pair';
    is $temp[0], 0xD83D,                   'indexing a utf16 gives correct value';
    is $temp[1], 0xDE3E,                   'indexing a utf16 gives correct value';
    is $temp.decode(), "\x1F63E",          'decoding utf16 Buf to original value';
}

# RT #120651
lives-ok { "\x[effff]".encode('utf-8') },           'Can encode noncharacters to UTF-8';
is "\x[effff]".encode('utf-8').decode, "\x[effff]", 'Noncharacters round-trip with UTF-8';

# RT #123673
#?rakudo.jvm skip 'Only moar handles this'
{
    for (
        'å', 'ascii', '?',
        '☃', 'latin-1', '?',
        '☃', 'windows-1252', '?',
        "\x[FFFFFF]", 'utf-8', "\x[FFFD]",
        "\x[FFFFFF]", 'utf-16', "\x[FFFD]",
    ) -> $string, $encoding, $default-replacement {
        subtest {
            throws-like { $string.encode($encoding) }, Exception, message => rx:s:i/Error encoding $encoding string/,
                'No replacement dies';
            is $string.encode($encoding, :replacement).decode($encoding), $default-replacement,
                'Default replacement';
            is $string.encode($encoding, :replacement('')).decode($encoding), '',
                'Zero-character replacement';
            is $string.encode($encoding, :replacement('XXX')).decode($encoding), 'XXX',
                'Multi-character replacement';
        }, "Non-$encoding character";
    }
}

# Covers a UTF-16 BOM bug.
#?rakudo.jvm todo 'uft-16'
is Buf.new([255, 254, 72, 0, 101, 0]).decode("utf-16"), 'He', 'utf-16 BOM handled ok';

# RT#128184
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
            176,1,149,233);

    for @bufs.kv -> $i, $buf {
        #?rakudo.jvm skip 'uft8-c8 NIY'
        #?rakudo.moar todo 'RT 128184'
        is-deeply Buf.new($buf.decode('utf8-c8').encode('utf8-c8').list), $buf,
            ".decode.encode roundtrips correctly for utf8-c8 [Buf #{$i+1}]";
    }
}

# vim: ft=perl6
