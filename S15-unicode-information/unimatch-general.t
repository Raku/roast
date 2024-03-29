use Test;

plan 224;

#use unicode :v(6.3)

# L<S15/Binary Category Check>

is unimatch("",'Nd'), Nil, "unimatch an empty string yields Nil";
is "".unimatch('Nd'), Nil, "''.unimatch yields Nil";
throws-like "unimatch Str, 'Latin'", X::Multi::NoMatch, 'cannot call unimatch with a Str';
throws-like "Str.unimatch: 'Latin'", X::Multi::NoMatch, 'cannot call unimatch with a Str';
throws-like "unimatch Int, 'Latin'", X::Multi::NoMatch, 'cannot call unimatch with a Int';
throws-like "Int.unimatch: 'Latin'", X::Multi::NoMatch, 'cannot call unimatch with a Int';

nok unimatch(0x29, 'Nd'), "0x29 is not Nd";
ok unimatch(0x30, 'Nd'), "0x30 is Nd";
ok unimatch('0', 'Nd'), "'0' is Nd";
ok unimatch(0x39, 'Nd'), "0x39 is Nd";
ok unimatch('9', 'Nd'), "'9' is Nd";
nok unimatch(0x3a, 'Nd'), "0x3a is not Nd";

ok unimatch('⅓', 'No'), "'⅓' is No";
nok unimatch('⅓', 'Nd'), "'⅓' is not Nd";

nok 0x29.unimatch('Nd'), "0x29 is not Nd";
ok 0x30.unimatch('Nd'), "0x30 is Nd";
ok '0'.unimatch('Nd'), "'0' is Nd";
ok 0x39.unimatch('Nd'), "0x39 is Nd";
ok '9'.unimatch('Nd'), "'9' is Nd";
nok 0x3a.unimatch('Nd'), "0x3a is not Nd";

ok '⅓'.unimatch('No'), "'⅓' is No";
nok '⅓'.unimatch('Nd'), "'⅓' is not Nd";

ok unimatch("\c[AEGEAN NUMBER NINETY THOUSAND]", 'No'), "AEGEAN NUMBER NINETY THOUSAND is No";
ok unimatch("\c[MATHEMATICAL MONOSPACE DIGIT ZERO]", 'Nd'), "MATHEMATICAL MONOSPACE DIGIT ZERO is Nd";

ok unimatch('פ', 'Hebrew'), "'פ' is in block Hebrew";
ok unimatch('💩', 'Miscellaneous_Symbols_And_Pictographs'), "'💩' is in block Miscellaneous_Symbols_And_Pictographs";
ok unimatch('💩', 'MiscellaneousSymbolsAndPictographs'), "'💩' is in block MiscellaneousSymbolsAndPictographs";
ok unimatch('💩', 'miscellaneoussymbolsandpictographs'), "'💩' is in block miscellaneoussymbolsandpictographs";

