use v6;

use Test;
plan *;

#?rakudo todo "Z temporarily disabled"
ok eval('<a b> Z <c d>'), 'cross non-meta operator parses';

#?rakudo skip "Z temporarily disabled"
ok <a b> Z <1 2>, <a 1 b 2>, 'non-meta zip produces expected result';

is (1, 2, 3 Z** 2, 4), (1, 16), 'Z** works';

ok eval('<a b> Z, <c d>'), 'zip metaoperator parses';

is (<a b> Z~ <1 2>), <a1 b2>, 'zip-concat produces expected result';

is (1,2 Z* 3,4), (3,8), 'zip-product works';

is (1,2 Zcmp 3,2,0), (-1, 0), 'Xcmp works';

# tests for laziness
is (1..* Z** 1..*).batch(5), (1**1, 2**2, 3**3, 4**4, 5**5), 'zip-power with lazy lists';
is (1..* Z+ 3, 2 ... *).batch(5), (1+3, 2+2, 3+1, 4+0, 5-1), 'zip-plus with lazy lists';

done_testing;

# vim: ft=perl6
