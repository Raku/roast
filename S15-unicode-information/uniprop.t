use v6;

use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 201;

#use unicode :v(6.3);

# L<S15/uniprop>

### The types in the comment below are taken from the Unicode property name types, which may or may
### not correspond with types in Perl 6. The numbers in brackets show the number of each category
### we have tests for so far (Unicode 9.0). Hopefully eventually we include all of them.
## Only list properties whose return value is tested specifically to be the correct value.
## Boolean values must be tested on at least two codepoints, for both True and False values.
## Ideally, Enum type properties should be tested for codepoints listed inside their Unicode
## source file as well as also ones which are *not* listed in them (AKA default values).

## Numeric [2/4]
#  Numeric_Value, Numeric_Type

## String [7/12]
# Lowercase_Mapping, Uppercase_Mapping, Titlecase_Mapping, Case_Folding, Simple_Uppercase_Mapping,
# Simple_Titlecase_Mapping, Simple_Titlecase_Mapping

## Miscellaneous Properties [5/19]
# Unicode_1_Name, Name, Jamo_Short_Name, ISO_Comment, Bidi_Mirroring_Glyph
## Binary [38/60]
#  ASCII_Hex_Digit, Hex_Digit, Dash, Diacritic, Default_Ignorable_Code_Point, ID_Start
#  IDS_Binary_Operator, IDS_Trinary_Operator, Case_Ignorable, Soft_Dotted, Quotation_Mark,
#  Math, Grapheme_Extend, Hyphen, Extender, Grapheme_Base, Join_Control, Grapheme_Link
#  Deprecated, White_Space, Ideographic, Radical, Alphabetic, Bidi_Mirrored, Variation_Selector
#  ID_Continue, Sentence_Terminal, Changes_When_NFKC_Casefolded, Full_Composition_Exclusion
#  Cased, Changes_When_Casefolded, Changes_When_Casemapped, Changes_When_Lowercased
#  Changes_When_Uppercased, Changes_When_Titlecased, Uppercase, Terminal_Punctuation, Bidi_Control

## Catalog Properties [3/3]
# Script, Age, Block

## Enum [20/20]
#  Bidi_Class, Bidi_Paired_Bracket_Type, Bidi_Paired_Bracket, Canonical_Combining_Class,
#  Decomposition_Type, , East_Asian_Width, General_Category, Grapheme_Cluster_Break,
#  Hangul_Syllable_Type, Indic_Positional_Category, Indic_Syllabic_Category, Joining_Group
#  Joining_Type, Line_Break, NFC_Quick_Check, NFD_Quick_Check, NFKC_Quick_Check, NFKD_Quick_Check,
#  Sentence_Break, Word_Break

## Additional [4/?]
# Emoji, Emoji_Modifier, Emoji_All, Emoji_Presentation


is-deeply uniprop(""), Nil, "uniprop an empty string yields Nil";
is-deeply "".uniprop, Nil, "''.uniprop yields Nil";
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
#?rakudo.moar 2 todo 'Indic_Positional_Category NYI in MoarVM'
# https://github.com/MoarVM/MoarVM/issues/461
is 0x0BD7.uniprop('Indic_Positional_Category'), "Right", "uniprop for Indic_Positional_Category works";
is 'a'.uniprop('Indic_Positional_Category'), "NA", "uniprop for Indic_Positional_Category returns NA for codes that should default to this property";

is "\x[FB00]".lc, "\x[FB00]", ".lc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Lowercase_Mapping'), "\x[FB00]", "uniprop: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".tc, "\x[0046]\x[0066]", ".tc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Titlecase_Mapping'), "\x[0046]\x[0066]", "uniprop: returns proper titlecase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uc, "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
is uniprop(0xFB00, 'Uppercase_Mapping'), "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar 3 todo 'NYI'
is 'ß'.uniprop('Simple_Uppercase_Mapping'), 'ß', "uniprop for Simple_Uppercase_Mapping returns LATIN SMALL LETTER SHARP S for LATIN SMALL LETTER SHARP S";
is 'ß'.uniprop('Simple_Lowercase_Mapping'), 'ß', "uniprop for 'Simple_Lowercase_Mapping' returns LATIN SMALL LETTER SHARP S for LATIN SMALL LETTER SHARP S";
is 'ß'.uniprop('Simple_Titlecase_Mapping'), 'ß', "uniprop for 'Simple_Titlecase_Mapping' returns LATIN SMALL LETTER SHARP S for LATIN SMALL LETTER SHARP S";


