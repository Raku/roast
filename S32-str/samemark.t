use v6;
use Test;

# L<S32::Str/Str/"=item samemark">

plan 7;

#?rakudo 7 skip 'samemark NYI - RT #125165'
is(samemark('ABb', 'ƗƗƗ'), 'ȺɃƀ', 'samemark as a function works');

# should this be an exception or a Failure instead?
is(samemark('AF', 'ƗƗ'), 'ȺF', 'samemark without matching character silently fails');

is('ABb'.samemark('ƗƗƗ'), 'ȺɃƀ', 'samemark as a method works');

is('text'.samemark('asdf'), 'text', 'samemark without a change (no accents)');
is('ȺɃƀ'.samemark('ƗƗƗ'), 'ȺɃƀ', 'samemark without a change (accents already present');

is('text'.samemark('this is longer'), 'text', 'samemark with longer base string');
is('ABCD'.samemark('ƗƗ'), 'ȺɃCD', 'samemark with longer source string');

# vim: ft=perl6
