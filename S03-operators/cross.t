use v6;

use Test;
plan 26;

# L<S03/List infix precedence/the cross operator>
ok eval('<a b> X <c d>'), 'cross non-meta operator parses';

{
    my @result = <a b> X <1 2>;
    is @result, <a 1 a 2 b 1 b 2>,
    'non-meta cross produces expected result';

}

is (1, 2, 3 X** 2, 4), (1, 1, 4, 16, 9, 81), 'X** works';

is ([+] 1, 2, 3 X** 2, 4), (1+1 + 4+16 + 9+81), '[+] and X** work';

# L<S03/List infix precedence/This becomes a flat list in>
#?rakudo todo "Array/list/iterator issues"
{
    my @result = gather {
        for @(1..3 X 'a'..'b') -> $n, $a {
            take "$n|$a"
        }
    }
    is @result, <1|a 1|b 2|a 2|b 3|a 3|b>, 'smooth cross operator works';
}

# L<S03/List infix precedence/and a list of arrays in>
#?rakudo skip ".slice for iterators NYI"
{
    my @result = gather for (1..3 X 'A'..'B').slice -> $na {
        take $na.join(':');
    }
    is @result, <1:A 1:B 2:A 2:B 3:A 3:B>, 'chunky cross operator works';
}

# L<S03/Cross operators>
ok eval('<a b> X, <c d>'), 'cross metaoperator parses';

# L<S03/Cross operators/"string concatenating form is">
#?pugs todo 'feature'
{
    my @result = <a b> X~ <1 2>;
    is @result, <a1 a2 b1 b2>,
        'cross-concat produces expected result';
}

# L<S03/Cross operators/desugars to something like>
#?rakudo skip 'parsefail: prefix hypers not implemented'
{
    my @result = [~]«( <a b> X, <1 2> );
    #?pugs todo 'feature'
    is @result, <a1 a2 b1 b2>,
        'X, works with hyperconcat';
}

# L<S03/Cross operators/list concatenating form when used like this>
#?rakudo skip 'chained cross NYI'
{
    my @result = <a b> X, 1,2 X, <x y>;
    is @result.elems, 24, 'chained cross-comma produces correct number of elements';

    my @expected = (
        ['a', 1, 'x'],
        ['a', 1, 'y'],
        ['a', 2, 'x'],
        ['a', 2, 'y'],
        ['b', 1, 'x'],
        ['b', 1, 'y'],
        ['b', 2, 'x'],
        ['b', 2, 'y'],
    );
    is @result, @expected, 'chained cross-comma produces correct results';
}

# L<S03/Cross operators/any existing non-mutating infix operator>
is (1,2 X* 3,4), (3,4,6,8), 'cross-product works';

is (1,2 Xcmp 3,2,0), (-1, -1, 1, -1, 0, 1), 'Xcmp works';

# L<S03/Cross operators/underlying operator non-associating>
eval_dies_ok '@result Xcmp @expected Xcmp <1 2>',
    'non-associating ops cannot be cross-ops';

# let's have some fun with X..., comparison ops and junctions:

{
    ok ( ? all 1, 2 X<= 2, 3, 4 ), 'all @list1 X<= @list2';
    ok ( ? [|] 1, 2 X<= 0, 3),     '[|] @l1 X<= @l2';
    ok ( ! all 1, 2 X<  2, 3),     'all @l1 X<  @l2';
    ok ( ? one 1, 2 X== 2, 3, 4),  'one @l1 X== @l2';
    ok ( ! one 1, 2 X== 2, 1, 4),  'one @l1 X== @l2';
}

#?rakudo skip "=:= NYI"
{
    my ($a, $b, $c, $d);
    # test that the containers on the LHS are mutually exclusive from
    # those on the RHS
    ok ( ? all $a, $b X!=:= $c, $d ), 'X!=:= (1)';
    ok ( ? all $a, $a X!=:= $c, $d ), 'X!=:= (2)';
    ok ( ! all $a, $b X!=:= $c, $b ), 'X!=:= (3)';
    $c := $b;
    ok ( ? one $a, $b X=:=  $c, $d ), 'one X=:=';
}

# tests for non-list arguments
is (1 X* 3,4), (3, 4), 'cross-product works with scalar left side';
is (1, 2 X* 3), (3, 6), 'cross-product works with scalar right side';
is (1 X* 3), (3), 'cross-product works with scalar both sides';

# vim: ft=perl6
