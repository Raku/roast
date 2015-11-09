use v6;

use Test;

plan 6;

#use unicode :v(6.3);

# L<S15/uniprop>

#?niecza 6 skip "uniprop NYI"
is uniprop(""), Str, "uniprop an empty string yields a Str type object";
is "".uniprop, Str, "''.uniprop yields a Str type object";
throws-like "uniprop Str", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "Str.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Str';
throws-like "uniprop Int", X::Multi::NoMatch, 'cannot call uniprop with a Int';
throws-like "Int.uniprop", X::Multi::NoMatch, 'cannot call uniprop with a Int';

# vim: ft=perl6 expandtab sw=4
