use v6;
use Test;
plan 30;

=begin description

Test for 'subset' with a closure

=end description

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Even of Int where { $_ % 2 == 0 };

{
    my Even $x = 2;
    is $x, 2, 'Can assign value to a type variable with subset';
};

eval_dies_ok  'my Even $x = 3',
              "Can't assing value that violates type constraint via subst";

{
    ok 2 ~~ Even,  'Can smartmatch against subsets 1';
    ok 3 !~~ Even, 'Can smartmatch against subsets 2';
}

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Digit of Int where ^10;

{
    my Digit $x = 3;
    is  $x,     3,  "Can assign to var with 'subset' type constraint";
    $x = 0;
    is  $x,     0,  "one end of range";
    $x = 9;
    is  $x,     9,  "other end of range";
}

eval_dies_ok 'my Digit $x = 10',
             'type constraints prevents assignment 1';
eval_dies_ok 'my Digit $x = -1',
             'type constraints prevents assignment 2';
eval_dies_ok 'my Digit $x = 3.1',
             'original type prevents assignment';

# RT #67818
{
    subset Subhash of Hash;
    #?rakudo todo 'RT #67818'
    lives_ok { my Subhash $a = {} },
             'can create subset of hash';

    subset Person of Hash where { .keys.sort ~~ <firstname lastname> }
    #?rakudo todo 'RT #67818'
    lives_ok { my Person $p = { :firstname<Alpha>, :lastname<Bravo> } },
             'can create subset of hash with where';
    #?rakudo skip 'succeeds for the wrong reason (need to test the error)'
    dies_ok { my Person $p = { :first<Charlie>, :last<Delta> } },
            'subset of hash with where enforces where clause';

    subset Austria of Array;
    #?rakudo todo 'RT #67818'
    lives_ok { my Austria $a = [] },
             'can create subset of array';

    subset NumArray of Array where { .elems == .grep: { $_ ~~ Num } }
    #?rakudo todo 'RT #67818'
    lives_ok { my NumArray $n = [] },
             'can create subset of array with where';
    #?rakudo skip 'succeeds for the wrong reason (need to test the error)'
    dies_ok { my NumArray $n = <Echo 2> },
            'subset of array with where enforces where clause';

    subset Meercat of Pair;
    lives_ok { my Meercat $p = :a<b> },
             'can create subset of pair';

    subset Ordered of Pair where { .key < .value }
    lives_ok { my Ordered $o = 23 => 42 },
             'can create subset of Pair with where';
    dies_ok { my Ordered $o = 42 => 23 },
            'subset of pair with where enforces where clause';

    subset Sublist of List;
    lives_ok { my Sublist $tsil = [] },
             'can create subset of list';

    subset FewOdds of List where { 2 > .grep: { $_ % 2 } }
    lives_ok { my FewOdds $fe = <78 99 24 36> },
             'can create subset of List with where';
    dies_ok { my FewOdds $bomb = <78 99 24 36 101> },
            'subset of List with where enforces where';
}

#?rakudo skip 'my subset = Null PMC Access'
{
    my subset Str_not2b of Str where /^[isnt|arent|amnot|aint]$/;
    my Str_not2b $text;
    $text = 'amnot';
    is $text, 'amnot', 'assignment to my subset of Str where pattern worked';
    dies_ok { $text = 'oops' },
            'my subset of Str where pattern enforces pattern';
}

{
    subset Negation of Str where /^[isnt|arent|amnot|aint]$/;
    my Negation $text;
    $text = 'amnot';
    is $text, 'amnot', 'assignment to subset of Str where pattern worked';
    dies_ok { $text = 'oops' }, 'subset of Str where pattern enforces pattern';
}

#?rakudo skip 'adding braces breaks subset?'
{
    subset Naht of Str where { /^[isnt|arent|amnot|aint]$/ };
    my Naht $text;
    $text = 'amnot';
    is $text, 'amnot',
       'assignment to subset of Str where pattern in braces worked';
    dies_ok { $text = 'oops' },
            'subset of Str where pattern in braces enforces pattern';
}

# RT #67786
{
    subset RT67786 of Int where { $^i > 0 }
    my RT67786 $rt67786;

    try { $rt67786 = -42 }

    ok  $!  ~~ Exception, 'subset of Int enforces where clause';
    #?rakudo todo 'RT #67786'
    ok "$!" ~~ / RT67786 /, 'error for bad assignment mentions subset';
}

# vim: ft=perl6
