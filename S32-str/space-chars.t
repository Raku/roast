use v6;
use Test;

use lib $?FILE.IO.parent(2).add('packages/Test-Helpers');
use Test::Misc :int2hexstr, :show-space-chars;

# non-breaking ws chars
my @nbchars = [
    0x00A0, # NO-BREAK SPACE
    0x202F, # NARROW NO-BREAK SPACE

    # the following chars are causing problems when trying to convert to a string rep
    0x2060, # WORD JOINER
    0xFEFF, # ZERO WIDTH NO-BREAK SPACE
];

# breaking ws chars
my @bchars = [
    0x000A, # LINE FEED (LF)              vertical
    0x000B, # LINE TABULATION             vertical
    0x000C, # FORM FEED (FF)              vertical
    0x000D, # CARRIAGE RETURN (CR)        vertical
    0x2028, # LINE SEPARATOR              vertical
    0x2029, # PARAGRAPH SEPARATOR         vertical

    0x0009, # CHARACTER TABULATION
    0x0020, # SPACE
    0x1680, # OGHAM SPACE MARK
    0x180E, # MONGOLIAN VOWEL SEPARATOR

    # these get special handling:
    0x2000, # EN QUAD <= gets normalized to 0x2002
    0x2001, # EM QUAD <= gets normalized to 0x2003

    0x2002, # EN SPACE
    0x2003, # EM SPACE
    0x2004, # THREE-PER-EM SPACE
    0x2005, # FOUR-PER-EM SPACE
    0x2006, # SIX-PER-EM SPACE
    0x2007, # FIGURE SPACE                <= unicode considers this non-breaking, but we won't
    0x2008, # PUNCTUATION SPACE
    0x2009, # THIN SPACE
    0x200A, # HAIR SPACE
    0x200B, # ZERO WIDTH SPACE
    0x200C, # ZERO WIDTH NON-JOINER
    0x200D, # ZERO WIDTH JOINER
    0x205F, # MEDIUM MATHEMATICAL SPACE
    0x3000, # IDEOGRAPHIC SPACE
];

plan @bchars.elems + @nbchars.elems;

for @nbchars -> $hexint {
    # test is to convert hex int to char, then back to hex int to check
    my $char = $hexint.chr;
    my $int2 = $char.ord;
    cmp-ok $hexint, '==', $int2, "incoming hex '{int2hexstr($hexint)}'";
}

for @bchars -> $hexint {
    # test is to convert hex int to char, then back to hex int to check
    if $hexint == 0x2000 {
        my $char  = $hexint.chr;
        my $char2 = 0x2002.chr;
        my $int2  = $char.ord;
        my $int2a = $char2.ord;
        #?rakudo.jvm todo "JVM doesn't pass yet"
        cmp-ok $int2a, '==', $int2, "incoming hex '{int2hexstr($hexint)}' (gets normalized to 0x2002.chr)";
    }
    elsif $hexint == 0x2001 {
        my $char  = $hexint.chr;
        my $char2 = 0x2003.chr;
        my $int2 = $char.ord;
        my $int2a = $char2.ord;
        #?rakudo.jvm todo "JVM doesn't pass yet"
        cmp-ok $int2a, '==', $int2, "incoming hex '{int2hexstr($hexint)}' (gets normalized to 0x2003.chr)";
    }
    else {
        my $char = $hexint.chr;
        my $int2 = $char.ord;
        cmp-ok $hexint, '==', $int2, "incoming hex '{int2hexstr($hexint)}'";
    }
}
# vim: expandtab shiftwidth=4
