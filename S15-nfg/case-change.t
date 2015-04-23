use Test;

plan 20;

# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0044, 0x0323, 0x0307).Str;
    is $x.chars, 1, 'Sanity: 0x0044, 0x0323, 0x0307 = 1 grapheme';

    is $x.uc.chars, 1, 'uc still gives us one char';
    is $x.uc, $x, 'uc gives identity';
    is $x.uc.NFD.list, (0x0044, 0x0323, 0x0307), 'uc gives correct NFD';

    is $x.lc.chars, 1, 'lc still gives us one char';
    isnt $x.lc, $x, 'lc does not give identity';
    is $x.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'lc gives correct NFD';

    is $x.tc.chars, 1, 'tc still gives us one char';
    is $x.tc, $x, 'tc gives identity';
    is $x.tc.NFD.list, (0x0044, 0x0323, 0x0307), 'tc gives correct NFD';
}

# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0064, 0x0323, 0x0307).Str;
    is $x.chars, 1, 'Sanity: 0x0064, 0x0323, 0x0307 = 1 grapheme';

    is $x.uc.chars, 1, 'uc still gives us one char';
    isnt $x.uc, $x, 'uc does not give identity';
    is $x.uc.NFD.list, (0x0044, 0x0323, 0x0307), 'uc gives correct NFD';

    is $x.lc.chars, 1, 'lc still gives us one char';
    is $x.lc, $x, 'lc gives identity';
    is $x.lc.NFD.list, (0x0064, 0x0323, 0x0307), 'lc gives correct NFD';

    is $x.tc.chars, 1, 'tc still gives us one char';
    isnt $x.tc, $x, 'tc does not give identity';
    is $x.tc.NFD.list, (0x0044, 0x0323, 0x0307), 'tc gives correct NFD';
}