is "\x[FB00]".uniname, "LATIN SMALL LIGATURE FF", "uniname: returns proper name for LATIN SMALL LIGATURE FF";
is "ﬆ".fc, "st", "'ﬆ'.fc returns ‘st’";
#?rakudo.moar todo "uniprop('Case_Folding') does not yet work"
is "ﬆ".uniprop('Case_Folding'), 'st', "'ﬆ'.uniprop for Case_Folding returns ‘st’";
#?rakudo.moar todo "Jamo_Short_Name NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/457
is "ᄁ".uniprop('Jamo_Short_Name'), 'GG', "uniprop for Jamo_Short_Name works";

# https://github.com/MoarVM/MoarVM/issues/451
is '('.uniprop('Bidi_Mirroring_Glyph'), ')', "'('.uniprop('Bidi_Mirroring_Glyph') returns ')'";
#?rakudo.moar 4 todo 'Bidi_Paired_Bracket_Type and Bidi_Paired_Bracket NYI in MoarVM'
# https://github.com/MoarVM/MoarVM/issues/465
is '('.uniprop('Bidi_Paired_Bracket'), ')', "uniprop: returns matching Bidi_Paired_Bracket";
is '('.uniprop('Bidi_Paired_Bracket_Type'), 'o', "'('.uniprop('Bidi_Paired_Bracket_Type') returns 'o'";
is ')'.uniprop('Bidi_Paired_Bracket_Type'), 'c', "')'.uniprop('Bidi_Paired_Bracket_Type') returns 'c'";
is 'a'.uniprop('Bidi_Paired_Bracket_Type'), 'n', "uniprop for Bidi_Paired_Bracket_Type returns 'n' for codes without this property";

## Numeric Properties
isa-ok "½".uniprop('Numeric_Value'), Rat, "'½'.uniprop('Numeric_Value') returns a Rat";
is "½".uniprop('Numeric_Value'), 0.5, "'½'.uniprop('Numeric_Value') returns the correct number";
is "a".uniprop('Numeric_Value'), NaN, "'a'.uniprop('Numeric_Value') returns NaN";
is '1'.uniprop('Numeric_Type'), 'Decimal', "uniprop for Numeric_Type returns 'Decimal' for decimal numbers";
is 'a'.uniprop('Numeric_Type'), 'None', "uniprop for Numeric_Type returns 'None' for non-numbers";
is  0x00B2.uniprop('Numeric_Type'), 'Digit', "uniprop for Numeric_Type returns 'Digit' for ones with this property";

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

is-deeply 0x2FF2.uniprop('IDS_Trinary_Operator'), True, "uniprop for IDS_Trinary_Operator returns True for codepoints with this property";
is-deeply '⇒'.uniprop('IDS_Trinary_Operator'), False, "uniprop for IDS_Trinary_Operator returns False for codepoints without this property";

is-deeply 0x2FF0.uniprop('IDS_Binary_Operator'), True, "uniprop for IDS_Binary_Operator returns True for codepoints with this property";
is-deeply 'ϣ'.uniprop('IDS_Binary_Operator'), False, "uniprop for IDS_Binary_Operator returns False for codepoints without this property";

is-deeply 'Ϳ'.uniprop('ID_Start'), True, "uniprop for ID_Start property returns True for codepoints with this property";
is-deeply ''̴'.uniprop('ID_Start'), False, "uniprop for ID_Start property returns False for codepoints without this property";

is-deeply '؜'.uniprop('Default_Ignorable_Code_Point'), True, "uniprop for Default_Ignorable_Code_Point returns True for codepoints with this property";
is-deeply 'ē'.uniprop('Default_Ignorable_Code_Point'), False, "uniprop for Default_Ignorable_Code_Point returns False for codepoints without this property";

is-deeply '^'.uniprop('Diacritic'), True, "uniprop for Diacritic property returns True for codepoints with this property";
is-deeply 'Ê'.uniprop('Diacritic'), False, "uniprop for Diacritic property returns False for codepoints without this property";

is-deeply 0x200D.uniprop('Join_Control'), True, "uniprop for Join_Control property returns True for U+200D";
is-deeply 0x200C.uniprop('Join_Control'), True, "uniprop for Join_Control property returns True for U+200C";
is-deeply 'a'.uniprop('Join_Control'), False, "uniprop for Join_Control property returns False for codes without this property";

is-deeply 'ŉ'.uniprop('Deprecated'), True, "uniprop for Depreciated property returns True for codes with this property";
is-deeply 'a'.uniprop('Deprecated'), False, "uniprop for Depreciated property returns False for codes without this property";

