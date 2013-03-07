use v6;
use Test;
plan 46;

=begin description

Test for 'subset' with a closure

=end description

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Even of Int where { $_ % 2 == 0 };

{
    my Even $x = 2;
    is $x, 2, 'Can assign value to a type variable with subset';
};

#?pugs todo
dies_ok { eval('my Even $x = 3') },
              "Can't assign value that violates type constraint via subset";

# RT # 69518'
#?niecza todo
#?pugs todo
dies_ok { eval('Even.new') }, 'Cannot instantiate a subtype';

#?pugs skip "can't find Even"
{
    ok 2 ~~ Even,  'Can smartmatch against subsets 1';
    ok 3 !~~ Even, 'Can smartmatch against subsets 2';
}

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

#?pugs emit #
subset Digit of Int where ^10;

{
    my Digit $x = 3;
    is  $x,     3,  "Can assign to var with 'subset' type constraint";
    $x = 0;
    is  $x,     0,  "one end of range";
    $x = 9;
    is  $x,     9,  "other end of range";
}

#?pugs 3 todo
dies_ok { my Digit $x = 10 },
             'type constraints prevents assignment 1';
dies_ok { my Digit $x = -1 },
        'type constraints prevents assignment 2';
dies_ok { my Digit $x = 3.1 },
             'original type prevents assignment';

# RT #67818
{
    subset Subhash of Hash;
    lives_ok { my Subhash $a = {} },
             'can create subset of hash';

    subset Person of Hash where { .keys.sort ~~ <firstname lastname> }
    lives_ok { my Person $p = { :firstname<Alpha>, :lastname<Bravo> } },
             'can create subset of hash with where';
    #?pugs todo
    dies_ok { my Person $p = { :first<Charlie>, :last<Delta> } },
            'subset of hash with where enforces where clause';

    subset Austria of Array;
    lives_ok { my Austria $a = [] },
             'can create subset of array';

    subset NumArray of Array where { .elems == .grep: { $_ ~~ Num } }
    lives_ok { my NumArray $n = [] },
             'can create subset of array with where';
    #?rakudo skip '(noauto) succeeds for the wrong reason (need to test the error)'
    #?pugs todo
    dies_ok { my NumArray $n = <Echo 2> },
            'subset of array with where enforces where clause';

    subset Meercat of Pair;
    lives_ok { my Meercat $p = :a<b> },
             'can create subset of pair';

    subset Ordered of Pair where { .key < .value }
    lives_ok { my Ordered $o = 23 => 42 },
             'can create subset of Pair with where';
    #?pugs todo
    dies_ok { my Ordered $o = 42 => 23 },
            'subset of pair with where enforces where clause';
}

#?niecza skip 'Seq NYI'
{
    #?rakudo todo 'Seq not implemented in nom'
    subset Subseq of Seq;
    #?pugs todo
    lives_ok { my Subseq $tsil = <a b c>.Seq },
             'can create subset of Seq';


    #?rakudo todo 'Seq not yet implemented in nom'
    subset FewOdds of Seq where { 2 > .grep: { $_ % 2 } }
    #?pugs todo
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
    #?pugs todo
    dies_ok { $text = 'oops' },
            'my subset of Str where pattern enforces pattern';
}

{
    subset Negation of Str where /^[isnt|arent|amnot|aint]$/;
    my Negation $text;
    $text = 'amnot';
    is $text, 'amnot', 'assignment to subset of Str where pattern worked';
    #?pugs todo
    dies_ok { $text = 'oops' }, 'subset of Str where pattern enforces pattern';
}

# RT #67256
#?niecza skip "Exception NYI"
#?pugs skip   "Exception NYI"
{
    subset RT67256 of Int where { $^i > 0 }
    my RT67256 $rt67256;

    try { $rt67256 = -42 }

    ok  $!  ~~ Exception, 'subset of Int enforces where clause';
    ok "$!" ~~ / RT67256 /, 'error for bad assignment mentions subset';
}

# RT #69334
#?pugs skip "Can't find SY"
{
    class Y {has $.z};
    subset sY of Y where {.z == 0};

    lives_ok { 4 ~~ sY }, 'Nominal type is checked first';
    ok 4 !~~ sY, 'and if nominal type check fails, it is False';
}

# RT #74234
#?niecza todo
{
    eval_lives_ok 'subset A of Mu; my A $x = 23;',
        'subset A of Mu + type check and assignment works';
}

# RT #77356
#?pugs skip "Can't find aboveLexLimit"
{
    sub limit() { 0 }
    subset aboveLexLimit of Int where { $_ > limit() };
    ok 1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (1)';
    nok -1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (2)';
}

# RT # 77356
#?pugs skip "Can't find aboveLexVarLimit"
{
    my $limit = 0;
    subset aboveLexVarLimit of Int where { $_ > $limit };
    ok 1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (1)';
    nok -1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (2)';
}

#?pugs emit #
subset Bug::RT80930 of Int where { $_ %% 2 };
lives_ok { my Bug::RT80930 $rt80930 }, 'subset with "::" in the name';

# RT #95500
#?pugs skip "Can't find SomeStr"
{
    subset SomeStr of Str where any <foo bar>;
     ok 'foo' ~~ SomeStr, 'subset ... where any(...) (+)';
    nok 'fox' ~~ SomeStr, 'subset ... where any(...) (-)';
}


# RT #65308
#?niecza skip 'Methods must be used in some kind of package'
#?pugs todo
{
    subset FooStr of Str where /^foo/;
    my multi method uc(FooStr $self:) { return "OH HAI" }; #OK not used
    is "foo".uc, 'FOO', 'multi method with subset invocants do not magically find their way into the method dispatch';

}

# RT #73344
my $a = 1;
#?pugs skip 'where'
{
    my $a = 3;
    sub producer {
        my $a = 2;
        sub bar($x where $a ) { $x }  #OK not used
    }
    my &bar := producer();
    lives_ok { bar(2) }, 'where-constraint picks up the right lexical (+)';
    dies_ok  { bar(1) }, 'where-constraint picks up the right lexical (-)';
}

#?pugs skip 'MI not found'
{
    #RT #113434
    my subset MI of Int;
    ok MI ~~ Mu,   'subset conforms to Mu';
    ok MI ~~ Int,  'subset conforms to base type';
    nok Mu  ~~ MI, 'Mu does not conform to subset';
}

# RT #74352
#?pugs skip 'parsefail'
{
    subset A of Array;
    subset B of A;
    subset C of A;
    subset D of A where B & C;
    ok [] ~~ D, "complicated subset combinations #74352";
}

# vim: ft=perl6
