use v6;

use Test;

plan 47;

#use unicode :v(6.3);

# L<S15/uniprop>

### The types in the comment below are taken from the Unicode property name types, which may or may
### not correspond with types in Perl 6. The numbers in brackets show the number of each category
### we have tests for so far (Unicode 9.0). Hopefully eventually we include all of them.
## Only list roperties whose return value is tested specifically to be the correct value.
## Boolean values must be tested on at least two codepoints, for both True and False values.

## Numeric [1/4]
#  Numeric_Value
## String [4/12]
# Lowercase_Mapping, Uppercase_Mapping, Titlecase_Mapping
## Miscellaneous Properties [1/19]
# Unicode_1_Name, Name
## Binary [6/60]
#  ASCII_Hex_Digit, Hex_Digit, Dash, Case_Ignorable, Soft_Dotted, Quotation_Mark
## Catalog Properties [2/3]
# Script Age
## Enum [6/20]
#  Bidi_Paired_Bracket, Bidi_Paired_Bracket_Type, Bidi_Mirroring_Glyph, Bidi_Class
#  Word_Break, Line_Break


#?niecza 47 skip "uniprop NYI"
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
isa-ok 'a'.uniprop('Script'), Str, '.uniprop returns a Str for string Unicode properties';
is 'a'.uniprop('Script'), 'Latin', ".uniprop('Script') returns correct result for 'a'";
like 'a'.uniprop('Age'), /'1.1'/, "'a'.uniprop('Age') looks like /'1.1'/";
#?rakudo.moar todo 'Unicode 1 names NYI in MoarVM'
is '¶'.uniprop('Unicode_1_Name'), "PARAGRAPH SIGN", "¶.uniprop('Unicode_1_Name') returns Unicode 1 name";
#?rakudo.moar todo 'Coming soon'
is uniprop(0xFB00, 'Name'), "LATIN SMALL LIGATURE FF", "uniprop: returns proper name for LATIN SMALL LIGATURE FF";

is "\x[FB00]".lc, "\x[FB00]", ".lc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo 'Coming soon'
is uniprop(0xFB00, 'Lowercase_Mapping'), "\x[FB00]", "uniprop: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".tc, "\x[0046]\x[0066]", ".tc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo 'Coming soon'
is uniprop(0xFB00, 'Titlecase_Mapping'), "\x[0046]\x[0066]", "uniprop: returns proper titlecase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uc, "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo 'Coming soon'
is uniprop(0xFB00, 'Uppercase_Mapping'), "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uniname, "LATIN SMALL LIGATURE FF", "uniname: returns proper name for LATIN SMALL LIGATURE FF";

#?rakudo.moar todo 'moar returns a string containing the unicode codepoint instead of an integer for Bidi_Mirroring_Glyph'
# https://github.com/MoarVM/MoarVM/issues/451
is '('.uniprop('Bidi_Mirroring_Glyph'), ')', "'('.uniprop('Bidi_Mirroring_Glyph') returns ')'";
#?rakudo.moar 3 todo 'NYI'
is '('.uniprop('Bidi_Paired_Bracket'), ')', "uniprop: returns matching Bidi_Paired_Bracket";
is '('.uniprop('Bidi_Paired_Bracket_Type'), 'o', "'('.uniprop('Bidi_Paired_Bracket_Type') returns 'o'";
is ')'.uniprop('Bidi_Paired_Bracket_Type'), 'c', "')'.uniprop('Bidi_Paired_Bracket_Type') returns 'c'";

## Numeric Properties
#?rakudo.moar 3 todo 'Coming soon'
isa-ok "½".uniprop('Numeric_Value'), Rat, "'½'.uniprop('Numeric_Value') returns a Rat";
is "½".uniprop('Numeric_Value'), 0.5, "'½'.uniprop('Numeric_Value') returns the correct number";
is "a".uniprop('Numeric_Value'), NaN, "'a'.uniprop('Numeric_Value') returns NaN";

## Binary Properties
is-deeply '0'.uniprop('Alphabetic'), False, "'0'.uniprop('Alphabetic') returns a False";
is-deeply 'a'.uniprop('Alphabetic'), True, "uniprop('Alphabetic') returns a True for letter 'a'";

is-deeply "-".uniprop('Dash'), True, ".uniprop('Dash') returns True for the Dash property on dashes";
is-deeply "a".uniprop('Dash'), False, ".uniprop('Dash') returns False for non-dashes";

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

## Enum Properties
is 0x202A.uniprop('Bidi_Class'), 'LRE', "0x202A.uniprop('Bidi_Class') returns LRE";
is 0xFB1F.uniprop('Word_Break'), 'Hebrew_Letter', "0xFB1F.uniprop('Word_Break') returns Hebrew_Letter";
is "\n".uniprop('Line_Break'), 'LF', ‘"\n".uniprop('Line_Break') return LF’;

# vim: ft=perl6 expandtab sw=4