is-deeply ' '.uniprop('White_Space'), True, "uniprop for White_Space property returns True for codes with this property";
is-deeply 'a'.uniprop('White_Space'), False, "uniprop for White_Space property returns False for codes without this property";
is-deeply '1'.uniprop('White_Space'), False, "uniprop for White_Space property returns False for '1'";
is-deeply '1'.uniprop('space'), False, "uniprop for space property returns False for '1'";

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

is-deeply '🄡'.uniprop('Changes_When_NFKC_Casefolded'), True, "uniprop for Changes_When_NFKC_Casefolded property returns True for codes with this property";
is-deeply 'a'.uniprop('Changes_When_NFKC_Casefolded'), False, "uniprop for Sentence_Terminal property returns False for codes without this property";

is-deeply 'a'.uniprop('Cased'), True, "uniprop for Cased property returns True for codes with this property";
is-deeply '0'.uniprop('Cased'), False, "uniprop for Cased property returns False for codes without this property";

# The following two tests cannot be tested as strings/chars because of Unicode normalization.
# Encoding it as a string will change the codepoint, so do not try this! It will give the incorrect
# answer!
is-deeply  0x0343.uniprop('Full_Composition_Exclusion'), True, "uniprop for Full_Composition_Exclusion property returns True for codes with this property";
is-deeply 'a'.uniprop('Full_Composition_Exclusion'), False, "uniprop for Full_Composition_Exclusion property returns False for codes without this property";

is-deeply 'A'.uniprop('Changes_When_Casefolded'), True, "uniprop for Changes_When_Casefolded property returns True for codes with this property";
is-deeply 'a'.uniprop('Changes_When_Casefolded'), False, "uniprop for Changes_When_Casefolded property returns False for codes without this property";

is-deeply 'A'.uniprop('Changes_When_Lowercased'), True, "uniprop for Changes_When_Lowercased property returns True for codes with this property";
is-deeply 'a'.uniprop('Changes_When_Lowercased'), False, "uniprop for Changes_When_Lowercased property returns False for codes without this property";

is-deeply 'A'.uniprop('Changes_When_Uppercased'), False, "uniprop for Changes_When_Uppercased property returns False for codes with this property";
is-deeply 'a'.uniprop('Changes_When_Uppercased'), True, "uniprop for Changes_When_Uppercased property returns True for codes without this property";

is-deeply 'A'.uniprop('Changes_When_Titlecased'), False, "uniprop for Changes_When_Titlecased property returns False for codes with this property";
is-deeply 'a'.uniprop('Changes_When_Titlecased'), True, "uniprop for Changes_When_Titlecased property returns True for codes without this property";

is-deeply 'ⓐ'.uniprop('Changes_When_Casemapped'), True, "uniprop for Changes_When_Casemapped property returns True for codes with this property";
is-deeply '☕'.uniprop('Changes_When_Casemapped'), False, "uniprop for Changes_When_Casemapped property returns False for codes without this property";

is-deeply 'A'.uniprop('Uppercase'), True, "uniprop for 'Upper' property returns False for codes with this property";
is-deeply 'a'.uniprop('Uppercase'), False, "uniprop for 'Upper' property returns True for codes without this property";

is-deeply 'A'.uniprop('Lowercase'), False, "uniprop for 'Lowercase' property returns False for codes with this property";
is-deeply 'a'.uniprop('Lowercase'), True, "uniprop for 'Lowercase' property returns True for codes without this property";

is-deeply 'A'.uniprop('Terminal_Punctuation'), False, "uniprop for Terminal_Punctuation property returns False for codes with this property";
is-deeply '⁇'.uniprop('Terminal_Punctuation'), True, "uniprop for Terminal_Punctuation property returns True for codes without this property";

is-deeply 'A'.uniprop('Bidi_Control'), False, "uniprop for 'Bidi_Control' property returns False for codes with this property";
is-deeply 0x202D.uniprop('Bidi_Control'), True, "uniprop for 'Bidi_Control' property returns True for codes without this property";

## Enum Properties
is 0x202A.uniprop('Bidi_Class'), 'LRE', "0x202A.uniprop('Bidi_Class') returns LRE";
is 0xFB1F.uniprop('Word_Break'), 'Hebrew_Letter', "0xFB1F.uniprop('Word_Break') returns Hebrew_Letter";
is "\n".uniprop('Line_Break'), 'LF', ‘"\n".uniprop('Line_Break') return LF’;
is 0x200D.uniprop('Line_Break'), 'ZWJ', ‘uniprop('Line_Break') returns ZWJ for U+200D ZERO WIDTH JOINER’;
is 0x103D.uniprop('Line_Break'), 'SA', ‘uniprop('Line_Break') returns SA for U+103D MYANMAR CONSONANT SIGN MEDIAL WA’;
is 0xFFFF.uniprop('Line_Break'), 'XX', "uniprop('Line_Break') returns XX for noncharacters";

