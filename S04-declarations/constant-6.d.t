use v6;
use Test;
plan 17;

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
my \ClassDefs := ｢my role Foo::Bar2[::T] {}; my class Ber::Meow2 {}; ｣;

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
    is-deeply mts4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path mts5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant mts6 = Foo::Bar[Ber::Meow].new;
    is-deeply mts6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo::Bar2[Ber::Meow2] constant mts7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
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
    is-deeply ots4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path ots5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant ots6 = Foo::Bar[Ber::Meow].new;
    is-deeply ots6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo::Bar2[Ber::Meow2] constant ots7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
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
    is-deeply mtbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path mtbs5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant \mtbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply mtbs6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo::Bar2[Ber::Meow2] constant mtbs7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
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
    is-deeply otbs4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path otbs5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant \otbs6 = Foo::Bar[Ber::Meow].new;
    is-deeply otbs6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo::Bar2[Ber::Meow2] constant otbs7 = 42｣, X::TypeCheck,
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
    is-deeply $mtss4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path $mtss5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    my Foo::Bar[Ber::Meow] constant $mtss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $mtss6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢my Foo::Bar2[Ber::Meow2] constant $mtss7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
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
    is-deeply $otss4, '.'.IO, 'type with `::` in name';
    throws-like ｢my IO::Path $otss5 = 42｣, X::TypeCheck, 'type with `::` in name (failure mode)';

    our Foo::Bar[Ber::Meow] constant $otss6 = Foo::Bar[Ber::Meow].new;
    is-deeply $otss6, Foo::Bar[Ber::Meow].new, 'parametarized type with `::` in name';
    throws-like ClassDefs ~ ｢our Foo::Bar2[Ber::Meow2] constant $otss7 = 42｣, X::TypeCheck,
        'parametarized type with `::` in name (failure mode)';
}


subtest '@-sigilled constants' => {
      plan 8;

      constant  @pos1 = 1, 2, 3;
      is-deeply @pos1, (1, 2, 3), 'List';

      constant  @pos2 = [1, 2, 3];
      is-deeply @pos2, [1, 2, 3], 'Array';

      constant  @pos3 = (1, 2, 3).Seq;
      is-deeply @pos3, (1, 2, 3), 'Seq coercion';

      constant  @pos4 = 42;
      is-deeply @pos4, (42,), 'Int coercion';

      constant  @pos5 = %(:42foo, :70bar);
      isa-ok    @pos5, List, 'Hash coercion (type)';
      is-deeply @pos5.sort, (:42foo, :70bar).sort, 'Hash coercion (values)';

      EVAL ｢
          my class Foo { method cache { pass 'coercion calls .cache method' } }
          constant @pos6 = Foo.new;
      ｣;

      EVAL ｢
          my class Bar does Positional {
              method cache { flunk 'called .cache on an already-Positional' }
          }
          constant @pos7 = Bar.new;
          isa-ok @pos7, Bar, 'no coercion of custom Positionals';
      ｣;
}

subtest '%-sigilled constants' => {
      plan 9;

      constant  %assoc1 = Map.new(1, 2, 3, 4);
      is-deeply %assoc1,  Map.new(1, 2, 3, 4), 'Map';

      constant  %assoc2 = %(1, 2, 3, 4);
      is-deeply %assoc2,  %(1, 2, 3, 4), 'Hash';

      constant  %assoc3 = :{1 => 2, 3 => 4};
      is-deeply %assoc3,  :{1 => 2, 3 => 4}, 'Object Hash';

      constant  %assoc4 = :42foo;
      is-deeply %assoc4,  :42foo.Pair, 'Pair';

      # XXX TODO
      skip 'compile error';
      # constant  %assoc5 = 1, 2, 3, 4;
      # is-deeply %assoc5, Map.new(1, 2, 3, 4), 'List coercsion';

      # XXX TODO
      skip 'compile error';
      # constant  %assoc6 = [1, 2, 3, 4];
      # is-deeply %assoc6, Map.new(1, 2, 3, 4), 'Array coercsion';

      throws-like ｢constant %assoc7 = 42｣, X::Hash::Store::OddNumber,
          'Int coercion';

      # XXX TODO
      skip 'compile error';
      # try EVAL ｢
          # my class Foo { method Map { pass 'coercion calls .Map method' } }
          # constant %assoc8 = Foo.new;
      # ｣;

      EVAL ｢
          my class Bar does Associative {
              method Map { flunk 'called .Map on an already-Positional' }
          }
          constant %assoc9 = Bar.new;
          isa-ok %assoc9, Bar, 'no coercion of custom Associativess';
      ｣;
}

# vim: ft=perl6
