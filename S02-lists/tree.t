use v6;
use Test;
plan 9;

is (1, 2, (3, 4)).tree.elems, 3, 'basic sanity (1)';
is (1, 2, (3, 4)).tree.join('|'), '1|2|3 4', 'basic sanity (2)';
ok List.tree === List, '.tree on a type object';
is (1, 2, (3, 4)).tree(1).join('|'), '1|2|3 4', '.tree(1)';
is (1, (2, (3, 4))).tree(1).[1].flat.elems, 3,
    '.tree(1) really only goes one level deep';

is (1, (2, (3, 4))).tree(2).[1].flat.elems, 2,
    '.tree(2) goes two levels deep';
is ~((1, 2), (3, 4)).tree(*.join('|')), '1|2 3|4',
    'WhateverCode form, depth 1';

#?rakudo skip 'Any.tree(*@list) NYI'
is (1, ((2, 3),  (4, 5))).tree(*.join('|'), *.join('+')).join('-'),
    '1-2|3+4|5', '.tree with multiple Whatever-closures';

{
    my $t = '';
    $t ~= "|$_" for (<a b c> Z <X Y Z>).tree;
    is $t, "|a X|b Y|c Z", '(parcel of parcels).tree';
}
