use v6;

use Test;

plan 109;

#use unicode :v(6.3);

# L<S15/uniprop>

### The types in the comment below are taken from the Unicode property name types, which may or may
### not correspond with types in Perl 6. The numbers in brackets show the number of each category
### we have tests for so far (Unicode 9.0). Hopefully eventually we include all of them.
## Only list properties whose return value is tested specifically to be the correct value.
## Boolean values must be tested on at least two codepoints, for both True and False values.

## Numeric [2/4]
#  Numeric_Value, Numeric_Type
## String [5/12]
# Lowercase_Mapping, Uppercase_Mapping, Titlecase_Mapping, Case_Folding
## Miscellaneous Properties [4/19]
# Unicode_1_Name, Name, Jamo_Short_Name, ISO_Comment
## Binary [22/60]
#  ASCII_Hex_Digit, Hex_Digit, Dash, Case_Ignorable, Soft_Dotted, Quotation_Mark, Math
#  Grapheme_Extend, Hyphen, Extender, Grapheme_Base, Join_Control, Grapheme_Link
#  Deprecated, White_Space, Ideographic, Radical, Alphabetic, Bidi_Mirrored, Variation_Selector
#  ID_Continue, Sentence_Terminal
## Catalog Properties [3/3]
# Script, Age, Block
## Enum [14/20]
#  Bidi_Paired_Bracket, Bidi_Paired_Bracket_Type, Bidi_Mirroring_Glyph, Bidi_Class East_Asian_Width
#  Word_Break, Line_Break, Hangul_Syllable_Type, Indic_Positional_Category, Grapheme_Cluster_Break
#  General_Category, Joining_Group, Joining_Type, Sentence_Break
## Additional [4/?]
# Emoji, Emoji_Modifier, Emoji_All, Emoji_Presentation


#?niecza 109 skip "uniprop NYI"
is uniprop(""), Nil, "uniprop an empty string yields Nil";
is "".uniprop, Nil, "''.uniprop yields Nil";
throws-like "uniprop Str", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "Str.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "uniprop Int", X::Multi::NoMatch, 'cannot call uniprop with a Int';
throws-like "Int.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Int';

is "".uniprops, (), "''.uniprops yields an empty list";
is ("\x[1000]", "\x[100]")».uniprop('Script'), "\x[1000]\x[100]".uniprops('Script'),
    "uniprops returns properties of multiple characters in a string";
# https://github.com/MoarVM/MoarVM/issues/448
is "a".uniprop('sc'), "a".uniprop('Script'), "uniprop: Unicode authoratative short names return the same result as full names";

## String/Catalog/Misc Properties
is 'a'.uniprop('General_Category'), 'Ll', ".uniprop('General_Category') returns the correct result";
is 'a'.uniprop, 'Ll', ".uniprop with no arguments returns the General_Category";

isa-ok 'a'.uniprop('Script'), Str, '.uniprop returns a Str for string Unicode properties';
is 'a'.uniprop('Script'), 'Latin', ".uniprop('Script') returns correct result for 'a'";
like 'a'.uniprop('Age'), /'1.1'/, "'a'.uniprop('Age') looks like /'1.1'/";
is 'a'.uniprop('Block'), 'Basic Latin', "uniprop for Block works";
#?rakudo.moar todo 'Unicode 1 names NYI in MoarVM'
is '¶'.uniprop('Unicode_1_Name'), "PARAGRAPH SIGN", "¶.uniprop('Unicode_1_Name') returns Unicode 1 name";
is uniprop(0xFB00, 'Name'), "LATIN SMALL LIGATURE FF", "uniprop: returns proper name for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo 'Indic_Positional_Category NYI in MoarVM'
# https://github.com/MoarVM/MoarVM/issues/461
is 0x0BD7.uniprop('Indic_Positional_Category'), "Right", "uniprop for Indic_Positional_Category works";