# A random selection of general categories
ok unimatch("\x0023", "Po"), "NUMBER SIGN matches Po";
ok unimatch("\x0061", "L"), "LATIN SMALL LETTER A matches L";
ok unimatch("\x0085", "Cc"), "<control-0085> matches Cc";
ok unimatch("\x00A6", "So"), "BROKEN BAR matches So";
ok unimatch("\x00AB", "Pi"), "LEFT-POINTING DOUBLE ANGLE QUOTATION MARK matches Pi";
ok unimatch("\x00B4", "Sk"), "ACUTE ACCENT matches Sk";
ok unimatch("\x00BB", "Pf"), "RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK matches Pf";
ok unimatch("\x02C0", "Lm"), "MODIFIER LETTER GLOTTAL STOP matches Lm";
ok unimatch("\x02EE", "Lm"), "MODIFIER LETTER DOUBLE APOSTROPHE matches Lm";
ok unimatch("\x03D5", "L"), "GREEK PHI SYMBOL matches L";
ok unimatch("\x03F5", "L"), "GREEK LUNATE EPSILON SYMBOL matches L";
ok unimatch("\x0559", "Lm"), "ARMENIAN MODIFIER LETTER LEFT HALF RING matches Lm";
ok unimatch("\x05C2", "Mn"), "HEBREW POINT SIN DOT matches Mn";
ok unimatch("\x061A", "Mn"), "ARABIC SMALL KASRA matches Mn";
ok unimatch("\x082C", "Mn"), "SAMARITAN VOWEL SIGN SUKUN matches Mn";
ok unimatch("\x0902", "Mn"), "DEVANAGARI SIGN ANUSVARA matches Mn";
ok unimatch("\x09BE", "Mc"), "BENGALI VOWEL SIGN AA matches Mc";
ok unimatch("\x0A4D", "Mn"), "GURMUKHI SIGN VIRAMA matches Mn";
ok unimatch("\x0AC0", "Mc"), "GUJARATI VOWEL SIGN II matches Mc";
ok unimatch("\x0B47", "Mc"), "ORIYA VOWEL SIGN E matches Mc";
ok unimatch("\x0B62", "Mn"), "ORIYA VOWEL SIGN VOCALIC L matches Mn";
ok unimatch("\x0B82", "Mn"), "TAMIL SIGN ANUSVARA matches Mn";
ok unimatch("\x0BD7", "Mc"), "TAMIL AU LENGTH MARK matches Mc";
ok unimatch("\x0D46", "Mc"), "MALAYALAM VOWEL SIGN E matches Mc";
ok unimatch("\x0D82", "Mc"), "SINHALA SIGN ANUSVARAYA matches Mc";
ok unimatch("\x0F35", "Mn"), "TIBETAN MARK NGAS BZUNG NYI ZLA matches Mn";
ok unimatch("\x0F77", "Mn"), "TIBETAN VOWEL SIGN VOCALIC RR matches Mn";
ok unimatch("\x0F80", "Mn"), "TIBETAN VOWEL SIGN REVERSED I matches Mn";
ok unimatch("\x135F", "Mn"), "ETHIOPIC COMBINING GEMINATION MARK matches Mn";
ok unimatch("\x17B5", "Mn"), "KHMER VOWEL INHERENT AA matches Mn";
ok unimatch("\x1933", "Mc"), "LIMBU SMALL LETTER TA matches Mc";
ok unimatch("\x19DA", "No"), "NEW TAI LUE THAM DIGIT ONE matches No";
ok unimatch("\x1AA8", "Po"), "TAI THAM SIGN KAAN matches Po";
ok unimatch("\x1B3D", "Mc"), "BALINESE VOWEL SIGN LA LENGA TEDUNG matches Mc";
ok unimatch("\x1BE8", "Mn"), "BATAK VOWEL SIGN PAKPAK E matches Mn";
ok unimatch("\x1CF4", "Mn"), "VEDIC TONE CANDRA ABOVE matches Mn";
ok unimatch("\x201D", "Pf"), "RIGHT DOUBLE QUOTATION MARK matches Pf";
ok unimatch("\x203A", "Pf"), "SINGLE RIGHT-POINTING ANGLE QUOTATION MARK matches Pf";
ok unimatch("\x2047", "Po"), "DOUBLE QUESTION MARK matches Po";
ok unimatch("\x213C", "L"), "DOUBLE-STRUCK SMALL PI matches L";
ok unimatch("\x2190", "Sm"), "LEFTWARDS ARROW matches Sm";
ok unimatch("\x21A1", "So"), "DOWNWARDS TWO HEADED ARROW matches So";
ok unimatch("\x21A2", "So"), "LEFTWARDS ARROW WITH TAIL matches So";
ok unimatch("\x21A4", "So"), "LEFTWARDS ARROW FROM BAR matches So";
ok unimatch("\x21B6", "So"), "ANTICLOCKWISE TOP SEMICIRCLE ARROW matches So";
ok unimatch("\x2212", "Sm"), "MINUS SIGN matches Sm";
ok unimatch("\x230C", "So"), "BOTTOM RIGHT CROP matches So";
ok unimatch("\x25A1", "So"), "WHITE SQUARE matches So";
ok unimatch("\x25C0", "So"), "BLACK LEFT-POINTING TRIANGLE matches So";
ok unimatch("\x25E2", "So"), "BLACK LOWER RIGHT TRIANGLE matches So";
ok unimatch("\x27EB", "Pe"), "MATHEMATICAL RIGHT DOUBLE ANGLE BRACKET matches Pe";
ok unimatch("\x2984", "Pe"), "RIGHT WHITE CURLY BRACKET matches Pe";
ok unimatch("\x2984", "Pe"), "RIGHT WHITE CURLY BRACKET matches Pe";
ok unimatch("\x2988", "Pe"), "Z NOTATION RIGHT IMAGE BRACKET matches Pe";
ok unimatch("\x298E", "Pe"), "RIGHT SQUARE BRACKET WITH TICK IN BOTTOM CORNER matches Pe";
ok unimatch("\x2992", "Pe"), "RIGHT ANGLE BRACKET WITH DOT matches Pe";
ok unimatch("\x2995", "Ps"), "DOUBLE LEFT ARC GREATER-THAN BRACKET matches Ps";
ok unimatch("\x29FD", "Pe"), "RIGHT-POINTING CURVED ANGLE BRACKET matches Pe";
ok unimatch("\x2B45", "So"), "LEFTWARDS QUADRUPLE ARROW matches So";
ok unimatch("\x2C7C", "Lm"), "LATIN SUBSCRIPT SMALL LETTER J matches Lm";
ok unimatch("\x2E29", "Pe"), "RIGHT DOUBLE PARENTHESIS matches Pe";
ok unimatch("\x2E2F", "Lm"), "VERTICAL TILDE matches Lm";
ok unimatch("\x2E3A", "Pd"), "TWO-EM DASH matches Pd";
ok unimatch("\x3002", "Po"), "IDEOGRAPHIC FULL STOP matches Po";
ok unimatch("\x300F", "Pe"), "RIGHT WHITE CORNER BRACKET matches Pe";
ok unimatch("\x3013", "So"), "GETA MARK matches So";
ok unimatch("\x3016", "Ps"), "LEFT WHITE LENTICULAR BRACKET matches Ps";
ok unimatch("\x3400", "Lo"), "CJK UNIFIED IDEOGRAPH-3400 matches Lo";
ok unimatch("\x4DB5", "Lo"), "CJK UNIFIED IDEOGRAPH-4DB5 matches Lo";
ok unimatch("\xA67C", "Mn"), "COMBINING CYRILLIC KAVYKA matches Mn";
ok unimatch("\xA876", "Po"), "PHAGS-PA MARK SHAD matches Po";
ok unimatch("\xA8B4", "Mc"), "SAURASHTRA CONSONANT SIGN HAARU matches Mc";
ok unimatch("\xA8CF", "Po"), "SAURASHTRA DOUBLE DANDA matches Po";
ok unimatch("\xA9C9", "Po"), "JAVANESE PADA LUNGSI matches Po";
ok unimatch("\xAAC1", "Mn"), "TAI VIET TONE MAI THO matches Mn";
ok unimatch("\xABE4", "Mc"), "MEETEI MAYEK VOWEL SIGN INAP matches Mc";
ok unimatch("\xFA29", "Lo"), "CJK COMPATIBILITY IDEOGRAPH-FA29 matches Lo";
ok unimatch("\xFDD0", "Cn"), "<noncharacter-FDD0> matches Cn";
ok unimatch("\xFE61", "Po"), "SMALL ASTERISK matches Po";
ok unimatch("\xFE63", "Pd"), "SMALL HYPHEN-MINUS matches Pd";
ok unimatch("\xFFFE", "Cn"), "<noncharacter-FFFE> matches Cn";
ok unimatch("\x10A57", "Po"), "KHAROSHTHI PUNCTUATION DOUBLE DANDA matches Po";
ok unimatch("\x10B3F", "Po"), "LARGE ONE RING OVER TWO RINGS PUNCTUATION matches Po";
ok unimatch("\x110B6", "Mn"), "KAITHI VOWEL SIGN AI matches Mn";
ok unimatch("\x111B3", "Mc"), "SHARADA VOWEL SIGN AA matches Mc";
ok unimatch("\x111B6", "Mn"), "SHARADA VOWEL SIGN U matches Mn";
ok unimatch("\x116AC", "Mc"), "TAKRI SIGN VISARGA matches Mc";
ok unimatch("\x116B6", "Mc"), "TAKRI SIGN VIRAMA matches Mc";
ok unimatch("\x16F9F", "Lm"), "MIAO LETTER REFORMED TONE-8 matches Lm";
ok unimatch("\x1D4BB", "LC"), "MATHEMATICAL SCRIPT SMALL F matches L&";
ok unimatch("\x1D4C5", "LC"), "MATHEMATICAL SCRIPT SMALL P matches L&";
ok unimatch("\x1D50A", "LC"), "MATHEMATICAL FRAKTUR CAPITAL G matches L&";
ok unimatch("\x1D58F", "LC"), "MATHEMATICAL BOLD FRAKTUR SMALL J matches L&";
ok unimatch("\x1EE47", "Lo"), "ARABIC MATHEMATICAL TAILED HAH matches Lo";
ok unimatch("\x1EE4D", "Lo"), "ARABIC MATHEMATICAL TAILED NOON matches Lo";
ok unimatch("\x1EE4F", "Lo"), "ARABIC MATHEMATICAL TAILED AIN matches Lo";
ok unimatch("\x3FFFE", "Cn"), "<noncharacter-3FFFE> matches Cn";
ok unimatch("\x6FFFE", "Cn"), "<noncharacter-6FFFE> matches Cn";
ok unimatch("\xE0020", "Cf"), "TAG SPACE matches Cf";
ok unimatch("\xEFFFE", "Cn"), "<noncharacter-EFFFE> matches Cn";