is 'Ö'.uniprop('Decomposition_Type'), 'Canonical', 'uniprop for Decomposition_Type returns Canonical for Canonical value codes';
#?rakudo.moar 3 todo "MoarVM returns N/M/Y instead of their full names"
is 'ᆨ'.uniprop('NFC_Quick_Check'), 'Maybe', 'uniprop for NFC_Quick_Check returns Maybe for ‘Maybe’ value codes';
is '都'.uniprop('NFC_Quick_Check'), 'Yes', 'uniprop for NFC_Quick_Check returns Yes for ‘Yes’ value codes';
is 0x0374.uniprop('NFC_Quick_Check'), 'No', 'uniprop for NFC_Quick_Check returns No for ‘No’ value codes';
#?rakudo.moar 6 todo "NFD_Quick_Check NFKC_Quick_Check NFKD_Quick_Check NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/467
is 0x3094.uniprop('NFD_Quick_Check'), 'No', 'uniprop for NFD_Quick_Check returns False for codes without this property';
is 'a'.uniprop('NFD_Quick_Check'), 'Yes', 'uniprop for NFD_Quick_Check returns True for codes with this property';

is 0x0340.uniprop('NFKC_Quick_Check'), 'No', 'uniprop for NFKC_Quick_Check returns False for codes without this property';
is 'a'.uniprop('NFKC_Quick_Check'), 'Yes', 'uniprop for NFKC_Quick_Check returns True for codes with this property';

is 0x00C0.uniprop('NFKD_Quick_Check'), 'No', 'uniprop for NFKD_Quick_Check returns False for codes without this property';
is 'a'.uniprop('NFKD_Quick_Check'), 'Yes', 'uniprop for NFKD_Quick_Check returns True for codes with this property';

#?rakudo.moar 2 todo "Indic_Syllabic_Category NYI in MoarVM"
# https://github.com/MoarVM/MoarVM/issues/466
is 0x11052.uniprop('Indic_Syllabic_Category'), 'Brahmi_Joining_Number', 'uniprop for Indic_Syllabic_Category returns N for ‘No’ value codes';
is 'a'.uniprop('Indic_Syllabic_Category'), 'Other', 'uniprop for Indic_Syllabic_Category returns Other for codes without this property';

#?rakudo.moar todo "MoarVM returns only int's but not Canonical_Combining_Class's string value"
# https://github.com/MoarVM/MoarVM/issues/464
is ' '.uniprop('Canonical_Combining_Class'), 'Not_Reordered', "uniprop for Canonical_Combining_Class works";

is "↉".uniprop('East_Asian_Width'), any('A', 'Ambiguous'), "uniprop for ↉ returns A or Ambiguous for East_Asian_Width";
is "]".uniprop('East_Asian_Width'), any('Na','Narrow'), "uniprop for ] returns Na or Narrow for East_Asian_Width";
#?rakudo.moar 2 todo "East_Asian_Width Unicode property uses short property values not full values"
# https://github.com/MoarVM/MoarVM/issues/454
is "↉".uniprop('East_Asian_Width'), 'Ambiguous', "uniprop for ↉ returns Ambiguous for East_Asian_Width";
is "]".uniprop('East_Asian_Width'), 'Narrow', "uniprop for ] returns Narrow for East_Asian_Width";
is '읔'.uniprop('Hangul_Syllable_Type'), 'LVT', "uniprop for Hangul_Syllable_Type works";
is "a".uniprop('Grapheme_Cluster_Break'), 'Other', "uniprop for Grapheme_Cluster_Break returns Other for normal codepoints";
is "\n".uniprop('Grapheme_Cluster_Break'), 'LF', "uniprop for Grapheme_Cluster_Break returns LF for newline codepoint";
is 'ܘ'.uniprop('Joining_Group'), "SYRIAC WAW", "uniprop for Joining_Group works";
is 'ڵ'.uniprop('Joining_Type'), "D", "uniprop for Joining_Type works";
is '.'.uniprop('Sentence_Break'), 'ATerm', "uniprop for Sentence_Break works";

## Additional Properties
is 'a'.uniprop('ISO_Comment'), '', "uniprop for ISO_Comment returns an empty string. Must be empty since Unicode 5.2.0";

