use v6;
use Test;
plan 2;

# Clarifications to specification of constants introduced in 6.d language.
# Many of these were added as part of the CaR TPF Grant:
# http://news.perlfoundation.org/2018/04/grant-proposal-perl-6-bugfixin.html

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
