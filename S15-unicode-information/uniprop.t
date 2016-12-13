use v6;

use Test;

plan 25;

#use unicode :v(6.3);

# L<S15/uniprop>
## Properties whole return value is tested to be the correct value:
## Script, Dash, Lowercase_Mapping, Uppercase_Mapping, Titlecase_Mapping, Name, Numeric_Value

#?niecza 25 skip "uniprop NYI"
is uniprop(""), Nil, "uniprop an empty string yields Nil";
is "".uniprop, Nil, "''.uniprop yields Nil";
throws-like "uniprop Str", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "Str.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "uniprop Int", X::Multi::NoMatch, 'cannot call uniprop with a Int';
throws-like "Int.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Int';

is "".uniprops, (), "''.uniprops yields an empty list";
is ("\x[1000]", "\x[100]")».uniprop('Script'), "\x[1000]\x[100]".uniprops('Script'),
    "uniprops returns properties of multiple characters in a string";
#https://github.com/MoarVM/MoarVM/issues/448
is "a".uniprop('sc'), "a".uniprop('Script'), "uniprop: Unicode authoratative short names return the same result as full names";

isa-ok 'a'.uniprop('Alphabetic'), Bool, "uniprop('Alphabetic') returns a Bool for Boolean Unicode properties";
is 'a'.uniprop('Alphabetic'), True, "uniprop('Alphabetic') returns a True for letter 'a'";

isa-ok 'a'.uniprop('Script'), Str, '.uniprop returns a Str for string Unicode properties';
is 'a'.uniprop('Script'), 'Latin', ".uniprop('Script') returns correct result for 'a'";

is "-".uniprop('Dash'), True, ".uniprop('Dash') returns True for the Dash property on dashes";
is "a".uniprop('Dash'), False, ".uniprop('Dash') returns False for non-dashes";
is "\x[FB00]".lc, "\x[FB00]", ".lc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo
is uniprop(0xFB00, 'Lowercase_Mapping'), "\x[FB00]", "uniprop: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".tc, "\x[0046]\x[0066]", ".tc: returns proper lowercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo
is uniprop(0xFB00, 'Titlecase_Mapping'), "\x[0046]\x[0066]", "uniprop: returns proper titlecase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uc, "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo
is uniprop(0xFB00, 'Uppercase_Mapping'), "\x[0046]\x[0046]", ".uc: returns proper uppercase mapping for LATIN SMALL LIGATURE FF";
is "\x[FB00]".uniname, "LATIN SMALL LIGATURE FF", "uniname: returns proper name for LATIN SMALL LIGATURE FF";
#?rakudo.moar todo
is uniprop(0xFB00, 'Name'), "LATIN SMALL LIGATURE FF", "uniprop: returns proper name for LATIN SMALL LIGATURE FF";
#?rakudo.moar 2 todo
isa-ok "½".uniprop('Numeric_Value'), Rat, "'½'.uniprop('Numeric_Value') returns a Rat";
is "½".uniprop('Numeric_Value'), 0.5, "'½'.uniprop('Numeric_Value') returns the correct number";

# vim: ft=perl6 expandtab sw=4
