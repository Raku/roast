use Test;

plan 4;

sub spurt-bin($file, $buf) {
    given open($file, :bin, :w) {
        .write: $buf;
        .close;
    }
}

sub nonce () { return (".{$*PID}." ~ 1000.rand.Int) }
my $tmpfile = "temp-test" ~ nonce();

{
    # UTF-8 of codepoints 0044 0307 0323
    spurt-bin $tmpfile, buf8.new(68, 204, 135, 204, 163);
    my $s = slurp $tmpfile, enc => 'utf-8';
    is $s.chars, 1, 'Reading UTF-8 file as NFG (one grapheme)';
}

{
    # UTF-8 of codepoints 0044 0307 0323 0044 0307 0044 0323
    spurt-bin $tmpfile, buf8.new(68, 204, 135, 204, 163, 68, 204, 135, 68, 204, 163);
    my $s = slurp $tmpfile, enc => 'utf-8';
    is $s.chars, 3, 'Reading UTF-8 file as NFG (a few graphemes)';
}

#?rakudo skip 'writing utf16 NYI RT #124910'
{
    # UTF-16 of codepoints 0044 0307 0323
    spurt-bin $tmpfile, buf16.new(68, 775, 803);
    my $s = slurp $tmpfile, enc => 'utf-16';
    is $s.chars, 1, 'Reading UTF-16 file as NFG (one grapheme)';
}

#?rakudo skip 'writing utf16 NYI RT #124911'
{
    # UTF-16 of codepoints 0044 0307 0323 0044 0307 0044 0323
    spurt-bin $tmpfile, buf16.new(68, 775, 803, 68, 775, 68, 803);
    my $s = slurp $tmpfile, enc => 'utf-16';
    is $s.chars, 3, 'Reading UTF-16 file as NFG (a few graphemes)';
}

unlink $tmpfile;
