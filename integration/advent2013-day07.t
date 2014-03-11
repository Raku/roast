use v6;
use Test;
plan 6;

# U+2286 SUBSET OF OR EQUAL TO
  only sub infix:<<"\x2286">>($a, $b --> Bool) {
      $a (<=) $b;
  }

is(set( <a b c> ) ⊆ set( <a b c d> ), True);
is(set( <a b c d> ) ⊆ set( <a b c> ), False);
is(<a b c> ⊆ <a b d>, False);
is(<a b c> === <a b c>, False);
is(<a b c> eqv <a b c>, True);
is(set(<a b c>).WHICH, 'Set|Str|a Str|b Str|c');