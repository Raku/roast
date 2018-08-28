use v6;

use Test;
plan 76;

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

{
is (<a b c d> Z 'x', 'z', *), <a x b z c z d z>, 'non-meta zip extends right argument ending with *';
is (1, 2, 3, * Z 10, 20, 30, 40, 50),
    (1, 10, 2, 20, 3, 30, 3, 40, 3, 50), 'non-meta zip extends left argument ending with *';
is (2, 10, * Z 3, 4, 5, *).[^5],
    (2, 3, 10, 4, 10, 5, 10, 5, 10, 5),
    'non-meta zip extends two arguments ending with *';
is (<a b c d> Z~ 'x', 'z', *), <ax bz cz dz>, 'zip-concat extends right argument ending with *';
}

{
is (1, 2, 3, * Z+ 10, 20, 30, 40, 50), (11, 22, 33, 43, 53), 'zip-plus extends left argument ending with *';
is (2, 10, * Z* 3, 4, 5, *).[^5],
    (6, 40, 50, 50, 50), 'zip-product extends two arguments ending with *';
}

{
    is join(',', [Z+] (1, 2), (20, 10), (100, 200)),
       '121,212', '[Z+] with three lists';
}

# RT #75818
isa-ok (1 Z 2)[0], List, 'zip returns a list of lists';

# RT #113800  - multiple Z operators work with list associative
{
    my $l = (1,2,3 Z, 4,5,6 Z, 7,8,9);
    is $l.[0].elems, 3, 'Z, retains list associativity';
    is $l.[1].elems, 3, 'Z, retains list associativity';
    is $l.[2].elems, 3, 'Z, retains list associativity';
}

# RT #73948
is (1, 2 Z, 3, 4).flat.join('|'), '1|3|2|4', 'Z, flattens in list context';

{
    my @a = 1,2,3;
    @a Z+= 3,2,1;
    is ~@a, '4 4 4', 'zip can modify containers on the left'
}

# RT #116036
{
    is (<a b> Z=> ([],)), (a => []), 'zip does not flatten itemized list';
}

{
    my @a = 0 xx 3;
    @a Z= 1,2,3;
    is @a, '1 2 3', "Z= works";
}

{
    is [Z](1,2,3;4,5,6;7,8,9), '1 4 7 2 5 8 3 6 9', 'can reduce-zip a direct lol';
    is [Z<](1,2,3;4,5,6;7,8,9), 'True True True', 'can reduce-zip-< a direct lol';

    my \lol = (1..*),(4..6),(7..*);
    is [Z](lol), '1 4 7 2 5 8 3 6 9', 'can reduce-zip an indirect lol';
    is [Z<](lol), 'True True True', 'can reduce-zip-< an indirect lol';
}

{
    ok (1..* Z 1..*).is-lazy, "laziness induced by two arguments (Z)";
    ok (1..* Z 1..* Z 1..*).is-lazy, "laziness induced by three arguments (Z)";
    ok !(1..* Z 42).is-lazy, "laziness defeated by last argument (Z)";
    ok !(42 Z 1..*).is-lazy, "laziness defeated by first argument (Z)";
    ok !(1..* Z 42 Z 1..*).is-lazy, "laziness defeated by middle argument (Z)";
    ok !(1..5 Z 1..*).is-lazy, "laziness defeated by first argument (Z)";
    ok !(1..* Z 1..5).is-lazy, "laziness defeated by last argument (Z)";
    ok !(1..* Z 1..5 Z 1..*).is-lazy, "laziness defeated by middle argument (Z)";
}

{
    ok (1..* Z* 1..*).is-lazy, "laziness induced by two arguments (Z*)";
    ok (1..* Z* 1..* Z* 1..*).is-lazy, "laziness induced by three arguments (Z*)";
    ok !(1..* Z* 42).is-lazy, "laziness defeated by last argument (Z*)";
    ok !(42 Z* 1..*).is-lazy, "laziness defeated by first argument (Z*)";
    ok !(1..* Z* 42 Z* 1..*).is-lazy, "laziness defeated by middle argument (Z*)";
    ok !(1..5 Z* 1..*).is-lazy, "laziness defeated by first argument (Z*)";
    ok !(1..* Z* 1..5).is-lazy, "laziness defeated by last argument (Z*)";
    ok !(1..* Z* 1..5 Z* 1..*).is-lazy, "laziness defeated by middle argument (Z*)";
}

