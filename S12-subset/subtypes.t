use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 91;

=begin description

Tests subtypes, specifically in the context of multimethod dispatch.

=end description

# L<S12/"Types and Subtypes">

{
    my $abs = '
    multi sub my_abs (Int $n where { $^n >= 0 }){ $n }
    multi sub my_abs (Int $n where { $^n <  0 }){ -$n }
    ';

    ok(EVAL("$abs; 1"), "we can compile subtype declarations");

    is(EVAL("$abs; my_abs(3)"), 3, "and we can use them, too");
    is(EVAL("$abs; my_abs(-5)"), 5, "and they actually work");
}

{
    my $abs = '
    multi sub another_abs (Int $n where { $_ >= 0 }){ $n }
    multi sub another_abs (Int $n where { $_ <  0 }){ -$n }
    ';

    ok(EVAL("$abs; 1"), "we can compile subtype declarations");

    is(EVAL("$abs; another_abs(3)"), 3, "and we can use them, too");
    is(EVAL("$abs; another_abs(-5)"), 5, "and they actually work");
}

# another nice example
{
    multi factorial (Int $x)          { $x * factorial($x-1) };
    multi factorial (Int $x where 0 ) { 1 };   #OK not used
    is factorial(3), 6, 'subset types refine candidate matches';
}

# Basic subtype creation

{
    subset Int::Odd of Int where { $^num % 2 == 1 };
    is EVAL('my Int::Odd $a = 3'), 3, "3 is an odd num";
    # The EVAL inside the EVAL is/will be necessary to hider our smarty
    # compiler's compile-time from bailing.
    # (Actually, if the compiler is *really* smarty, it will notice our EVAL trick,
    # too :))
    is EVAL('my Int::Odd $b = 3; try { $b = EVAL "4" }; $b'), 3,
      "objects of Int::Odd don't get even";

    # Subtypes should be undefined.
    nok Int::Odd.defined, 'subtypes are undefined';

    # Subs with arguments of a subtype
    sub only_accepts_odds(Int::Odd $odd) { $odd + 1 }
    is only_accepts_odds(3), 4, "calling sub worked";
    dies-ok { only_accepts_odds(4) },  "calling sub did not work";

    # Can smartmatch too
    sub is_num_odd(Int::Odd $odd) { $odd ~~ Int::Odd },
    ok is_num_odd(3), "Int accepted by Int::Odd";
}

# The same, but lexically
{
    my subset Int::Even of Int where { $^num % 2 == 0 }
    ok my Int::Even $c = 6;
    ok $c ~~ Int::Even, "our var is a Int::Even";
    try { $c = 7 }
    is $c, 6, "setting a Int::Even to an odd value dies";
    ok EVAL('!try { my Int::Even $d }'),
        "lexically declared subtype went out of scope";
}

# Following code is evil, but should work:
{
  my Int $multiple_of;
  subset Num::Multiple of Int where { $^num % $multiple_of == 0 }

  $multiple_of = 5;
  ok $multiple_of ~~ Int, "basic sanity (1)";
  is $multiple_of,     5, "basic sanity (2)";

  ok (my Num::Multiple $d = 10), "creating a new Num::Multiple";
  is $d,                   10,   "creating a new Num::Multiple actually worked";
  dies-ok { $d = 7 },            'negative test also works';
  is $d,                   10,   'variable kept previous value';


  $multiple_of = 6;
  dies-ok { my Num::Multiple $e = 10 }, "changed subtype definition worked";
}

# Subsets with custom error messages
{
    my subset Even of Int where { $^num %% 2 or fail "$num is not even" };
    throws-like {
        my Even $e = 1;
    }, Exception, :message("1 is not even"),
    'custom subset errors can be created with fail()';
}

# Rakudo had a bug where 'where /regex/' failed
# https://github.com/Raku/old-issue-tracker/issues/444
#?DOES 2
{
    subset HasA of Str where /a/;
    lives-ok { my HasA $x = 'bla' },   'where /regex/ works (positive)';
    throws-like 'my HasA $x = "foo"', X::TypeCheck::Assignment, 'where /regex/ works (negative)';
}

