use v6;
use Test;

plan 72;

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

    is $x.fc.chars, 1, 'fc still gives us one char';
    isnt $x.fc, $x, 'fc does not give identity';
    is $x.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'fc gives correct NFD';
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

    is $x.fc.chars, 1, 'fc still gives us one char';
    is $x.fc, $x, 'fc gives identity';
    is $x.fc.NFD.list, (0x0064, 0x0323, 0x0307), 'fc gives correct NFD';
}

# LATIN SMALL LETTER J WITH CARON, COMBINING DOT BELOW
# Interesting because on .uc, .tc there is no precomposed uppercase char, so
# we will have to form a new synthetic. And with .fc, the CaseFolder table
# has us take it to pieces, but we'll still need to re-compose it for NFG.
{
    my $x = Uni.new(0x01F0, 0x0323).Str;
    is $x.chars, 1, 'Sanity: 0x01F0, 0x0323 = 1 grapheme';

    is $x.uc.chars, 1, 'uc still gives us one char';
    isnt $x.uc, $x, 'uc does not give identity';
    is $x.uc.NFD.list, (0x004A, 0x0323, 0x030C), 'uc gives correct NFD';

    is $x.lc.chars, 1, 'lc still gives us one char';
    is $x.lc, $x, 'lc gives identity';
    is $x.lc.NFD.list, (0x006a, 0x0323, 0x030c), 'lc gives correct NFD';

    is $x.tc.chars, 1, 'tc still gives us one char';
    isnt $x.tc, $x, 'tc does not give identity';
    is $x.tc.NFD.list, (0x004A, 0x0323, 0x030C), 'tc gives correct NFD';

    is $x.fc.chars, 1, 'fc still gives us one char';
    is $x.fc, $x, 'fc gives identity';
    is $x.fc.NFD.list, (0x006a, 0x0323, 0x030c), 'fc gives correct NFD';
}

# LATIN SMALL LIGATURE FF, COMBINING DOT BELOW
# This is trickier than the previous one. Which it can casefold to two
# codepoints, the second is a combiner. But this expands to two base
# chars, meaning that we need to make sure to sneak the combiner in
# between the two.
{
    my $x = Uni.new(0xFB00, 0x0323).Str;
    is $x.chars, 1, 'Sanity: 0xFB00, 0x0323 = 1 grapheme';

    is $x.uc.chars, 2, 'uc gives us 2 chars';
    isnt $x.uc, $x, 'uc does not give identity';
    is $x.uc.NFD.list, (0x0046, 0x0323, 0x0046), 'uc gives correct NFD';

    is $x.lc.chars, 1, 'lc still gives us one char';
    is $x.lc, $x, 'lc gives identity';
    is $x.lc.NFD.list, (0xFB00, 0x0323), 'lc gives correct NFD';

    is $x.tc.chars, 2, 'tc gives us two chars';
    isnt $x.tc, $x, 'tc does not give identity';
    is $x.tc.NFD.list, (0x0046, 0x0323, 0x0066), 'tc gives correct NFD';

    is $x.fc.chars, 2, 'fc gives us two chars';
    isnt $x.fc, $x, 'fc gives identity';
    is $x.fc.NFD.list, (0x0066, 0x0323, 0x0066), 'fc gives correct NFD';
}

{
    my $Prepend = "\c[ARABIC NUMBER SIGN]";
    my $Extend  = "\c[COMBINING CARON]";
    for ^10 {
        my $lower = "{$Prepend x $_}á{$Extend x (9 - $_)}";
        my $upper = "{$Prepend x $_}Á{$Extend x (9 - $_)}";
        is-deeply $lower.uc, $upper, "Prepend + á + Extend casechange is correct: .uc: (Prepend x $_ ~ 'á' ~ Extend x {9 - $_}).uc";
        is-deeply $upper.lc, $lower, "Prepend + Á + Extend casechange is correct: .lc: (Prepend x $_ ~ 'á' ~ Extend x {9 - $_}).lc";
    }
}
