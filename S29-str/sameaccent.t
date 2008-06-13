use v6;
use Test;

# L<S29/Str/"=item sameaccent">

plan 7;

is(sameaccent('ABb', 'ƗƗƗ'), 'ȺɃƀ', 'sameaccent as a function works');

# should this be an exception or a Failure instead?
is(sameaccent('AF', 'ƗƗ'), 'ȺF', 'sameaccent without matching character silently fails');

is('ABb'.sameaccent('ƗƗƗ'), 'ȺɃƀ', 'sameaccent as a method works');

is('text'.sameaccent('asdf'), 'text', 'sameaccent without a change (no accents)');
is('ȺɃƀ'.sameaccent('ƗƗƗ'), 'ȺɃƀ', 'sameaccent without a change (accents already present');

is('text'.sameaccent('this is longer'), 'text', 'sameaccent with longer base string');
is('ABCD'.sameaccent('ƗƗ'), 'ȺɃCD', 'sameaccent with longer source string');