# You can write just an expression rather than a block after where in a sub
# and it will smart-match it.
{
    sub anon_where_1($x where "x") { 1 }   #OK not used
    sub anon_where_2($x where /x/) { 1 }   #OK not used
    is(anon_where_1('x'), 1,       'where works with smart-matching on string');
    dies-ok({ anon_where_1('y') }, 'where works with smart-matching on string');
    is(anon_where_2('x'), 1,       'where works with smart-matching on regex');
    is(anon_where_2('xyz'), 1,     'where works with smart-matching on regex');
    dies-ok({ anon_where_2('y') }, 'where works with smart-matching on regex');
}

# Block parameter to smart-match is readonly.
{
    subset SoWrong of Str where { $^epic = "fail" }
    sub so_wrong_too($x where { $^epic = "fail" }) { }   #OK not used
    my SoWrong $x;
    dies-ok({ $x = 42 },          'parameter in subtype is read-only...');
    dies-ok({ so_wrong_too(42) }, '...even in anonymous ones.');
}

# ensure that various operations do type cheks

{
    subset AnotherEven of Int where { $_ % 2 == 0 };
    my AnotherEven $x = 2;
    throws-like { $x++ }, X::TypeCheck::Assignment, 'Even $x can not be ++ed';
    is $x, 2,         '..and the value was preserved';
    throws-like { $x-- }, X::TypeCheck::Assignment, 'Even $x can not be --ed';
    is $x, 2,         'and the value was preserved';
}

{
    # chained subset types
    subset Positive of Int where { $_ > 0 };
    subset NotTooLarge of Positive where { $_ < 10 };

    my NotTooLarge $x;

    lives-ok { $x = 5 }, 'can satisfy both conditions on chained subset types';
    dies-ok { $x = -2 }, 'violating first condition barfs';
    dies-ok { $x = 22 }, 'violating second condition barfs';
}


# subtypes based on user defined classes and roles
{
    class C1 { has $.a }
    subset SC1 of C1 where { .a == 42 }
    ok !(C1.new(a => 1) ~~ SC1), 'subtypes based on classes work';
    ok C1.new(a => 42) ~~ SC1,   'subtypes based on classes work';
}

{
    role R1 { };
    subset SR1 of R1 where 1;
    ok !(1 ~~ SR1), 'subtypes based on roles work';
    my $x = 1 but R1;
    ok $x ~~ SR1,   'subtypes based on roles work';
}

subset NW1 of Int;
ok NW1 ~~ Int,  'subset declaration without where clause does type it refines';
ok 0 ~~ NW1,    'subset declaration without where clause accepts right value';
ok 42 ~~ NW1,   'subset declaration without where clause accepts right value';
ok 4.2 !~~ NW1, 'subset declaration without where clause rejects wrong value';
ok "x" !~~ NW1, 'subset declaration without where clause rejects wrong value';

