use v6;

use Test;
plan 24;

ok EVAL('<a b> Z <c d>'), 'zip non-meta operator parses';

is (<a b> Z <1 2>), <a 1 b 2>, 'non-meta zip produces expected result';

is (1, 2, 3 Z** 2, 4), (1, 16), 'zip-power works';

ok EVAL('<a b> Z, <c d>'), 'zip metaoperator parses';

is (<a b> Z~ <1 2>), <a1 b2>, 'zip-concat produces expected result';

is (1,2 Z* 3,4), (3,8), 'zip-product works';

is (1,2 Zcmp 3,2,0), (Order::Less, Order::Same), 'zip-cmp works';

# tests for laziness
is (1..* Z** 1..*).[^5], (1**1, 2**2, 3**3, 4**4, 5**5), 'zip-power with lazy lists';
is (1..* Z+ (3, 2 ... *)).[^5], (1+3, 2+2, 3+1, 4+0, 5-1), 'zip-plus with lazy lists';

# tests for non-list arguments
is (1 Z* 3,4), (3), 'zip-product works with scalar left side';
is (1, 2 Z* 3), (3), 'zip-product works with scalar right side';
is (1 Z* 3), (3), 'zip-product works with scalar both sides';

# L<S03/"Hyper operators"/is assumed to be infinitely extensible>

#?rakudo todo 'nom regression'
{
#?niecza todo
is (<a b c d> Z 'x', 'z', *), <a x b z c z d z>, 'non-meta zip extends right argument ending with *';
#?niecza todo
is (1, 2, 3, * Z 10, 20, 30, 40, 50),
    (1, 10, 2, 20, 3, 30, 3, 40, 3, 50), 'non-meta zip extends left argument ending with *';
#?niecza skip 'Unable to resolve method munch in class List'
is (2, 10, * Z 3, 4, 5, *).munch(10),
    (2, 3, 10, 4, 10, 5, 10, 5, 10, 5),
    'non-meta zip extends two arguments ending with *';
#?niecza todo
is (<a b c d> Z~ 'x', 'z', *), <ax bz cz dz>, 'zip-concat extends right argument ending with *';
}

#?rakudo skip 'nom regression'
#?niecza skip 'Cannot use value like Whatever as a number'
{
is (1, 2, 3, * Z+ 10, 20, 30, 40, 50), (11, 22, 33, 43, 53), 'zip-plus extends left argument ending with *';
is (2, 10, * Z* 3, 4, 5, *).munch(5),
    (6, 40, 50, 50, 50), 'zip-product extends two arguments ending with *';
}

#?niecza todo
{
    is join(',', [Z+] [1, 2], [20, 10], [100, 200]),
       '121,212', '[Z+] with three arrays';
}

# RT #75818
isa_ok (1 Z 2)[0], Parcel, 'zip returns a list of parcels';

# RT #113800  - multiple Z operators work with list associative
#?niecza skip "Unable to resolve method lol in type Parcel"
{
    my $l = (1,2,3 Z, 4,5,6 Z, 7,8,9);
    is $l.[0].lol.elems, 3, 'Z, retains list associativity';
    is $l.[1].lol.elems, 3, 'Z, retains list associativity';
    is $l.[2].lol.elems, 3, 'Z, retains list associativity';
}

# RT #73948
is (1, 2 Z, 3, 4).join('|'), '1|3|2|4', 'Z, flattens in list context';

# vim: ft=perl6
