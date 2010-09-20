use v6;

use Test;
plan 18;

ok eval('<a b> Z <c d>'), 'zip non-meta operator parses';

is (<a b> Z <1 2>), <a 1 b 2>, 'non-meta zip produces expected result';

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

is (<a b c d> Z 'x', 'z', *), <a x b z c z d z>, 'non-meta zip extends right argument ending with *';
is (1, 2, 3, * Z 10, 20, 30, 40, 50),
    (1, 10, 2, 20, 3, 30, 3, 40, 3, 50), 'non-meta zip extends left argument ending with *';
is (2, 10, * Z 3, 4, 5, *).munch(10),
    (2, 3, 10, 4, 10, 5, 10, 5, 10, 5),
    'non-meta zip extends two arguments ending with *';

is (<a b c d> Z~ 'x', 'z', *), <ax bz cz dz>, 'zip-concat extends right argument ending with *';
is (1, 2, 3, * Z+ 10, 20, 30, 40, 50), (11, 22, 33, 43, 53), 'zip-plus extends left argument ending with *';
is (2, 10, * Z* 3, 4, 5, *).munch(5),
    (6, 40, 50, 50, 50), 'zip-product extends two arguments ending with *';

done_testing;

# vim: ft=perl6
