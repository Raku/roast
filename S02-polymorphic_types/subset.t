use v6;
use Test;
plan 33;

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
              "Can't assign value that violates type constraint via subset";

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
    #?rakudo skip '(noauto) succeeds for the wrong reason (need to test the error)'
    dies_ok { my Person $p = { :first<Charlie>, :last<Delta> } },
            'subset of hash with where enforces where clause';

    subset Austria of Array;
    lives_ok { my Austria $a = [] },
             'can create subset of array';

    subset NumArray of Array where { .elems == .grep: { $_ ~~ Num } }
    lives_ok { my NumArray $n = [] },
             'can create subset of array with where';
    #?rakudo skip '(noauto) succeeds for the wrong reason (need to test the error)'
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

    subset Subseq of Seq;
    lives_ok { my Subseq $tsil = <a b c>.Seq },
             'can create subset of Seq';

    subset FewOdds of Seq where { 2 > .grep: { $_ % 2 } }
    lives_ok { my FewOdds $fe = <78 99 24 36>.Seq },
             'can create subset of Seq with where';
    dies_ok { my FewOdds $bomb = <78 99 24 36 101>.Seq },
            'subset of Seq with where enforces where';
}

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

# RT #67256
{
    subset RT67256 of Int where { $^i > 0 }
    my RT67256 $rt67256;

    try { $rt67256 = -42 }

    ok  $!  ~~ Exception, 'subset of Int enforces where clause';
    #?rakudo todo 'RT #67256'
    ok "$!" ~~ / RT67256 /, 'error for bad assignment mentions subset';
}

# RT #69334
{
    class Y {has $.z};
    subset sY of Y where {.z == 0};

    lives_ok { 4 ~~ sY }, 'Nominal type is checked first';
    ok 4 !~~ sY, 'and if nominal type check fails, it is False';
}

# RT #74234
{
    #?rakudo todo 'RT 74234'
    eval_lives_ok 'subset A of Mu; my A $x = 23;',
        'subset A of Mu + type check and assignment works';
}

# vim: ft=perl6