is "\x[FB00]".lc, "\x[FB00]", ".lc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Lowercase_Mapping'), "\x[FB00]", "uniprop: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".tc, "\x[0046]\x[0066]", ".tc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Titlecase_Mapping'), "\x[0046]\x[0066]", "uniprop: returns proper titlecase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uc, "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Uppercase_Mapping'), "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uniname, "LATIN SMALL LIGATURE FF", "uniname: returns proper name for LATIN SMALL LIGATURE FF";
is "ﬆ".fc, "st", "'ﬆ'.fc returns ‘st’";
#?rakudo.moar todo "uniprop('Case_Folding') does not yet work"
is "ﬆ".uniprop('Case_Folding'), 'st', "'ﬆ'.uniprop for Case_Folding returns ‘st’";
#?rakudo.moar todo "Jamo_Short_Name NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/457
is "ᄁ".uniprop('Jamo_Short_Name'), 'GG', "uniprop for Jamo_Short_Name works";

#?rakudo.moar todo 'moar returns a string containing the unicode codepoint instead of an integer for Bidi_Mirroring_Glyph'
# https://github.com/MoarVM/MoarVM/issues/451
is '('.uniprop('Bidi_Mirroring_Glyph'), ')', "'('.uniprop('Bidi_Mirroring_Glyph') returns ')'";
#?rakudo.moar 3 todo 'NYI'
is '('.uniprop('Bidi_Paired_Bracket'), ')', "uniprop: returns matching Bidi_Paired_Bracket";
is '('.uniprop('Bidi_Paired_Bracket_Type'), 'o', "'('.uniprop('Bidi_Paired_Bracket_Type') returns 'o'";
is ')'.uniprop('Bidi_Paired_Bracket_Type'), 'c', "')'.uniprop('Bidi_Paired_Bracket_Type') returns 'c'";

## Numeric Properties
isa-ok "½".uniprop('Numeric_Value'), Rat, "'½'.uniprop('Numeric_Value') returns a Rat";
is "½".uniprop('Numeric_Value'), 0.5, "'½'.uniprop('Numeric_Value') returns the correct number";
is "a".uniprop('Numeric_Value'), NaN, "'a'.uniprop('Numeric_Value') returns NaN";
is '1'.uniprop('Numeric_Type'), 'Decimal', "uniprop for Numeric_Type returns 'Decimal' for decimal numbers";
is 'a'.uniprop('Numeric_Type'), 'None', "uniprop for Numeric_Type returns 'None' for non-numbers";

## Binary Properties
is-deeply '0'.uniprop('Alphabetic'), False, "'0'.uniprop('Alphabetic') returns a False";
is-deeply 'a'.uniprop('Alphabetic'), True, "uniprop('Alphabetic') returns a True for letter 'a'";

is-deeply "-".uniprop('Dash'), True, ".uniprop('Dash') returns True for the Dash property on dashes";
is-deeply "a".uniprop('Dash'), False, ".uniprop('Dash') returns False for non-dashes";
is-deeply 0x30FB.uniprop('Dash'), False, ".uniprop('Dash') returns False for hyphens which are not dash's";

is-deeply 0x30FB.uniprop('Hyphen'), True, ".uniprop('Hyphen') returns True for hyphens which are not dash's";
is-deeply '—'.uniprop('Hyphen'), False, ".uniprop('Hyphen') returns False for em-dash";

is-deeply "٢".uniprop('ASCII_Hex_Digit'), False, ".uniprop('ASCII_Hex_Digit') returns False for ARABIC-INDIC DIGIT TWO";
is-deeply "a".uniprop('ASCII_Hex_Digit'), True, ".uniprop('ASCII_Hex_Digit') returns True for 'a'";
is-deeply "0".uniprop('ASCII_Hex_Digit'), True, ".uniprop('ASCII_Hex_Digit') returns True for '0'";

is-deeply "٢".uniprop('Hex_Digit'), False, ".uniprop('Hex_Digit') returns True for ARABIC-INDIC DIGIT TWO";
is-deeply "Z".uniprop('Hex_Digit'), False, ".uniprop('Hex_Digit') returns False for 'Z'";

