use v6;
use Test;
plan 44;

=begin description

Test for 'subset' with a closure

=end description

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Even of Int where { $_ % 2 == 0 };

{
    my Even $x = 2;
    is $x, 2, 'Can assign value to a type variable with subset';
};

dies-ok { EVAL('my Even $x = 3') },
              "Can't assign value that violates type constraint via subset";

# RT # 69518'
#?niecza todo
dies-ok { EVAL('Even.new') }, 'Cannot instantiate a subtype';

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

dies-ok { my Digit $x = 10 },
             'type constraints prevents assignment 1';
dies-ok { my Digit $x = -1 },
        'type constraints prevents assignment 2';
dies-ok { my Digit $x = 3.1 },
             'original type prevents assignment';

# RT #67818
{
    subset Subhash of Hash;
    lives-ok { my Subhash $a = {} },
             'can create subset of hash';

    subset Person of Hash where { .keys.sort ~~ ['firstname', 'lastname'] }
    lives-ok { my Person $p = { :firstname<Alpha>, :lastname<Bravo> } },
             'can create subset of hash with where';
    dies-ok { my Person $p = { :first<Charlie>, :last<Delta> } },
            'subset of hash with where enforces where clause';

    subset Austria of Array;
    lives-ok { my Austria $a = [] },
             'can create subset of array';

    subset NumArray of Array where { .elems == .grep: { $_ ~~ Num } }
    lives-ok { my NumArray $n = [] },
             'can create subset of array with where';
    #?rakudo skip '(noauto) succeeds for the wrong reason (need to test the error)'
    dies-ok { my NumArray $n = <Echo 2> },
            'subset of array with where enforces where clause';

    subset Meercat of Pair;
    lives-ok { my Meercat $p = :a<b> },
             'can create subset of pair';

    subset Ordered of Pair where { .key < .value }
    lives-ok { my Ordered $o = 23 => 42 },
             'can create subset of Pair with where';
    dies-ok { my Ordered $o = 42 => 23 },
            'subset of pair with where enforces where clause';
}

{
    my subset Str_not2b of Str where /^[isnt|arent|amnot|aint]$/;
    my Str_not2b $text;
    $text = 'amnot';
    is $text, 'amnot', 'assignment to my subset of Str where pattern worked';
    dies-ok { $text = 'oops' },
            'my subset of Str where pattern enforces pattern';
}

{
    subset Negation of Str where /^[isnt|arent|amnot|aint]$/;
    my Negation $text;
    $text = 'amnot';
    is $text, 'amnot', 'assignment to subset of Str where pattern worked';
    dies-ok { $text = 'oops' }, 'subset of Str where pattern enforces pattern';
}

# RT #67256
#?niecza skip "Exception NYI"
{
    subset RT67256 of Int where { $^i > 0 }
    my RT67256 $rt67256;

    try { $rt67256 = -42 }

    ok  $!  ~~ Exception, 'subset of Int enforces where clause';
    ok "$!" ~~ / RT67256 /, 'error for bad assignment mentions subset';
}

# RT #69334
{
    class Y {has $.z};
    subset sY of Y where {.z == 0};

    lives-ok { 4 ~~ sY }, 'Nominal type is checked first';
    ok 4 !~~ sY, 'and if nominal type check fails, it is False';
}

# RT #74234
#?niecza todo
{
    subset RT74234 of Mu;
    my RT74234 $rt74234 = 23;
    is $rt74234, 23, 'subset RT74234 of Mu + type check and assignment works';
}

# RT #77356
{
    sub limit() { 0 }
    subset aboveLexLimit of Int where { $_ > limit() };
    ok 1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (1)';
    nok -1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (2)';
}

# RT # 77356
{
    my $limit = 0;
    subset aboveLexVarLimit of Int where { $_ > $limit };
    ok 1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (1)';
    nok -1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (2)';
}

subset Bug::RT80930 of Int where { $_ %% 2 };
lives-ok { my Bug::RT80930 $rt80930 }, 'subset with "::" in the name';

# RT #95500
{
    subset SomeStr of Str where any <foo bar>;
     ok 'foo' ~~ SomeStr, 'subset ... where any(...) (+)';
    nok 'fox' ~~ SomeStr, 'subset ... where any(...) (-)';
}


# RT #65308
#?niecza skip 'Methods must be used in some kind of package'
{
    subset FooStr of Str where /^foo/;
    my multi method uc(FooStr $self:) { return "OH HAI" }; #OK not used
    is "foo".uc, 'FOO', 'multi method with subset invocants do not magically find their way into the method dispatch';

}

# RT #73344
my $a = 1;
{
    my $a = 3;
    sub producer {
        my $a = 2;
        sub bar($x where $a ) { $x }  #OK not used
    }
    my &bar := producer();
    lives-ok { bar(2) }, 'where-constraint picks up the right lexical (+)';
    dies-ok  { bar(1) }, 'where-constraint picks up the right lexical (-)';
}

{
    #RT #113434
    my subset MI of Int;
    ok MI ~~ Mu,   'subset conforms to Mu';
    ok MI ~~ Int,  'subset conforms to base type';
    nok Mu  ~~ MI, 'Mu does not conform to subset';
}

# RT #74352
{
    subset A of Array;
    subset B of A;
    subset C of A;
    subset D of A where B & C;
    ok [] ~~ D, "complicated subset combinations #74352";
}

# RT #126018
lives-ok { EVAL 'my class A { has $.integer where * > 0; method meth { 1 / $!integer } }' },
    'subset constraint in attribute does not blow up optimizer dispatch analysis';

# vim: ft=perl6
