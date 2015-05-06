use Test;

plan 12;

# Tests with 6 codepoints (4 in NFC), which are 2 graphs.
# LATIN CAPITAL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE,
# LATIN SMALL LETTER D, COMBINING DOT BELOW, COMBINING DOT ABOVE
{
    my $x = Uni.new(0x0044, 0x0323, 0x0307, 0x0064, 0x0323, 0x0307).Str;

    # Basic grapheme level matching.
    ok $x ~~ /^..$/, 'Str matches at grapheme level';
    ok $x !~~ /^....$/, '(and not NFC code points)'; 
    ok $x !~~ /^......$/, '(and certainly not the input code points!)';

    # Character classes work on the base character.
    ok $x ~~ /^\w\w$/, 'Can use character classes on the graphemes';
    ok $x ~~ /^\w+$/, 'Can use character classes on the graphemes (quantified)';
    is $/.chars, 2, '...and get the 2 graphemes matched';

    # Enumerated character classes don't accidentally discard the combiners, though.
    nok $x ~~ /<[Dd]>/, 'Do not have accidents involving enumerated char class and base char';
    nok $x ~~ /<[\x1E0C\x1E0D]>/, 'Do not have accidents involving enumerated char class and NFC';
    nok $x ~~ /<[D..d]>/, 'Do not have accidents involving range char class and base char';
    #?rakudo todo 'charrange bugginess with synthetics'
    nok $x ~~ /<[\x1E0C..\x1E0D]>/, 'Do not have accidents involving range char class and NFC';

    # Character properties work on the base character.
    ok $x ~~ /^<:Lu><:Ll>$/, 'Can use Unicode properties on grapheme';
    ok $x ~~ /^<:L>+$/, 'Can use Unicode properties on grapheme (quantified)';
}