is-deeply "\x[300]".uniprop('Case_Ignorable'), True, ".uniprop('Case_Ignorable') is True for COMBINING GRAVE ACCENT [Mn]";
is-deeply 183.uniprop('Case_Ignorable'), True, ".uniprop('Case_Ignorable') is True for MIDDLE DOT";
is-deeply "a".uniprop('Case_Ignorable'), False, ‘"a".uniprop('Case_Ignorable') is False’;

is-deeply 'i'.uniprop('Soft_Dotted'), True, ".uniprop('Soft_Dotted') for 'i' is True";
is-deeply 'o'.uniprop('Soft_Dotted'), False, ".uniprop('Soft_Dotted') for 'o' is False";

is-deeply '“'.uniprop('Quotation_Mark'), True, ".uniprop('Quotation_Mark') returns True for LEFT DOUBLE QUOTATION MARK";
is-deeply 'a'.uniprop('Quotation_Mark'), False, ".uniprop('Quotation_Mark') returns False for 'a'";

is-deeply '+'.uniprop('Math'), True, ".uniprop('Math') returns True for Math properties";
is-deeply 'a'.uniprop('Math'), False, ".uniprop('Math') returns False for non-Math properties";

is-deeply 0x1D16E.uniprop('Grapheme_Extend'), True, "uniprop for Grapheme_Extend returns True for codes with this property";
is-deeply 'a'.uniprop('Grapheme_Extend'), False, "uniprop for Grapheme_Extend returns False for codes without this property";

is-deeply '۞'.uniprop('Grapheme_Base'), True, "uniprop for Grapheme_Base returns True for codes with this property";
is-deeply 0x2028.uniprop('Grapheme_Base'), False, "uniprop for Grapheme_Base returns False for codes without this property";

is-deeply 0xABED.uniprop('Grapheme_Link'), True, "uniprop for Grapheme_Link returns True for codes with this property";
is-deeply 'ᖤ'.uniprop('Grapheme_Link'), False, "uniprop for Grapheme_Link returns False for codes without this property";

is-deeply 'ๆ'.uniprop('Extender'), True, "uniprop for Extender property returns True for codepoints with this property";
is-deeply 'a'.uniprop('Extender'), False, "uniprop for Extender property returns False for codepoints without this property";

is-deeply 0x200D.uniprop('Join_Control'), True, "uniprop for Join_Control property returns True for U+200D";
is-deeply 0x200C.uniprop('Join_Control'), True, "uniprop for Join_Control property returns True for U+200C";
is-deeply 'a'.uniprop('Join_Control'), False, "uniprop for Join_Control property returns False for codes without this property";

is-deeply 'ŉ'.uniprop('Deprecated'), True, "uniprop for Depreciated property returns True for codes with this property";
is-deeply 'a'.uniprop('Deprecated'), False, "uniprop for Depreciated property returns False for codes without this property";

is-deeply ' '.uniprop('White_Space'), True, "uniprop for White_Space property returns True for codes with this property";
is-deeply 'a'.uniprop('White_Space'), False, "uniprop for White_Space property returns False for codes without this property";

is-deeply '〆'.uniprop('Ideographic'), True, "uniprop for Ideographic property returns True for codes with this property";
is-deeply 'a'.uniprop('Ideographic'), False, "uniprop for Ideographic property returns False for codes without this property";

is-deeply '⼒'.uniprop('Radical'), True, "uniprop for Ideographic property returns True for codes with this property";
is-deeply 'a'.uniprop('Radical'), False, "uniprop for Ideographic property returns False for codes without this property";

is-deeply '('.uniprop('Bidi_Mirrored'), True, "uniprop for Bidi_Mirrored property returns True for codes with this property";
is-deeply 'a'.uniprop('Bidi_Mirrored'), False, "uniprop for Bidi_Mirrored property returns False for codes without this property";

is-deeply 0x180B.uniprop('Variation_Selector'), True, "uniprop for Variation_Selector property returns True for codes with this property";
is-deeply 'a'.uniprop('Variation_Selector'), False, "uniprop for Variation_Selector property returns False for codes without this property";