# https://github.com/Raku/old-issue-tracker/issues/999
{
    subset Small of Int where { $^n < 10 }
    class RT65700 {
        has Small $.small;
    }
    dies-ok { RT65700.new( small => 20 ) }, 'subset type is enforced as attribute in new() (1)';
    lives-ok { RT65700.new( small => 2 ) }, 'subset type enforced as attribute in new() (2)';

    my subset Teeny of Int where { $^n < 10 }
    class T { has Teeny $.teeny }
    dies-ok { T.new( teeny => 20 ) }, 'my subset type is enforced as attribute in new() (1)';
    lives-ok { T.new( teeny => 2 ) }, 'my subset type enforced as attribute in new() (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2221
{
    my @*rt78318;
    subset Bug  of Int where { @*rt78318.push( 'bug' ) };
    subset Hunt of Bug where { @*rt78318.push( 'hunt' ) };
    78318 ~~ Hunt;
    is @*rt78318, <bug hunt>, 'code called when subtype built on subtype';
}

# https://github.com/Raku/old-issue-tracker/issues/2222
{
    my $*call1;
    my $*call2;

    $*call1 = 0;$*call2 = 0;

    subset RT78322 of Int     where { $*call1++; $^a == 78322 };
    subset Bughunt of RT78322 where { $*call2++; ?1 };

    $*call1 = 0;$*call2 = 0;
    nok 22 ~~ RT78322, 'level one subset check is false';
    is $*call1, 1, 'level one subset checked (should fail)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    nok 22 ~~ Bughunt, 'overall subset check is false';
    is $*call1, 1, 'level one subset checked (should fail)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    ok 78322 ~~ RT78322, 'level one subset check is true';
    is $*call1, 1, 'level one subset checked (should succeed)';
    is $*call2, 0, 'level two subset not checked';

    $*call1 = 0;$*call2 = 0;
    ok 78322 ~~ Bughunt, 'overall subset check is true';
    is $*call1, 1, 'level one subset checked (should succeed)';
    is $*call2, 1, 'level two subset checked (should succeed)';
}

{
    role R { };
    subset S of R;
    # https://github.com/Raku/old-issue-tracker/issues/1815
    nok 1 ~~ S, 'subsets of roles (1)';
     ok R ~~ S, 'subsets of roles (2)';

    ok (R ~~ S) ~~ Bool, 'smart-matching a subset returns a Bool (1)';
    ok (S ~~ R) ~~ Bool, 'smart-matching a subset returns a Bool (2)';
}


# https://github.com/Raku/old-issue-tracker/issues/2421
{
    subset Many::Parts of Str;
    ok 'a' ~~ Many::Parts, 'subset names with many parts work';
}

{
    subset Int::Positive of Int where { $_ > 0 };
    sub f(Int::Positive $a) { $a * $a };
    dies-ok { EVAL('f(-2)') }, 'Cannot violate Int::Positive constraint';
}

# https://github.com/Raku/old-issue-tracker/issues/6279
{
    subset PInt of Int where { $_ > 0 };
    my PInt @a = 2, 3;
    sub f(PInt @a) { 1; }
    #?rakudo todo 'Parameterized subs do not take Array of subset types'
    lives-ok { f(@a) }, 'Array of subset type as parameter to function';
}

# https://github.com/Raku/old-issue-tracker/issues/1468
{
    subset Interesting of Int where * > 10;
    class AI { has Interesting $.x };
    try { EVAL 'AI.new(x => 2)' };
    ok $!.Str ~~ /Interesting/, 'error message mentions subset name';

}

# https://github.com/Raku/old-issue-tracker/issues/2254
{
    my Str subset MyStr;
    ok MyStr ~~ Str, 'my str subset MyStr creates basically a type alias (1)';
    ok 'foo' ~~ MyStr, 'my str subset MyStr creates basically a type alias (2)';
    ok 2    !~~ MyStr, 'Ints are not in there';
}

# https://github.com/Raku/old-issue-tracker/issues/1526
{
    try { EVAL 'sub foo($x where { $x == $y }, $y) { }' };
    isa-ok $!, X::Undeclared, 'subset in signature cannot use non-predeclared variable';
}

# https://github.com/Raku/old-issue-tracker/issues/3661
{
    throws-like q[
        subset Tiny of Any where ^3;
        my Tiny $foo;
        $foo = 42; say $foo;
    ],
    X::TypeCheck, 'code dies with right exception';

    is_run q[
        subset Tiny of Any where {say $_; $_ ~~ ^3};
        my Tiny $foo;
        $foo = 0; say $foo;
    ],
    {
        status => 0,
        out    => rx/^ 0 \n 0 \n $/,
        err    => '',
    },
    'code runs without error (and does not mention "Obsolete"!)';
}

# https://github.com/Raku/old-issue-tracker/issues/5092
{
    my subset JJ where { !.defined || $_ > 2 };

    dies-ok { -> JJ:D $a { }(Int) }, 'ASubType:D dies if passed type object';
    dies-ok { -> JJ:D $a { }(2) }, 'ASubType:D dies if passed non-matching concrete value';
    is (-> JJ:D $a { 'yup' }(3)), 'yup', 'ASubType:D passes if passed matching concrete value';
}

# https://github.com/Raku/old-issue-tracker/issues/5086
group-of 2 => 'multi with :D subset dispatches correctly' => {
    my @results;
    lives-ok {
        subset T127367 of List where *[0] eqv 1;
        class R127367 {
            multi method f(T127367:D $xs) { @results.push('T:D'); self.f(42) }
            multi method f(Any:D $xs) { @results.push: $xs }
        }
        R127367.f([1, 2]);
        R127367.f([2, 2]);
    }, 'dispatch does not die';
    is-deeply @results, ['T:D', 42, [2, 2]], 'dispatch happened in right order';
}

# https://github.com/Raku/old-issue-tracker/issues/5701
{
    sub f(|c where { c.elems == 1 }) { 72 }
    is-deeply f(42), 72, 'where constraint on |c parameter works';
    throws-like { f() }, X::TypeCheck::Binding::Parameter,
        'where constraint on |c parameter is enforced';
}

# https://github.com/Raku/old-issue-tracker/issues/4748
{
    multi f(UInt:D $) { "ok" };
    is f(42), 'ok', "UInt:D parameter doesn't fail in a multi";
}

# https://github.com/rakudo/rakudo/commit/43b9c82945
subtest '"any" Junction of types in where' => {
    plan 3;
    subtest 'routine sig' => {
        plan 22;
        my \EXB := X::TypeCheck::Binding::Parameter;
        my \EXC := X::Parameter::InvalidConcreteness;
        my &b1 := ->        $x where Int|Num           { ($x//2)² };
        my &b2 := -> Cool   $x where Int|Num:D         { ($x//2)² };
        my &b3 := -> Cool:D $x where Int:U|Num:D|Rat:D { ($x//2)² };
        my &b4 := -> Numeric(Cool) $x where Int:U|Num:D|Rat:D { ($x//2)² };

        throws-like ｢b1 "x"｣,  EXB, 'rejected by where, type';
        throws-like ｢b1 2.2｣,  EXB, 'rejected by where, type (2)';
        throws-like ｢b2 2.2｣,  EXB, 'rejected by where, type (3)';
        throws-like ｢b4 i｣,    EXB, 'rejected by where, type (4)';
        throws-like ｢b2 Num｣,  EXB, 'rejected by where, definiteness';
        throws-like ｢b4 Num｣,  EXB, 'rejected by where, definiteness (2)';
        throws-like ｢b3 42｣,   EXB, 'rejected by where, definiteness (3)';
        throws-like ｢b2 $*VM｣, EXB, 'rejected by type, type';
        throws-like ｢b3 Num｣,  EXC, 'rejected by type, definiteness';
        throws-like ｢b4 Any｣,  EXB, 'rejected by coercer, source type';
        throws-like ｢b4 "x"｣,  EXB, 'rejected by coercer, target type';

        is-deeply b1(4),     16,   'accepted (1)';
        is-deeply b1(5e0),   25e0, 'accepted (2)';

        is-deeply b2(4),     16,   'accepted (3)';
        is-deeply b2(Int),   4,    'accepted (4)';
        is-deeply b2(5e0),   25e0, 'accepted (5)';

        is-deeply b3(5e0),   25e0, 'accepted (6)';
        is-deeply b3(5.0),   25.0, 'accepted (7)';

        is-deeply b4("4e0"), 16e0, 'accepted (8)';
        is-deeply b4("4.0"), 16.0, 'accepted (9)';
        is-deeply b4(4e0),   16e0, 'accepted (10)';
        is-deeply b4(4.0),   16.0, 'accepted (11)';
    }

    subtest 'variables' => {
        plan 14;
        my \EXA := X::TypeCheck::Assignment;
        my        $x1 where Int|Num;
        my Cool   $x2 where Int|Num:D;
        my Cool:D $x3 where Int:U|Num:D|Rat:D;

        throws-like { $x1 = "x"  }, EXA, 'rejected by where, type';
        throws-like { $x1 = 2.2  }, EXA, 'rejected by where, type (2)';
        throws-like { $x2 = 2.2  }, EXA, 'rejected by where, type (3)';
        throws-like { $x2 = Num  }, EXA, 'rejected by where, definiteness';
        throws-like { $x3 = 42   }, EXA, 'rejected by where, definiteness (3)';
        throws-like { $x2 = $*VM }, EXA, 'rejected by type, type';
        throws-like { $x3 = Num  }, EXA, 'rejected by type, definiteness';

        is-deeply ($x1 = 4),   4,   'accepted (1)';
        is-deeply ($x1 = 5e0), 5e0, 'accepted (2)';

        is-deeply ($x2 = 4),   4,   'accepted (3)';
        is-deeply ($x2 = Int), Int, 'accepted (4)';
        is-deeply ($x2 = 5e0), 5e0, 'accepted (5)';

        is-deeply ($x3 = 5e0), 5e0, 'accepted (6)';
        is-deeply ($x3 = 5.0), 5.0, 'accepted (7)';
    }

    subtest 'subset' => {
        plan 14;
        my subset B1           where   Int|Num;
        my subset B2 of Cool   where   Int|Num:D;
        my subset B3 of Cool:D where Int:U|Num:D|Rat:D;

        is "x"  ~~ B1, False, 'rejected by where, type';
        is 2.2  ~~ B1, False, 'rejected by where, type (2)';
        is 2.2  ~~ B2, False, 'rejected by where, type (3)';
        is Num  ~~ B2, False, 'rejected by where, definiteness';
        is 42   ~~ B3, False, 'rejected by where, definiteness (3)';
        is $*VM ~~ B2, False, 'rejected by type, type';
        is Num  ~~ B3, False, 'rejected by type, definiteness';

        is 4    ~~ B1, True,  'accepted (1)';
        is 5e0  ~~ B1, True,  'accepted (2)';

        is 4    ~~ B2, True,  'accepted (3)';
        is Int  ~~ B2, True,  'accepted (4)';
        is 5e0  ~~ B2, True,  'accepted (5)';

        is 5e0  ~~ B3, True,  'accepted (6)';
        is 5.0  ~~ B3, True,  'accepted (7)';
    }
}

subtest 'postconstraints on variables in my (...)' => {
    plan 6;

    my subset Foo where .is-prime;
    my ($a where 2, $b where Int, \c where "x", Foo $d, "foo")
    = 2, 4, "x", 7, "foo";
    is-deeply $a, 2,   'stored $a';
    is-deeply $b, 4,   'stored $b';
    is-deeply  c, "x", 'stored b';
    is-deeply $d, 7,   'stored $d';

    my \XA = X::TypeCheck::Assignment;
    subtest 'single-arg' => {
        plan 5;
        throws-like ｢my ($ where 2)  = 3｣,     XA, 'anon where literal';
        throws-like ｢my ($a where 2) = 3｣,     XA, 'where literal';
        throws-like ｢my ($b where Int) = .1｣,  XA, 'where type';
        throws-like ｢my (\b where "x") = "y"｣, XA, 'sigilless where literal';
        throws-like ｢my ("foo") = "bar"｣,      XA, 'literal';
    }
    subtest 'multi-arg' => {
        plan 5;
        throws-like ｢my ($ where 2, $b where Int ) = 3, 4｣,  XA,
            'anon where literal';
        throws-like ｢my ($a where 2, $b where Int) = 3, .1｣, XA,
            'where literal';
        throws-like ｢my ($a where 2, $b where Int) = 3, .1｣, XA,
            'where type';
        throws-like ｢my (\b where "x", "foo") = "y", "foo"｣, XA,
            'sigilless where literal';
        throws-like ｢my (\b where "x", "foo") = "x", "bar"｣, XA, 'literal';
    }
}

# https://github.com/Raku/roast/issues/650
group-of 6 => '`&`- sigiled variable be used in where' => {
    my $wanted;
    sub pos-match               { $wanted = $^got; True  }
    sub neg-match               { $wanted = $^got; False }
    my &pos-match-block =       { $wanted = $^got; True  }
    my &neg-match-block =       { $wanted = $^got; False }
    my &pos-match-wat   = *.map({ $wanted = $^got; True  }).head;
    my &neg-match-wat   = *.map({ $wanted = $^got; False }).head;

    group-of 12 => 'subset' => {
        $wanted = Nil;

        my subset PosSubset where &pos-match;
        my subset NegSubset where &neg-match;
        ok  42 ~~ PosSubset,   'pos';
        is-deeply $wanted, 42, 'pos arg';
        nok 73 ~~ NegSubset,   'neg';
        is-deeply $wanted, 73, 'neg arg';

        my subset PosSubsetB where &pos-match-block;
        my subset NegSubsetB where &neg-match-block;
        ok  42 ~~ PosSubsetB,  'pos block';
        is-deeply $wanted, 42, 'pos arg block';
        nok 73 ~~ NegSubsetB,  'neg block';
        is-deeply $wanted, 73, 'neg arg block';

        my subset PosSubsetW where &pos-match-wat;
        my subset NegSubsetW where &neg-match-wat;
        ok  42 ~~ PosSubsetW,  'pos Whatever';
        is-deeply $wanted, 42, 'pos arg Whatever';
        nok 73 ~~ NegSubsetW,  'neg Whatever';
        is-deeply $wanted, 73, 'neg arg Whatever';
    }

    group-of 12 => 'my' => {
        $wanted = Nil;

        my $pos where &pos-match = 42;
        is-deeply $pos,    42, 'pos';
        is-deeply $wanted, 42, 'pos arg';
        throws-like { my $z where &neg-match = 73 },
            X::TypeCheck::Assignment, 'neg';
        is-deeply $wanted, 73, 'neg arg';

        my $pos-b where &pos-match-block = 42;
        is-deeply $pos-b,  42, 'pos block';
        is-deeply $wanted, 42, 'pos arg block';
        throws-like { my $z-b where &neg-match-block = 73 },
            X::TypeCheck::Assignment, 'neg block';
        is-deeply $wanted, 73, 'neg arg block';

        my $pos-w where &pos-match-wat = 42;
        is-deeply $pos-w,  42, 'pos Whatever';
        is-deeply $wanted, 42, 'pos arg Whatever';
        throws-like { my $z-w where &neg-match-wat = 73 },
            X::TypeCheck::Assignment, 'neg Whatever';
        is-deeply $wanted, 73,  'neg arg Whatever';
    }

    group-of 12 => 'sub signature, simple' => {
        $wanted = Nil;

        sub test-pos ($x where &pos-match)
          { is-deeply $x, 42, "sub called with right arg value [sub]" }
        sub test-neg ($ where &neg-match)
          { flunk "sub should not be called [sub]" }
        test-pos 42;
        is-deeply $wanted, 42, 'pos arg';
        throws-like { test-neg 73 }, X::TypeCheck, 'neg';
        is-deeply $wanted, 73, 'neg arg';

        sub test-pos-block ($x where &pos-match-block)
          { is-deeply $x, 42, "sub called with right arg value [block]" }
        sub test-neg-block ($ where &neg-match-block)
          { flunk "sub should not be called [block]" }
        test-pos-block 42;
        is-deeply $wanted, 42, 'pos arg block';
        throws-like { test-neg-block 73 }, X::TypeCheck, 'neg block';
        is-deeply $wanted, 73, 'neg arg block';

        sub test-pos-wat ($x where &pos-match-wat)
          { is-deeply $x, 42, "sub called with right arg value [Whatever]" }
        sub test-neg-wat ($ where &neg-match-wat)
          { flunk "sub should not be called [Whatever]" }
        test-pos-wat 42;
        is-deeply $wanted, 42, 'pos arg wat';
        throws-like { test-neg-wat 73 }, X::TypeCheck, 'neg wat';
        is-deeply $wanted, 73, 'neg arg wat';
    }

    group-of 12 => 'sub signature, multi-dispatch' => {
        $wanted = Nil;

        multi test-pos ($x where &pos-match)
          { is-deeply $x, 42, "sub called with right arg value [sub]" }
        multi test-pos (Str $)
          { flunk "wrong multi candidate must not be called [sub]" }
        multi test-neg ($ where &neg-match)
          { flunk "wrong multi candidate 1 must not be called [sub]" }
        multi test-neg (Str $)
          { flunk "wrong multi candidate 2 must not be called [sub]" }
        test-pos 42;
        is-deeply $wanted, 42, 'pos arg';
        is &test-neg.cando(\(73)).elems, 0, 'neg';
        is-deeply $wanted, 73, 'neg arg';

        multi test-pos-block ($x where &pos-match-block)
          { is-deeply $x, 42, "sub called with right arg value [block]" }
        multi test-pos-block (Str $)
          { flunk "wrong multi candidate must not be called [block]" }
        multi test-neg-block ($ where &neg-match-block)
          { flunk "wrong multi candidate 1 must not be called [block]" }
        multi test-neg-block (Str $)
          { flunk "wrong multi candidate 2 must not be called [block]" }
        test-pos-block 42;
        is-deeply $wanted, 42, 'pos arg block';
        is &test-neg-block.cando(\(73)).elems, 0, 'neg block';
        is-deeply $wanted, 73, 'neg arg block';

        multi test-pos-wat ($x where &pos-match-wat)
          { is-deeply $x, 42, "sub called with right arg value [Whatever]" }
        multi test-pos-wat (Str $)
          { flunk "wrong multi candidate must not be called [Whatever]" }
        multi test-neg-wat ($ where &neg-match-wat)
          { flunk "wrong multi candidate 1 must not be called [Whatever]" }
        multi test-neg-wat (Str $)
          { flunk "wrong multi candidate 2 must not be called [Whatever]" }
        test-pos-wat 42;
        is-deeply $wanted, 42, 'pos arg Whatever';
        is &test-neg-wat.cando(\(73)).elems, 0, 'neg Whatever';
        is-deeply $wanted, 73, 'neg arg Whatever';
    }

    group-of 21 => 'method signature, fancy' => {
        $wanted = Nil;

        my class Foo {
            method test-pos ($, $x where &pos-match, *@)
              { is-deeply $x, 42, "method called w/right arg val [sub]" }
            method test-neg ($, $ where &neg-match, *@)
              { flunk "method should not be called [sub]" }
            method test-wild (
              *@ ($x where &pos-match, *@ ($, $, $, $y where &pos-match, *@))
            ) {
                is-deeply $x, 42, 'method called w/right val in $x [sub]';
                is-deeply $y, 52, 'method called w/right val in $y [sub]';
            }
        }
        Foo.test-pos: Nil, 42, ^100;
        is-deeply $wanted, 42, 'pos arg';
        throws-like { Foo.test-neg: Nil, 73, ^100 }, X::TypeCheck, 'neg';
        is-deeply $wanted, 73, 'neg arg';
        Foo.test-wild: 42, 99, 70, 10, 52, ^100;
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|52, 'pos arg in wild method';

        $wanted = Nil;
        my class FooB {
            method test-pos ($, $x where &pos-match-block, *@)
              { is-deeply $x, 42, "method called w/right arg val [block]" }
            method test-neg ($, $ where &neg-match-block, *@)
              { flunk "method should not be called [block]" }
            method test-wild (
              *@ ($x where &pos-match-block,
                *@ ($, $, $, $y where &pos-match-block, *@))
            ) {
                is-deeply $x, 42, 'method called w/right val in $x [block]';
                is-deeply $y, 52, 'method called w/right val in $y [block]';
            }
        }
        FooB.test-pos: Nil, 42, ^100;
        is-deeply $wanted, 42, 'pos arg block';
        throws-like { FooB.test-neg: Nil, 73, ^100 }, X::TypeCheck, 'neg block';
        is-deeply $wanted, 73, 'neg arg block';
        FooB.test-wild: 42, 99, 70, 10, 52, ^100;
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|52, 'pos arg in wild method block';

        $wanted = Nil;
        my class FooWat {
            method test-pos ($, $x where &pos-match-wat, *@)
              { is-deeply $x, 42, "method called w/right arg val [Whatever]" }
            method test-neg ($, $ where &neg-match-wat, *@)
              { flunk "method should not be called [Whatever]" }
            method test-wild (
              *@ ($x where &pos-match-wat,
                *@ ($, $, $, $y where &pos-match-wat, *@))
            ) {
                is-deeply $x, 42, 'method called w/right val in $x [Whatever]';
                is-deeply $y, 52, 'method called w/right val in $y [Whatever]';
            }
        }
        FooWat.test-pos: Nil, 42, ^100;
        is-deeply $wanted, 42, 'pos arg Whatever';
        throws-like { FooB.test-neg: Nil, 73, ^100 },
            X::TypeCheck, 'neg Whatever';
        is-deeply $wanted, 73, 'neg arg Whatever';
        FooWat.test-wild: 42, 99, 70, 10, 52, ^100;
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|52, 'pos arg in wild method Whatever';
    }

    group-of 6 => 'detached signature object' => {
        $wanted = Nil;

        ok \(Nil, 42, 50, :73y)
          ~~ :($, $x where &pos-match, *@, *% (:$y where &pos-match)),
          'sig matches capture [sub]';
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|73, 'pos arg [sub]';

        $wanted = Nil;
        ok \(Nil, 42, 50, :73y) ~~
          :($, $x where &pos-match-block, *@, *% (:$y where &pos-match-block)),
          'sig matches capture [block]';
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|73, 'pos arg [block]';

        $wanted = Nil;
        ok \(Nil, 42, 50, :73y) ~~
          :($, $x where &pos-match-wat, *@, *% (:$y where &pos-match-wat)),
          'sig matches capture [Whatever]';
        # we do not spec in what order the `where` classes are called, so
        # check for both $x or $y values
        cmp-ok $wanted, '~~', 42|73, 'pos arg [Whatever]';
    }
}

# vim: expandtab shiftwidth=4
