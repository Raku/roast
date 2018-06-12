use v6;
use Test;
plan 7;

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
