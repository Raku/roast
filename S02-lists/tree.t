use v6;
use Test;
plan 3;

is (1, 2, (3, 4)).tree.elems, 3, 'basic sanity (1)';
is (1, 2, (3, 4)).tree.join('|'), '1|2|3 4', 'basic sanity (2)';


#?rakudo skip 'Advanced forms of .tree'
{
    is ~((1, 2), (3, 4)).tree(*.join('|')), '1|2 3|4',
       'WhateverCode form, depth 1';
}
