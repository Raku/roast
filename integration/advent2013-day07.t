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

# in the advent article, it returned False.  Since then, S07:55
#
#   "A C<Parcel> is immutable, although the elements of a C<Parcel>
#    may be either mutable or immutable."
#
# is interpreted in such a way that Parcels have become value based,
# and that means that this test should return True
is(<a b c> === <a b c>, True);

is(<a b c> eqv <a b c>, True);
is(set(<a b c>).WHICH, 'Set|Str|a Str|b Str|c');