throws-like '3 Z. foo', X::Syntax::CannotMeta, "Z. is too fiddly";
throws-like '3 Z. "foo"', X::Obsolete, "Z. can't do P5 concat";

is-deeply &infix:<Z+>((1,2,3),(4,5,6)), (5, 7, 9), "Meta zip can autogen";
is-deeply &infix:<Z+>((1,2,3),(1,2,3),(1,2,3)), (3, 6, 9), "Meta zip can autogen (3-ary)";
is-deeply infix:<Z+>((1,2,3),(1,2,3),(1,2,3)), (3, 6, 9), "Meta zip can autogen (3-ary) without &";
is-deeply &[Z+]((1,2,3),(1,2,3),(1,2,3)), (3, 6, 9), "Meta zip can autogen (3-ary) with &[]";

{
    my $side-effect = 0;
    $side-effect++ Zxx 0;
    is $side-effect, 1, "Zxx does not thunk non-list";
}
{
    my $side-effect = 0;
    ($side-effect++,) Zxx 0;
    is $side-effect, 0, "Zxx thunks left side properly";
    ($side-effect++,) Zxx 1;
    is $side-effect, 1, "Zxx thunk runs when needed";
    ($side-effect++,) Zxx 9;
    is $side-effect, 10, "Zxx thunk runs repeatedly when needed";
}
{
    my Mu $side-effect = 0;
    0 Zand ($side-effect++,);
    is $side-effect, 0, "Zand thunks right side properly";
    1 Zand ($side-effect++,);
    is $side-effect, 1, "Zand thunks runs when needed";
}
{
    my Mu $side-effect = 0;
    0 Z&& ($side-effect++,);
    is $side-effect, 0, "Z&& thunks right side properly";
    1 Z&& ($side-effect++,);
    is $side-effect, 1, "Z&& thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    1 Zor ($side-effect++,);
    is $side-effect, 0, "Zor thunks right side properly";
    0 Zor ($side-effect++,);
    is $side-effect, 1, "Zor thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    1 Z|| ($side-effect++,);
    is $side-effect, 0, "Z|| thunks right side properly";
    0 Z|| ($side-effect++,);
    is $side-effect, 1, "Z|| thunk runs when needed";
}
{
    my Mu $side-effect = 0;
    Nil Zandthen ($side-effect++,);
    is $side-effect, 0, "Zandthen thunks right side properly";
    1 Zandthen ($side-effect++,);
    is $side-effect, 1, "Zandthen thunks runs when needed";
    23 Zandthen ($side-effect = $_,);
    is $side-effect, 23, "Zandthen topicalizes when needed";
}
{
    my Mu $side-effect is default(Nil) = 0;
    1 Zorelse ($side-effect++,);
    is $side-effect, 0, "Zorelse thunks right side properly";
    Nil Zorelse ($side-effect++,);
    is $side-effect, 1, "Zorelse thunk runs when needed";
    Nil Zorelse ($side-effect = $_,);
    ok $side-effect === Nil, "Zorelse topicalizes when needed";
}

# RT #126522
is ($(1, 2) Z <a b c>), (($(1, 2), 'a'),),
    'Z respects itemization of arguments (1)';
is (<a b c> Z $(1, 2)), (('a', $(1, 2)),),
    'Z respects itemization of arguments (2)';
is ($(1, 2) Z~ <a b c>), ('1 2a',),
    'Z meta-op respects itemization of arguments (1)';
is (<a b c> Z~ $(1, 2)), ('a1 2',),
    'Z meta-op respects itemization of arguments (2)';

cmp-ok infix:<Z>(), 'eqv', ().Seq, 'artity-0 Z returns a Seq';

# vim: ft=perl6
