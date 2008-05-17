use v6;

use Test;
plan 11;

# L<S03/List infix precedence/the cross operator>
ok eval('<a b> X <c d>'), 'cross non-meta operator parses';

{
    my @result = <a b> X <1 2>;
    is @result, <a 1 a 2 b 1 b 2>,
    'non-meta cross produces expected result';
}

# L<S03/List infix precedence/This becomes a flat list in>
#?rakudo skip 'parsefail: sigil coercion'
{
    my @result = gather {
        for @(1..3 X 'a'..'b') -> $n, $a {
            take "$n:$a"
        }
    }
    is @result, <1:a 1:b 2:a 2:b 3:a 3:b>, 'smooth cross operator works';
}

# L<S03/List infix precedence/and a list of arrays in>
#?rakudo skip 'parsefail: sigil coercion'
{
    my @result = gather for @@(1..3 X 'A'..'B') -> $na {
        take $na.join(':');
    }
    is @result, <1:A 1:B 2:A 2:B 3:A 3:B>, 'chunky cross operator works';
}

# L<S03/Cross operators/formed syntactically by placing>
#?rakudo skip 'parsefail: meta cross op not implemented, eval dies'
ok eval('<a b> X,X <c d>'), 'cross metaoperator parses', :todo<feature>;

# L<S03/Cross operators/"string concatenating form is">
#?rakudo skip 'parsefail: meta cross op not implemented'
{
    my @result = <a b> X~X <1 2>;
    is @result, <a1 a2 b1 b2>,
        'cross-concat produces expected result', :todo<feature>;
}

# L<S03/Cross operators/desugars to something like>
#?rakudo skip 'parsefail: meta cross op not implemented'
{
    my @result = [~]«( <a b> X,X <1 2> );
    is @result, <a1 a2 b1 b2>,
        'X,X works with hyperconcat', :todo<feature>;
}

# L<S03/Cross operators/list concatenating form when used like this>
#?rakudo skip 'parsefail: meta cross op not implemented'
{
    my @result = <a b> X,X 1,2 X,X <x y>;
    is @result.elems, 8, 'chained cross-comma produces correct number of elements',
        :todo<feature>;

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
    is @result, @expected,
        'chained cross-comma produces correct results', :todo<feature>;
}

# L<S03/Cross operators/any existing non-mutating infix operator>
#?rakudo skip 'parsefail: meta cross op not implemented'
is (1,2 X*X 3,4), (3,4,6,8), 'cross-product works', :todo<feature>;

# L<S03/Cross operators/underlying operator non-associating>
#?rakudo skip 'dies_ok() not implemented'
dies_ok '@result XcmpX @expected XcmpX <1 2>',
    'non-associating ops cannot be cross-ops';
