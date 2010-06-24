use v6;

use Test;
plan *;

ok eval('<a b> Z <c d>'), 'cross non-meta operator parses';

ok <a b> Z <1 2>, <a 1 b 2>, 'non-meta zip produces expected result';

is (1, 2, 3 Z** 2, 4), (1, 16), 'zip-power works';

ok eval('<a b> Z, <c d>'), 'zip metaoperator parses';

is (<a b> Z~ <1 2>), <a1 b2>, 'zip-concat produces expected result';

is (1,2 Z* 3,4), (3,8), 'zip-product works';

is (1,2 Zcmp 3,2,0), (-1, 0), 'zip-cmp works';

# tests for laziness
is (1..* Z** 1..*).[^5], (1**1, 2**2, 3**3, 4**4, 5**5), 'zip-power with lazy lists';
is (1..* Z+ (3, 2 ... *)).[^5], (1+3, 2+2, 3+1, 4+0, 5-1), 'zip-plus with lazy lists';

# tests for non-list arguments
is (1 Z* 3,4), (3), 'zip-product works with scalar left side';
is (1, 2 Z* 3), (3), 'zip-product works with scalar right side';
is (1 Z* 3), (3), 'zip-product works with scalar both sides';

# L<S03/"Hyper operators"/is assumed to be infinitely extensible>
#?rakudo todo "Doesn't extend lists ending in , * yet"
is (<a b c d> Z~ 'x', 'z', *), <ax bz cz dz>, 'zip extends arguments ending with *';

done_testing;

# vim: ft=perl6
