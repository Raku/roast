use v6;

use Test;

plan 9;

#use unicode :v(6.3);

# L<S15/uniprop>

#?niecza 9 skip "uniprop NYI"
is uniprop(""), Nil, "uniprop an empty string yields Nil";
is "".uniprop, Nil, "''.uniprop yields Nil";
throws-like "uniprop Str", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "Str.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "uniprop Int", X::Multi::NoMatch, 'cannot call uniprop with a Int';
throws-like "Int.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Int';

is "".uniprops, (), "''.uniprops yields an empty list";
is ("\x[1000]", "\x[100]")».uniprop('Script'), "\x[1000]\x[100]".uniprops('Script'),
    "uniprops returns properties of multiple characters in a string";
#?rakudo.moar todo "Unicode properties don't always return the correct shortnames"
#https://github.com/MoarVM/MoarVM/issues/448
is "a".uniprop('sc'), "a".uniprop('Script'), "Unicode authoratative short names return the same result as full names";

# vim: ft=perl6 expandtab sw=4
