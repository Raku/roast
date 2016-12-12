use v6;

use Test;

plan 17;

#use unicode :v(6.3);

# L<S15/uniprop>

#?niecza 17 skip "uniprop NYI"
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
is "a".uniprop('sc'), "a".uniprop('Script'), "Unicode authoratative short names return the same result as full names";

isa-ok uniprop('a', 'Alphabetic'), Bool, 'Uniprop returns a Bool for Boolean Unicode properties';
isa-ok uniprop('a', 'Script'), Str, 'Uniprop returns a Str for string Unicode properties';

is "\x[FB00]".lc, "\x[FB00]", ".lc: latin small ligature ff returns proper lowercase mapping";
#?rakudo.moar todo
is uniprop(0xFB00, 'Lowercase_Mapping'), "\x[FB00]", "uniprop: latin small ligature ff returns proper lowercase mapping";
is "\x[FB00]".tc, "\x[0046]\x[0066]", ".tc: latin small ligature ff returns proper lowercase mapping";
#?rakudo.moar todo
is uniprop(0xFB00, 'Titlecase_Mapping'), "\x[0046] \x[0066]", "uniprop: latin small ligature ff returns proper titlecase mapping";
is "\x[FB00]".uc, "\x[0046]\x[0046]", ".uc: latin small ligature ff returns proper uppercase mapping";
#?rakudo.moar todo
is uniprop(0xFB00, 'Uppercase_Mapping'), "\x[0046]\x[0046]", ".uc: latin small ligature ff returns proper uppercase mapping";

# vim: ft=perl6 expandtab sw=4
