use v6;
use Test;
plan 14;

is (1, 2, (3, 4)).tree.elems, 3, 'basic sanity (1)';
is (1, 2, (3, 4)).tree.join('|'), '1|2|3 4', 'basic sanity (2)';
ok List.tree === List, '.tree on a type object';
is (1, 2, (3, 4)).tree(1).join('|'), '1|2|3 4', '.tree(1)';
is (1, (2, (3, 4))).tree(1).[1].flat.elems, 3,
    '.tree(1) really only goes one level deep';

is (1, (2, (3, 4))).tree(2).[1].elems, 2,
    '.tree(2) goes two levels deep';
is ((1, 2), (3, 4)).tree(*.flat.join('|')), '1|2|3|4',
    'WhateverCode form, depth 1';
is ((1, 2), (3, 4)).tree(*.join(' '), *.join('|')), '1|2 3|4',
    'WhateverCode form, depth 2';

is (1, ((2, 3),  (4, 5))).tree(*.join('-'), *.join('+'), *.join('|')),
    '1-2|3+4|5', '.tree with multiple Whatever-closures';

{
    my $t = '';
    $t ~= "|$_" for (<a b c> Z <X Y Z>).tree[];
    is $t, "|a X|b Y|c Z", '(list of lists).tree';
}

{ # coverage; 2016-09-18
    my $i = 42;
    my @i = 1, 2;
    subtest '... returns self' => {
        plan 7;
        cmp-ok @i.tree(0),  '===', @i, '.tree(0) on Iterable';
        cmp-ok $i.tree,     '===', $i, '.tree    on non-Iterable';
        cmp-ok $i.tree(1),  '===', $i, '.tree(1) on non-Iterable';
        cmp-ok $i.tree(0),  '===', $i, '.tree(0) on non-Iterable';
        cmp-ok $i.tree(*),  '===', $i, '.tree(*) on non-Iterable';
        cmp-ok $i.tree([{;}]),  '===', $i, '.tree([&first]) on non-Iterable';
        cmp-ok $i.tree([{;}, 1, 2, 3]),  '===', $i,
            '.tree([&first, *@rest]) on non-Iterable';
    }
    is-deeply @i.tree(*), @i.tree, '.tree(*) returns self.tree';

    is @i.tree([{
        cmp-ok $^arg, '===', @i, '.tree([&first]) calls first(self)';
        42;
    }]), 42, '.tree([&first]) returns result of first(self)';
}
