use v6;
use Test;

# L<S29/Str/"=item samebase">

plan 7;

is(samebase('ABb', 'ƗƗƗ'), 'ȺɃƀ', 'samebase as a function works');

# should this be an exception or a Failure instead?
is(samebase('AF', 'ƗƗ'), 'ȺF', 'samebase without matching character silently fails');

is('ABb'.samebase('ƗƗƗ'), 'ȺɃƀ', 'samebase as a method works');

is('text'.samebase('asdf'), 'text', 'samebase without a change (no accents)');
is('ȺɃƀ'.samebase('ƗƗƗ'), 'ȺɃƀ', 'samebase without a change (accents already present');

is('text'.samebase('this is longer'), 'text', 'samebase with longer base string');
is('ABCD'.samebase('ƗƗ'), 'ȺɃCD', 'samebase with longer source string');