is-deeply "A".uniprop('Emoji'), False, "uniprop for Emoji returns False for non-emoji's";
is-deeply "🐧".uniprop('Emoji_Modifier'), False, "uniprop for Emoji_Modifier returns False for non modifier Emoji's";
is-deeply 0x2B05.uniprop('Emoji_Presentation'), False, "uniprop for Emoji_Presentation returns False for Emoji's without this property";
is-deeply 'a'.uniprop('Emoji_Presentation'), False, "uniprop for Emoji_Presentation returns False for non-Emoji's";

# https://github.com/MoarVM/MoarVM/issues/453
is-deeply "🐧".uniprop('Emoji'), True, "uniprop for Emoji returns True for emoji's";
is-deeply "#".uniprop('Emoji'), True, "uniprop for Emoji returns true for #";
is-deeply 0x1F3FB.uniprop('Emoji_Modifier'), True, "uniprop for Emoji_Modifier returns True for Emoji Modifiers";
is-deeply "😂".uniprop('Emoji_Presentation'), True, "uniprop for Emoji_Presentation returns True for visible Emoji codes";

#?rakudo.moar 3 todo "Emoji properties NYI in MoarVM"
is-deeply 0x1F3FD.uniprop('Emoji_All'), True, "uniprop for Emoji_All returns True for Emoji Modifiers";
is-deeply "🐧".uniprop('Emoji_All'), True, "uniprop for Emoji_All returns True for non-modifier Emoji";
is-deeply "a".uniprop('Emoji_All'), False, "uniprop for Emoji_All returns False for non-Emoji";

# MoarVM Issue 566
lives-ok( { 0x99999999.uniprop }, 'Lives when requesting a very high codepoint.');

is-deeply 0xFFFF.uniprop, "Cn", 'General Category for noncharacters return Cn';
is-deeply 0xFFFE.uniprop, "Cn", 'General Category for noncharacters return Cn';

is-deeply 'A'.uniprop, "Lu", "ASCII uppercase return Lu";
is-deeply 'a'.uniprop, "Ll", "ASCII lowercase returns Ll";
is-deeply 'ǅ'.uniprop, "Lt",  "General Category 'Lt'";
is-deeply 0x02B0.uniprop, "Lm", "General Category 'Lm'";
is-deeply 0x05D0.uniprop, "Lo", "General Category 'Lo'";
is-deeply 0x0610.uniprop, "Mn", "General Category 'Mn'";
is-deeply 0x1ABE.uniprop, "Me", "General Category 'Me'";
is-deeply 0x1B04.uniprop, "Mc", "General Category 'Mc'";
is-deeply 0x1B50.uniprop, "Nd", "General Category 'Nd'";
is-deeply 0x2160.uniprop, "Nl", "General Category 'Nl'";
is-deeply 0x2189.uniprop, "No", "General Category 'No'";
is-deeply 0x3000.uniprop, "Zs", "General Category 'Zs'";
is-deeply 0x2028.uniprop, "Zl", "General Category 'Zl'";
is-deeply 0x2029.uniprop, "Zp", "General Category 'Zp'";
is-deeply 0x0000.uniprop, "Cc", "General Category 'Cc'";
is-deeply 0x00AD.uniprop, "Cf", "General Category 'Cf'";
is-deeply 0xE000.uniprop, "Co", "General Category 'Co'";
is-deeply 0xD800.uniprop, "Cs", "General Category 'Cs'";
is-deeply 0xFE31.uniprop, "Pd", "General Category 'Pd'";
is-deeply 0xFE35.uniprop, "Ps", "General Category 'Ps'";
is-deeply 0xFE36.uniprop, "Pe", "General Category 'Pe'";
is-deeply 0xFE4D.uniprop, "Pc", "General Category 'Pc'";
is-deeply 0xFE45.uniprop, "Po", "General Category 'Po'";
is-deeply 0xFF0B.uniprop, "Sm", "General Category 'Sm'";
is-deeply 0xFFE0.uniprop, "Sc", "General Category 'Sc'";
is-deeply 0xFFE3.uniprop, "Sk", "General Category 'Sk'";
is-deeply 0xFFE4.uniprop, "So", "General Category 'So'";
is-deeply 0x00AB.uniprop, "Pi", "General Category 'Pi'";
is-deeply 0x00B6.uniprop, "Po", "General Category 'Po'";

# GH#1247
subtest 'reserved characters in source code do not cause segfaults', {
    my $antiflap = 5; # 5 – ≈35% fail rate if broken
    plan $antiflap;
    for ^$antiflap {
        is_run('#򫳞', { status => 0 }, 'no segfault');
    }
}

# vim: ft=perl6 expandtab sw=4
