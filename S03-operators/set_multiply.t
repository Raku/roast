use v6;
use Test;

# This test file tests the following set operators:
#   (.)  set multiplication (Texas)
#   ⊍    set multiplication

# special case empties (with an empty internal hash)
my $esh  = do { my $sh = <a>.SetHash; $sh<a>:delete; $sh };
my $ebh  = do { my $bh = <a>.BagHash; $bh<a>:delete; $bh };
my $emh  = do { my $mh = <a>.MixHash; $mh<a>:delete; $mh };

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Bag,
  <a b c>.SetHash,    <a b c>.Bag,
  <a b c>.Bag,        <a b c>.Bag,
  <a b c>.BagHash,    <a b c>.Bag,
  <a b c>.Mix,        <a b c>.Mix,
  <a b c>.MixHash,    <a b c>.Mix,
  <a b c>,            <a b c>.Bag,
  {:42a,:0b},         (:42a).Bag,
  :{:42a,:0b},        (:42a).Bag,
  42,                 42.Bag,
;

# left, right, result
my @triplets =

  # using sets
  set(),                        set(),             bag(),
  SetHash.new,                  SetHash.new,       bag(),
  $esh,                         $esh,              bag(),
  <a b>.Set,                    set(),             bag(),
  <a b>.SetHash,                set(),             bag(),
  <a b>.Set,                    <a b>.Set,         <a b>.Bag,
  <a b>.SetHash,                <a b>.SetHash,     <a b>.Bag,
  <a b>.Set,                    <c d>.Set,         bag(),
  <a b c>.Set,                  <b c d>.Set,       <b c>.Bag,
  <a b>.SetHash,                <c d>.SetHash,     bag(),
  <a b c>.SetHash,              <b c d>.SetHash,   <b c>.Bag,

  # using bags
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             bag(),
  <a b b>.BagHash,              bag(),             bag(),
  <a b b>.Bag,                  <a b>.Bag,         <a b b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a b b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         bag(),
  <a b b c>.Bag,                <b c d>.Bag,       <b b c>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     bag(),
  <a b b c>.BagHash,            <b c d>.BagHash,   <b b c>.Bag,

  # using mixes
  mix(),                        mix(),         mix(),
  MixHash.new,                  MixHash.new,   mix(),
  $emh,                         $emh,          mix(),
  mix(),                        <a b>.Mix,     mix(),
  MixHash.new,                  <a b>.MixHash, mix(),
  (a=>pi,b=>tau).Mix,           mix(),         mix(),
  (a=>pi,b=>tau).MixHash,       mix(),         mix(),
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     mix(),
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, mix(),
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (b=>tau).Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a b b>.Bag,
  <a b>.SetHash,                <a b b>.BagHash,   <a b b>.Bag,

  <a b>.Set,                    <a b b>.Mix,       <a b b>.Mix,
  <a b>.SetHash,                <a b b>.MixHash,   <a b b>.Mix,

  <a b>.Set,                    (b=>-1).Mix,       (b=>-1).Mix,
  <a b>.SetHash,                (b=>-1).MixHash,   (b=>-1).Mix,

  <a b>.Bag,                    <a b b>.Mix,       <a b b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <a b b>.Mix,

  <a b>.Bag,                    (b=>-1).Mix,       (b=>-1).Mix,
  <a b>.BagHash,                (b=>-1).MixHash,   (b=>-1).Mix,

  <a b c>.Set,                  {:42a,:0b},        (:42a).Bag,
  <a b c>.SetHash,              {:42a,:0b},        (:42a).Bag,
  <a b b c>.Bag,                {:42a,:0b},        (:42a).Bag,
  <a b b c>.BagHash,            {:42a,:0b},        (:42a).Bag,
  <a b b c>.Mix,                {:42a,:0b},        (:42a).Mix,
  <a b b c>.MixHash,            {:42a,:0b},        (:42a).Mix,

  <a b c>.Set,                  <a b c d>,         <a b c>.Bag,
  <a b c>.SetHash,              <a b c d>,         <a b c>.Bag,
  <a b b c>.Bag,                <a b c d>,         <a b b c>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <a b b c>.Bag,
  <a b b c>.Mix,                <a b c d>,         <a b b c>.Mix,
  <a b b c>.MixHash,            <a b c d>,         <a b b c>.Mix,

  <a b c>,                      <c d e>,           <c>.Bag,
  (:42a,:0b,:c),                (:4c,:42d,"e"),    (:4c).Bag,
  (:2a,:40a,:0b,:c),            (:2a,:4c,:42d),    (:84a,:4c).Bag,
  (:b,:c,:42d,"e"),             (:42a,:0b,:c),     <c>.Bag,
  (:42a,:0b),                   (:a,:42d,"e"),     (:42a).Bag,
  {:42a,:0b},                   {:a,:c,:42d},      (:42a).Bag,
  :{:42a,:0b},                  {:a,:c,:42d},      (:42a).Bag,
  {:42a,:0b},                   <c d e>,           bag(),
  {:42a,:0b},                   <a d e>,           (:42a).Bag,
  42,                           42,                (42).Bag,
  42,                           666,               bag(),
;

plan 2 * (1 + @pairs/2 + 2 * @triplets/3) + @types * 2;

# addition
for
  &infix:<⊍>,     "⊍",
  &infix:<(.)>, "(+)"
-> &op, $name {

    is-deeply op(), bag(), "does $name\() return bag()";

    for @pairs -> $parameter, $result {
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>($parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
#exit dd $right, $left, $result unless
        is-deeply op($right,$left), $result,
          "$right.gist() $name $left.gist()";
    }
}

for @types -> \qh {
    throws-like { qh.new (-) ^Inf }, X::Cannot::Lazy,
      "Cannot {qh.perl}.new (-) lazy list";
    throws-like { qh.new(<a b c>) (-) ^Inf }, X::Cannot::Lazy,
      "Cannot {qh.perl}.new(<a b c>) (-) lazy list";
}

# vim: ft=perl6
