use v6;

use Test;

plan 9;

# L<S02/One-pass parsing/>

# test parsing of < and >, especially distinction between operators
# and terms (when used as a quote as in <a b c>)
#
# nearly all of these tests had been regressions at one point,
# so don't discard them for being too simple ;-)

ok(rand >= 0, 'random numbers are greater than or equal to 0');
ok(rand < 1, 'random numbers are less than 1');

ok 3 > 0, "3 is greater than 0";


# used to be a pugs regression
#   ~< foo bar >
# doesn't parse (as does +< foo bar >).
is EVAL('~< foo bar >'), "foo bar", "~<...> is parsed correctly";
is EVAL('+< foo bar >'),         2, "+<...> is parsed correctly";
ok EVAL('?< foo bar >'),            "?<...> is parsed correctly";

is EVAL('~(< foo bar >)'), "foo bar", "~(<...>) is parsed correctly";
is EVAL('+(< foo bar >)'),         2, "+(<...>) is parsed correctly";
ok EVAL('?(< foo bar >)'),            "?(<...>) is parsed correctly";

# vim: ft=perl6