is-deeply 0xD7A3.uniprop('ID_Continue'), True, "uniprop for ID_Continue property returns True for codes with this property";
is-deeply 0xD7A4.uniprop('ID_Continue'), False, "uniprop for ID_Continue property returns False for codes without this property";

is-deeply '!'.uniprop('Sentence_Terminal'), True, "uniprop for Sentence_Terminal property returns True for codes with this property";
is-deeply 'a'.uniprop('Sentence_Terminal'), False, "uniprop for Sentence_Terminal property returns False for codes without this property";

## Enum Properties
is 0x202A.uniprop('Bidi_Class'), 'LRE', "0x202A.uniprop('Bidi_Class') returns LRE";
is 0xFB1F.uniprop('Word_Break'), 'Hebrew_Letter', "0xFB1F.uniprop('Word_Break') returns Hebrew_Letter";
is "\n".uniprop('Line_Break'), 'LF', ‘"\n".uniprop('Line_Break') return LF’;
#?rakudo.moar 2 todo "MoarVM does not return correct values for all Line_Break properties"
is 0x200D.uniprop('Line_Break'), 'ZWJ', ‘uniprop('Line_Break') returns ZWJ for U+200D ZERO WIDTH JOINER’;
is 0x103D.uniprop('Line_Break'), 'SA', ‘uniprop('Line_Break') returns SA for U+103D MYANMAR CONSONANT SIGN MEDIAL WA’;

#?rakudo.moar 2 todo "East_Asian_Width NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/454
is "↉".uniprop('East_Asian_Width'), 'A', "uniprop for ↉ returns A for East_Asian_Width";
is "]".uniprop('East_Asian_Width'), 'Na', "uniprop for ] returns Na for East_Asian_Width";
is '읔'.uniprop('Hangul_Syllable_Type'), 'LVT', "uniprop for Hangul_Syllable_Type works";
is "a".uniprop('Grapheme_Cluster_Break'), 'Other', "uniprop for Grapheme_Cluster_Break returns Other for normal codepoints";
is "\n".uniprop('Grapheme_Cluster_Break'), 'LF', "uniprop for Grapheme_Cluster_Break returns LF for newline codepoint";
is 'ܘ'.uniprop('Joining_Group'), "SYRIAC WAW", "uniprop for Joining_Group works";
is 'ڵ'.uniprop('Joining_Type'), "D", "uniprop for Joining_Type works";
is '.'.uniprop('Sentence_Break'), 'ATerm', "uniprop for Sentence_Break works";

## Additional Properties
#?rakudo.moar todo "ISO_Comment currently returns a 0 not an empty string"
is 'a'.uniprop('ISO_Comment'), '', "uniprop for ISO_Comment returns an empty string. Must be empty since Unicode 5.2.0";

#?rakudo.moar 10 todo "Emoji properties NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/453
is-deeply "🐧".uniprop('Emoji'), True, "uniprop for Emoji returns True for emoji's";
is-deeply "A".uniprop('Emoji'), True, "uniprop for Emoji returns False for non-emoji's";
is-deeply "#".uniprop('Emoji'), True, "uniprop for Emoji returns true for #";
is-deeply 0x1F3FD.uniprop('Emoji_Modifier'), True, "uniprop for Emoji_Modifiers returns True for Emoji Modifiers";
is-deeply "🐧".uniprop('Emoji_Modifier'), False, "uniprop for Emoji_Modifier returns False for non modifier Emoji's";
is-deeply "😂".uniprop('Emoji_Presentation'), True, "uniprop for Emoji_Presentation returns True for visible Emoji codes";
is-deeply 0x1F3FD.uniprop('Emoji_Presentation'), False, "uniprop for Emoji_Presentation returns False for non-visible Emoji codes";

is-deeply 0x1F3FD.uniprop('Emoji_All'), True, "uniprop for Emoji_All returns True for Emoji Modifiers";
is-deeply "🐧".uniprop('Emoji_All'), True, "uniprop for Emoji_All returns True for non-modifier Emoji";
is-deeply "a".uniprop('Emoji_All'), False, "uniprop for Emoji_All returns False for non-Emoji";

# vim: ft=perl6 expandtab sw=4
