use v6.d;
use Test;
plan 25;

# Clarifications to specification of constants introduced in 6.d language.
# Many of these were added as part of the CaR TPF Grant:
# http://news.perlfoundation.org/2018/04/grant-proposal-perl-6-bugfixin.html

diag ｢
  Permutated parts:
  [declarator]:       implied/my/our
  [type]:             implied / plain / with `::` in name / Foo::Bar[Ber::Meow] format
  [sigil]:            sigilless, backslashed sigilles, $, @, %, &

  Additional tested parts in each test or separate subtest:
  [initializer op]:   = / := / .=
  [value]: simple / list (without parentheses) / statement / failing typecheck
  [containerization]: must not occur / must be impossible to bind new value after definition
｣;

# dummy classes with `::` in their names we'll use in a bunch of tests below as well as a string
# to define the same inside evaled strings:
role Foo::Bar[::T] {}
class Ber::Meow    {}
my \ClassDefs := ｢my role Foo2::Bar2[::T] {}; my class Ber2::Meow2 {}; ｣;

##
## Sigilless
##

subtest 'implied | implied | sigilless' => {
    plan 5;
    constant  iis1 = 42;
    is-deeply iis1, 42, 'def, simple value';
    constant  iis2 = 1, 2, 3;
    is-deeply iis2, (1, 2, 3), 'def, List';
    for iis2 { is-deeply $_, iis2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant iis3 = do { %(:foo, :bar) };
        is-deeply iis3, %(:foo, :bar), 'def, statement';
    }
    ok ::('iis3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | sigilless' => {
    plan 5;
    my constant mis1 = 42;
    is-deeply mis1, 42, 'def, simple value';
    my constant mis2 = 1, 2, 3;
    is-deeply mis2, (1, 2, 3), 'def, List';
    for mis2 { is-deeply $_, mis2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant mis3 = do { %(:foo, :bar) };
        is-deeply mis3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mis3'), '`my` makes constants lexical';
}

subtest 'our | implied | sigilless' => {
    plan 5;
    our constant ois1 = 42;
    is-deeply ois1, 42, 'def, simple value';
    our constant ois2 = 1, 2, 3;
    is-deeply ois2, (1, 2, 3), 'def, List';
    for ois2 { is-deeply $_, ois2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant ois3 = do { %(:foo, :bar) };
        is-deeply ois3, %(:foo, :bar), 'def, statement';
    }
    ok ::('ois3'), '`our` gives right scope';
}

subtest 'my | typed | sigilless' => {
    plan 9;
    my Int constant mts1 = 42;
    is-deeply mts1, 42, 'def, simple value';
    my List constant mts2 = 1, 2, 3;
    is-deeply mts2, (1, 2, 3), 'def, List';
    for mts2 { is-deeply $_, mts2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant mts3 = do { %(:foo, :bar) };
        is-deeply mts3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mts3'), '`my` makes constants lexical';

    my IO::Path constant mts4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply mts4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant mts5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant mts6 = Foo::Bar[Ber::Meow].new;
    is-deeply mts6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mts7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | sigilless' => {
    plan 9;
    our Int constant ots1 = 42;
    is-deeply ots1, 42, 'def, simple value';
    our List constant ots2 = 1, 2, 3;
    is-deeply ots2, (1, 2, 3), 'def, List';
    for ots2 { is-deeply $_, ots2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant ots3 = do { %(:foo, :bar) };
        is-deeply ots3, %(:foo, :bar), 'def, statement';
    }
    ok ::('ots3'), '`our` gives right scope';

    our IO::Path constant ots4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply ots4, '.'.IO, 'type with `::` in name';
    throws-like ｢our IO::Path constant ots5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant ots6 = Foo::Bar[Ber::Meow].new;
    is-deeply ots6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant ots7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

##
## Backslashed Sigilless
##

subtest 'implied | implied | backslashed sigilless' => {
    plan 5;
    constant  \iibs1 = 42;
    is-deeply  iibs1, 42, 'def, simple value';
    constant  \iibs2 = 1, 2, 3;
    is-deeply  iibs2, (1, 2, 3), 'def, List';
    for iibs2 { is-deeply $_, iibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant \iibs3 = do { %(:foo, :bar) };
        is-deeply iibs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('iibs3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | backslashed sigilless' => {
    plan 5;
    my constant \mibs1 = 42;
    is-deeply mibs1, 42, 'def, simple value';
    my constant \mibs2 = 1, 2, 3;
    is-deeply mibs2, (1, 2, 3), 'def, List';
    for mibs2 { is-deeply $_, mibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant \mibs3 = do { %(:foo, :bar) };
        is-deeply mibs3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mibs3'), '`my` makes constants lexical';
}

subtest 'our | implied | backslashed sigilless' => {
    plan 5;
    our constant \oibs1 = 42;
    is-deeply oibs1, 42, 'def, simple value';
    our constant \oibs2 = 1, 2, 3;
    is-deeply oibs2, (1, 2, 3), 'def, List';
    for oibs2 { is-deeply $_, oibs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant \oibs3 = do { %(:foo, :bar) };
        is-deeply oibs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('oibs3'), '`our` gives right scope';
}

subtest 'my | typed | backslashed sigilless' => {
    plan 9;
    my Int constant \mtbs1 = 42;
    is-deeply mtbs1, 42, 'def, simple value';
    my List constant \mtbs2 = 1, 2, 3;
    is-deeply mtbs2, (1, 2, 3), 'def, List';
    for mtbs2 { is-deeply $_, mtbs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant \mtbs3 = do { %(:foo, :bar) };
        is-deeply mtbs3, %(:foo, :bar), 'def, statement';
    }
    nok ::('mtbs3'), '`my` makes constants lexical';

    my IO::Path constant \mtbs4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply mtbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant mtbs5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant \mtbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply mtbs6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant mtbs7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | backslashed sigilless' => {
    plan 9;
    our Int constant \otbs1 = 42;
    is-deeply otbs1, 42, 'def, simple value';
    our List constant \otbs2 = 1, 2, 3;
    is-deeply otbs2, (1, 2, 3), 'def, List';
    for otbs2 { is-deeply $_, otbs2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant \otbs3 = do { %(:foo, :bar) };
        is-deeply otbs3, %(:foo, :bar), 'def, statement';
    }
    ok ::('otbs3'), '`our` gives right scope';

    our IO::Path constant \otbs4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply otbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant otbs5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant \otbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply otbs6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant otbs7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
}

##
## $-sigilled
##

subtest 'implied | implied | $-sigilled' => {
    plan 5;
    constant  $iiss1 = 42;
    is-deeply $iiss1, 42, 'def, simple value';
    constant  $iiss2 = 1, 2, 3;
    is-deeply $iiss2, (1, 2, 3), 'def, List';
    for $iiss2 { is-deeply $_, $iiss2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        constant  $iiss3 = do { %(:foo, :bar) };
        is-deeply $iiss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$iiss3'), 'implied scope declarator behaves like `our`';
}

subtest 'my | implied | $-sigilled' => {
    plan 5;
    my constant $miss1 = 42;
    is-deeply $miss1, 42, 'def, simple value';
    my constant $miss2 = 1, 2, 3;
    is-deeply $miss2, (1, 2, 3), 'def, List';
    for $miss2 { is-deeply $_, $miss2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my constant $miss3 = do { %(:foo, :bar) };
        is-deeply $miss3, %(:foo, :bar), 'def, statement';
    }
    nok ::('$miss3'), '`my` makes constants lexical';
}

subtest 'our | implied | $-sigilled' => {
    plan 5;
    our constant $oiss1 = 42;
    is-deeply $oiss1, 42, 'def, simple value';
    our constant $oiss2 = 1, 2, 3;
    is-deeply $oiss2, (1, 2, 3), 'def, List';
    for $oiss2 { is-deeply $_, $oiss2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our constant $oiss3 = do { %(:foo, :bar) };
        is-deeply $oiss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$oiss3'), '`our` gives right scope';
}

subtest 'my | typed | $-sigilled' => {
    plan 9;
    my Int constant $mtss1 = 42;
    is-deeply $mtss1, 42, 'def, simple value';
    my List constant $mtss2 = 1, 2, 3;
    is-deeply $mtss2, (1, 2, 3), 'def, List';
    for $mtss2 { is-deeply $_, $mtss2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        my Hash constant $mtss3 = do { %(:foo, :bar) };
        is-deeply $mtss3, %(:foo, :bar), 'def, statement';
    }
    nok ::('$mtss3'), '`my` makes constants lexical';

    my IO::Path constant $mtss4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply $mtss4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant $mtss5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant $mtss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $mtss6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant $mtss7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

subtest 'our | typed | $-sigilled' => {
    plan 9;
    our Int constant $otss1 = 42;
    is-deeply $otss1, 42, 'def, simple value';
    our List constant $otss2 = 1, 2, 3;
    is-deeply $otss2, (1, 2, 3), 'def, List';
    for $otss2 { is-deeply $_, $otss2.head, 'does not containerize'; last }
    { # add a scope to check scope declarator works right
        our Hash constant $otss3 = do { %(:foo, :bar) };
        is-deeply $otss3, %(:foo, :bar), 'def, statement';
    }
    ok ::('$otss3'), '`our` gives right scope';

    our IO::Path constant $otss4 = '.'.IO;
    #?rakudo.js.browser todo "the cwd doesn't make much sense in the browser"
    is-deeply $otss4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path constant $otss5 = 42｣, X::TypeCheck,
        'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant $otss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $otss6, Foo::Bar[Ber::Meow].new,
        'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant $otss7 = 42｣,
        X::TypeCheck, 'parametarized type with `::` in name (failure mode)';
}

##
## @-sigilled
##

subtest 'implied | implied | @-sigilled' => {
    plan 13;
    constant  @iias1 = 42;
    is-deeply @iias1, (42,), 'def, simple value';
    constant  @iias2 = 1, 2, 3;
    is-deeply @iias2, (1, 2, 3), 'def, List (no parens)';
    constant  @iias3 = (1, 2, 3);
    is-deeply @iias3, (1, 2, 3), 'def, List (with parens)';
    for @iias3 { is-deeply $_, @iias3.head, 'does not scalarize'; last }

    constant  @iias4 = [1, 2, 3];
    is-deeply @iias4, [1, 2, 3], 'Array remains an Array';
    constant  @iias5 = (1, 2, 3).Seq;
    is-deeply @iias5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        constant  @iias6 = do { %(:foo, :bar) };
        isa-ok    @iias6, List, 'def, statement (type)';
        is-deeply @iias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    ok ::('@iias6'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        my class Foo {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        constant @iias7 = Foo.new;
        is-deeply @iias7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        constant @iias8 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        constant @iias9 = Bar.new;
        isa-ok @iias9, Bar, 'no coercion of custom Positionals';
    ｣;
}

subtest 'my | implied | @-sigilled' => {
    plan 13;
    my constant @mias1 = 42;
    is-deeply   @mias1, (42,), 'def, simple value';
    my constant @mias2 = 1, 2, 3;
    is-deeply   @mias2, (1, 2, 3), 'def, List (no parens)';
    my constant @mias3 = (1, 2, 3);
    is-deeply   @mias3, (1, 2, 3), 'def, List (with parens)';
    for @mias3 { is-deeply $_, @mias3.head, 'does not scalarize'; last }

    my constant @mias4 = [1, 2, 3];
    is-deeply   @mias4, [1, 2, 3], 'Array remains an Array';
    my constant @mias5 = (1, 2, 3).Seq;
    is-deeply   @mias5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        my constant @mias6 = do { %(:foo, :bar) };
        isa-ok      @mias6, List, 'def, statement (type)';
        is-deeply   @mias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    nok ::('@mias6'), '`my` makes constants lexical';

    EVAL ｢
        my class Foo {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        my constant @mias7 = Foo.new;
        is-deeply @mias7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        my constant @mias8 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        my constant @mias9 = Bar.new;
        isa-ok @mias9, Bar, 'no coercion of custom Positionals';
    ｣;
}

subtest 'our | implied | @-sigilled' => {
    plan 13;
    our constant @oias1 = 42;
    is-deeply    @oias1, (42,), 'def, simple value';
    our constant @oias2 = 1, 2, 3;
    is-deeply    @oias2, (1, 2, 3), 'def, List (no parens)';
    our constant @oias3 = (1, 2, 3);
    is-deeply    @oias3, (1, 2, 3), 'def, List (with parens)';
    for @oias3 { is-deeply $_, @oias3.head, 'does not scalarize'; last }

    our constant @oias4 = [1, 2, 3];
    is-deeply    @oias4, [1, 2, 3], 'Array remains an Array';
    our constant @oias5 = (1, 2, 3).Seq;
    is-deeply    @oias5, (1, 2, 3), 'Seq gets coerced';

    { # add a scope to check scope declarator works right
        our constant @oias6 = do { %(:foo, :bar) };
        isa-ok    @oias6, List, 'def, statement (type)';
        is-deeply @oias6.sort, (:foo, :bar).sort, 'def, statement (value)';
    }
    ok ::('@oias6'), '`our` gives right scope';

    EVAL ｢
        my class Foo {
            method cache {
                pass 'coercion calls .cache method';
                42,
            }
        }
        our constant @oias7 = Foo.new;
        is-deeply @oias7, (42,), 'right result after coersion';
    ｣;

    throws-like ｢
        my class Foo { method cache { 42 } }
        our constant @oias8 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .cache does not return Positional';

    EVAL ｢
        my class Bar does Positional {
            method cache { flunk 'called .cache on an already-Positional' }
        }
        our constant @oias9 = Bar.new;
        isa-ok @oias9, Bar, 'no coercion of custom Positionals';
    ｣;
}

subtest 'my | typed | @-sigilled' => {
    plan 4;
    throws-like ｢my Int constant @mtas1 = 42;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢my List constant @mtas2 = 1, 2, 3;｣,
        X::ParametricConstant, 'list';
    throws-like ｢my IO::Path constant @mtas5 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant @mtas7 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

subtest 'our | typed | @-sigilled' => {
    plan 4;
    throws-like ｢our Int constant @otas1 = 42;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢our List constant @otas2 = 1, 2, 3;｣,
        X::ParametricConstant, 'list';
    throws-like ｢our IO::Path constant @otas5 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant @otas7 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

##
## %-sigilled
##

subtest 'implied | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        constant %iihs0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    constant  %iihs1 = 1, 2, 3, 4;
    is-deeply %iihs1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    constant  %iihs2 = :42foo, :70bar;
    is-deeply %iihs2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    constant  %iihs3 = (:42foo, :70bar);
    is-deeply %iihs3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    constant  %iihs4 = Map.new: (:42foo, :70bar);
    is-deeply %iihs4, Map.new((:42foo, :70bar)), 'def, Map';
    for %iihs4 { isa-ok $_, Pair, 'does not scalarize'; last }

    constant  %iihs5 = {:42foo, :70bar};
    is-deeply %iihs5, {:42foo, :70bar}, 'Hash remains same';
    constant  %iihs6 = :{:42foo, :70bar};
    is-deeply %iihs6, :{:42foo, :70bar}, 'Object Hash remains same';
    constant  %iihs7 = :42foo;
    is-deeply %iihs7, :42foo.Pair, 'Pair remains same';
    constant  %iihs8 = bag(<a a a b c>);
    is-deeply %iihs8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        constant  %iihs9 = do { %(:foo, :bar) };
        is-deeply %iihs9, %(:foo, :bar), 'def, statement';
    }
    ok ::('%iihs9'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        constant %iihs10 = Foo.new;
        is-deeply %iihs10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        constant %iihs11 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        constant %iihs12 = Bar.new;
        isa-ok %iihs12, Bar, 'no coercion of custom Associative';
    ｣;
}

subtest 'my | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        my constant %mihs0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    my constant %mihs1 = 1, 2, 3, 4;
    is-deeply   %mihs1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    my constant %mihs2 = :42foo, :70bar;
    is-deeply   %mihs2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    my constant %mihs3 = (:42foo, :70bar);
    is-deeply   %mihs3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    my constant %mihs4 = Map.new: (:42foo, :70bar);
    is-deeply   %mihs4, Map.new((:42foo, :70bar)), 'def, Map';
    for %mihs4 { isa-ok $_, Pair, 'does not scalarize'; last }

    my constant %mihs5 = {:42foo, :70bar};
    is-deeply   %mihs5, {:42foo, :70bar}, 'Hash remains same';
    my constant %mihs6 = :{:42foo, :70bar};
    is-deeply   %mihs6, :{:42foo, :70bar}, 'Object Hash remains same';
    my constant %mihs7 = :42foo;
    is-deeply   %mihs7, :42foo.Pair, 'Pair remains same';
    my constant %mihs8 = bag(<a a a b c>);
    is-deeply   %mihs8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        my constant %mihs9 = do { %(:foo, :bar) };
        is-deeply   %mihs9, %(:foo, :bar), 'def, statement';
    }
    nok ::('%mihs9'), '`my` makes constants lexical';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        my constant %mihs10 = Foo.new;
        is-deeply %mihs10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        my constant %mihs11 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        my constant %mihs12 = Bar.new;
        isa-ok %mihs12, Bar, 'no coercion of custom Associative';
    ｣;
}

subtest 'our | implied | %-sigilled' => {
    plan 16;
    throws-like ｢
        use v6.d;
        our constant %oihs0 = 42
    ｣, X::Hash::Store::OddNumber, 'def, simple value';

    our constant %oihs1 = 1, 2, 3, 4;
    is-deeply    %oihs1, Map.new((1 => 2, 3 => 4)), 'def, List of values';
    our constant %oihs2 = :42foo, :70bar;
    is-deeply    %oihs2, Map.new((:42foo, :70bar)),
        'def, List of Pairs (no parens)';
    our constant %oihs3 = (:42foo, :70bar);
    is-deeply    %oihs3, Map.new((:42foo, :70bar)),
        'def, List of Pairs (with parens)';
    our constant %oihs4 = Map.new: (:42foo, :70bar);
    is-deeply    %oihs4, Map.new((:42foo, :70bar)), 'def, Map';
    for %oihs4 { isa-ok $_, Pair, 'does not scalarize'; last }

    our constant %oihs5 = {:42foo, :70bar};
    is-deeply    %oihs5, {:42foo, :70bar}, 'Hash remains same';
    our constant %oihs6 = :{:42foo, :70bar};
    is-deeply    %oihs6, :{:42foo, :70bar}, 'Object Hash remains same';
    our constant %oihs7 = :42foo;
    is-deeply    %oihs7, :42foo.Pair, 'Pair remains same';
    our constant %oihs8 = bag(<a a a b c>);
    is-deeply    %oihs8, bag(<a a a b c>), 'Bag remains same';

    { # add a scope to check scope declarator works right
        our constant %oihs9 = do { %(:foo, :bar) };
        is-deeply    %oihs9, %(:foo, :bar), 'def, statement';
    }
    ok ::('%oihs9'), 'implied scope declarator behaves like `our`';

    EVAL ｢
        use v6.d;
        my class Foo {
            method Map {
                pass 'coercion calls .Map method';
                Map.new: (:42foo, :70bar)
            }
        }
        our constant %oihs10 = Foo.new;
        is-deeply %oihs10, Map.new((:42foo, :70bar)),
            'right result after coersion';
    ｣;

    throws-like ｢
        use v6.d;
        my class Foo { method Map { 42 } }
        our constant %oihs11 = Foo.new;
    ｣, X::TypeCheck, 'typecheck fails if .Map does not return Associative';

    EVAL ｢
        use v6.d;
        my class Bar does Associative {
            method Map { flunk 'called .Map on an already-Associative' }
        }
        our constant %oihs12 = Bar.new;
        isa-ok %oihs12, Bar, 'no coercion of custom Associative';
    ｣;
}

subtest 'my | typed | %-sigilled' => {
    plan 3;
    throws-like ｢my Int constant %mths1 = :foo;｣,
        X::ParametricConstant, 'simple value';
    throws-like ｢my IO::Path constant %mths2 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo2::Bar2[Ber2::Meow2] constant %mths3 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

subtest 'our | typed | %-sigilled' => {
    plan 3;
    throws-like ｢our Int constant %oths1 = :foo;｣,
        X::ParametricConstant, 'statement';
    throws-like ｢our IO::Path constant %oths2 = 42｣, X::ParametricConstant,
        'type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo2::Bar2[Ber2::Meow2] constant %oths3 = 42｣,
        X::ParametricConstant, 'parametarized type with `::` in name';
}

# vim: expandtab shiftwidth=4