# A random selection of PropList properties
ok unimatch("\x0020", "Pattern_White_Space"), "SPACE matches Pattern_White_Space";
ok unimatch("\x003A", "Pattern_Syntax"), "COLON matches Pattern_Syntax";
ok unimatch("\x003A", "Terminal_Punctuation"), "COLON matches Terminal_Punctuation";
ok unimatch("\x00B8", "Diacritic"), "CEDILLA matches Diacritic";
ok unimatch("\x02C1", "Diacritic"), "MODIFIER LETTER REVERSED GLOTTAL STOP matches Diacritic";
ok unimatch("\x02E4", "Other_Lowercase"), "MODIFIER LETTER SMALL REVERSED GLOTTAL STOP matches Other_Lowercase";
ok unimatch("\x02E5", "Diacritic"), "MODIFIER LETTER EXTRA-HIGH TONE BAR matches Diacritic";
ok unimatch("\x02EC", "Diacritic"), "MODIFIER LETTER VOICING matches Diacritic";
ok unimatch("\x02FF", "Diacritic"), "MODIFIER LETTER LOW LEFT ARROW matches Diacritic";
ok unimatch("\x0483", "Diacritic"), "COMBINING CYRILLIC TITLO matches Diacritic";
ok unimatch("\x05A1", "Diacritic"), "HEBREW ACCENT PAZER matches Diacritic";
ok unimatch("\x05C4", "Diacritic"), "HEBREW MARK UPPER DOT matches Diacritic";
ok unimatch("\x060C", "Terminal_Punctuation"), "ARABIC COMMA matches Terminal_Punctuation";
ok unimatch("\x064B", "Diacritic"), "ARABIC FATHATAN matches Diacritic";
ok unimatch("\x0657", "Other_Alphabetic"), "ARABIC INVERTED DAMMA matches Other_Alphabetic";
ok unimatch("\x0700", "Terminal_Punctuation"), "SYRIAC END OF PARAGRAPH matches Terminal_Punctuation";
ok unimatch("\x07B0", "Diacritic"), "THAANA SUKUN matches Diacritic";
ok unimatch("\x08E4", "Other_Alphabetic"), "ARABIC CURLY FATHA matches Other_Alphabetic";
ok unimatch("\x08FE", "Other_Alphabetic"), "ARABIC DAMMA WITH DOT matches Other_Alphabetic";
ok unimatch("\x0964", "Terminal_Punctuation"), "DEVANAGARI DANDA matches Terminal_Punctuation";
ok unimatch("\x0A3E", "Other_Alphabetic"), "GURMUKHI VOWEL SIGN AA matches Other_Alphabetic";
ok unimatch("\x0A51", "Other_Alphabetic"), "GURMUKHI SIGN UDAAT matches Other_Alphabetic";
ok unimatch("\x0AC1", "Other_Alphabetic"), "GUJARATI VOWEL SIGN U matches Other_Alphabetic";
ok unimatch("\x0B57", "Other_Alphabetic"), "ORIYA AU LENGTH MARK matches Other_Alphabetic";
ok unimatch("\x0BC1", "Other_Alphabetic"), "TAMIL VOWEL SIGN U matches Other_Alphabetic";
ok unimatch("\x0D44", "Other_Alphabetic"), "MALAYALAM VOWEL SIGN VOCALIC RR matches Other_Alphabetic";
ok unimatch("\x0E31", "Other_Alphabetic"), "THAI CHARACTER MAI HAN-AKAT matches Other_Alphabetic";
ok unimatch("\x0E47", "Diacritic"), "THAI CHARACTER MAITAIKHU matches Diacritic";
ok unimatch("\x0EB1", "Other_Alphabetic"), "LAO VOWEL SIGN MAI KAN matches Other_Alphabetic";
ok unimatch("\x0F3E", "Diacritic"), "TIBETAN SIGN YAR TSHES matches Diacritic";
ok unimatch("\x0F97", "Other_Alphabetic"), "TIBETAN SUBJOINED LETTER JA matches Other_Alphabetic";
ok unimatch("\x103C", "Other_Alphabetic"), "MYANMAR CONSONANT SIGN MEDIAL RA matches Other_Alphabetic";
ok unimatch("\x108F", "Diacritic"), "MYANMAR SIGN RUMAI PALAUNG TONE-5 matches Diacritic";
ok unimatch("\x1361", "Terminal_Punctuation"), "ETHIOPIC WORDSPACE matches Terminal_Punctuation";
ok unimatch("\x1B36", "Other_Alphabetic"), "BALINESE VOWEL SIGN ULU matches Other_Alphabetic";
ok unimatch("\x1B6B", "Diacritic"), "BALINESE MUSICAL SYMBOL COMBINING TEGEH matches Diacritic";
ok unimatch("\x1B73", "Diacritic"), "BALINESE MUSICAL SYMBOL COMBINING GONG matches Diacritic";
ok unimatch("\x1BE7", "Other_Alphabetic"), "BATAK VOWEL SIGN E matches Other_Alphabetic";
ok unimatch("\x1BEA", "Other_Alphabetic"), "BATAK VOWEL SIGN I matches Other_Alphabetic";
ok unimatch("\x1C3C", "STerm"), "LEPCHA PUNCTUATION NYET THYOOM TA-ROL matches STerm";
ok unimatch("\x1D62", "Soft_Dotted"), "LATIN SUBSCRIPT SMALL LETTER I matches Soft_Dotted";
ok unimatch("\x1ECB", "Soft_Dotted"), "LATIN SMALL LETTER I WITH DOT BELOW matches Soft_Dotted";
ok unimatch("\x1FFE", "Diacritic"), "GREEK DASIA matches Diacritic";
ok unimatch("\x200C", "Join_Control"), "ZERO WIDTH NON-JOINER matches Join_Control";
ok unimatch("\x201B", "Quotation_Mark"), "SINGLE HIGH-REVERSED-9 QUOTATION MARK matches Quotation_Mark";
ok unimatch("\x203C", "Terminal_Punctuation"), "DOUBLE EXCLAMATION MARK matches Terminal_Punctuation";
ok unimatch("\x2053", "Pattern_Syntax"), "SWUNG DASH matches Pattern_Syntax";
ok unimatch("\x209C", "Other_Lowercase"), "LATIN SUBSCRIPT SMALL LETTER T matches Other_Lowercase";
ok unimatch("\x21A1", "Other_Math"), "DOWNWARDS TWO HEADED ARROW matches Other_Math";
ok unimatch("\x21D1", "Pattern_Syntax"), "UPWARDS DOUBLE ARROW matches Pattern_Syntax";
ok unimatch("\x2321", "Pattern_Syntax"), "BOTTOM HALF INTEGRAL matches Pattern_Syntax";
ok unimatch("\x24E9", "Other_Alphabetic"), "CIRCLED LATIN SMALL LETTER Z matches Other_Alphabetic";
ok unimatch("\x25C7", "Other_Math"), "WHITE DIAMOND matches Other_Math";
ok unimatch("\x276E", "Pattern_Syntax"), "HEAVY LEFT-POINTING ANGLE QUOTATION MARK ORNAMENT matches Pattern_Syntax";
ok unimatch("\x2770", "Pattern_Syntax"), "HEAVY LEFT-POINTING ANGLE BRACKET ORNAMENT matches Pattern_Syntax";
ok unimatch("\x2773", "Pattern_Syntax"), "LIGHT RIGHT TORTOISE SHELL BRACKET ORNAMENT matches Pattern_Syntax";
ok unimatch("\x2774", "Pattern_Syntax"), "MEDIUM LEFT CURLY BRACKET ORNAMENT matches Pattern_Syntax";
ok unimatch("\x27E9", "Pattern_Syntax"), "MATHEMATICAL RIGHT ANGLE BRACKET matches Pattern_Syntax";
ok unimatch("\x298F", "Other_Math"), "LEFT SQUARE BRACKET WITH TICK IN BOTTOM CORNER matches Other_Math";
ok unimatch("\x2991", "Other_Math"), "LEFT ANGLE BRACKET WITH DOT matches Other_Math";
ok unimatch("\x2997", "Pattern_Syntax"), "LEFT BLACK TORTOISE SHELL BRACKET matches Pattern_Syntax";
ok unimatch("\x29FC", "Other_Math"), "LEFT-POINTING CURVED ANGLE BRACKET matches Other_Math";
ok unimatch("\x2C7C", "Other_Lowercase"), "LATIN SUBSCRIPT SMALL LETTER J matches Other_Lowercase";
ok unimatch("\x2DE0", "Other_Alphabetic"), "COMBINING CYRILLIC LETTER BE matches Other_Alphabetic";
ok unimatch("\x2E06", "Pattern_Syntax"), "RAISED INTERPOLATION MARKER matches Pattern_Syntax";
ok unimatch("\x2E0E", "Pattern_Syntax"), "EDITORIAL CORONIS matches Pattern_Syntax";
ok unimatch("\x2E1B", "Pattern_Syntax"), "TILDE WITH RING ABOVE matches Pattern_Syntax";
ok unimatch("\x2E21", "Pattern_Syntax"), "RIGHT VERTICAL BAR WITH QUILL matches Pattern_Syntax";
ok unimatch("\x2E2E", "STerm"), "REVERSED QUESTION MARK matches STerm";
ok unimatch("\x2FFB", "IDS_Binary_Operator"), "IDEOGRAPHIC DESCRIPTION CHARACTER OVERLAID matches IDS_Binary_Operator";
ok unimatch("\x300F", "Pattern_Syntax"), "RIGHT WHITE CORNER BRACKET matches Pattern_Syntax";
ok unimatch("\x301E", "Quotation_Mark"), "DOUBLE PRIME QUOTATION MARK matches Quotation_Mark";
ok unimatch("\xA60C", "Extender"), "VAI SYLLABLE LENGTHENER matches Extender";
ok unimatch("\xA60F", "Terminal_Punctuation"), "VAI QUESTION MARK matches Terminal_Punctuation";
ok unimatch("\xA980", "Other_Alphabetic"), "JAVANESE SIGN PANYANGGA matches Other_Alphabetic";
ok unimatch("\xAAC2", "Diacritic"), "TAI VIET TONE MAI SONG matches Diacritic";
ok unimatch("\xAADD", "Extender"), "TAI VIET SYMBOL SAM matches Extender";
ok unimatch("\xFA0F", "Unified_Ideograph"), "CJK COMPATIBILITY IDEOGRAPH-FA0F matches Unified_Ideograph";
ok unimatch("\xFA70", "Ideographic"), "CJK COMPATIBILITY IDEOGRAPH-FA70 matches Ideographic";
ok unimatch("\xFF46", "Hex_Digit"), "FULLWIDTH LATIN SMALL LETTER F matches Hex_Digit";
ok unimatch("\xFF70", "Diacritic"), "HALFWIDTH KATAKANA-HIRAGANA PROLONGED SOUND MARK matches Diacritic";
ok unimatch("\x10857", "Terminal_Punctuation"), "IMPERIAL ARAMAIC SECTION SIGN matches Terminal_Punctuation";
ok unimatch("\x10B3A", "Terminal_Punctuation"), "TINY TWO DOTS OVER ONE DOT PUNCTUATION matches Terminal_Punctuation";
ok unimatch("\x11047", "Terminal_Punctuation"), "BRAHMI DANDA matches Terminal_Punctuation";
ok unimatch("\x110B2", "Other_Alphabetic"), "KAITHI VOWEL SIGN II matches Other_Alphabetic";
ok unimatch("\x11102", "Other_Alphabetic"), "CHAKMA SIGN VISARGA matches Other_Alphabetic";
ok unimatch("\x11127", "Other_Alphabetic"), "CHAKMA VOWEL SIGN A matches Other_Alphabetic";
ok unimatch("\x11143", "STerm"), "CHAKMA QUESTION MARK matches STerm";
ok unimatch("\x16F93", "Diacritic"), "MIAO LETTER TONE-2 matches Diacritic";
ok unimatch("\x1D167", "Diacritic"), "MUSICAL SYMBOL COMBINING TREMOLO-1 matches Diacritic";
ok unimatch("\x1D6FC", "Other_Math"), "MATHEMATICAL ITALIC SMALL ALPHA matches Other_Math";
ok unimatch("\x1D76E", "Other_Math"), "MATHEMATICAL SANS-SERIF BOLD CAPITAL OMEGA matches Other_Math";
ok unimatch("\x1D7CE", "Other_Math"), "MATHEMATICAL BOLD DIGIT ZERO matches Other_Math";
ok unimatch("\x1EE5F", "Other_Math"), "ARABIC MATHEMATICAL TAILED DOTLESS QAF matches Other_Math";
ok unimatch("\x1EEAB", "Other_Math"), "ARABIC MATHEMATICAL DOUBLE-STRUCK LAM matches Other_Math";
ok unimatch(0x1000, 'Myanmar', 'sc'), 'Unimatch properly checks alternate/short canonical Unicode names';

# vim: expandtab shiftwidth=4
