use v6;
use Test;

# L<S32::Str/Str/"=item sameaccent">

plan 8;

is(sameaccent('ABb', 'ƗƗƗ'), 'ȺɃƀ', 'sameaccent as a function works');
is(sameaccent(:string('ABb'), 'ƗƗƗ'), 'ȺɃƀ', 'sameaccent works with named argument');

# should this be an exception or a Failure instead?
is(sameaccent('AF', 'ƗƗ'), 'ȺF', 'sameaccent without matching character silently fails');

is('ABb'.sameaccent('ƗƗƗ'), 'ȺɃƀ', 'sameaccent as a method works');

is('text'.sameaccent('asdf'), 'text', 'sameaccent without a change (no accents)');
is('ȺɃƀ'.sameaccent('ƗƗƗ'), 'ȺɃƀ', 'sameaccent without a change (accents already present');

is('text'.sameaccent('this is longer'), 'text', 'sameaccent with longer base string');
is('ABCD'.sameaccent('ƗƗ'), 'ȺɃCD', 'sameaccent with longer source string');

# vim: ft=perl6
