use v6;
use Test;

# This test file tests the following set operators:
#   (&)     intersection (Texas)
#   ∩       intersection

# special case empties (with an empty internal hash)
my $esh  = do { my $sh = <a>.SetHash; $sh<a>:delete; $sh };
my $ebh  = do { my $bh = <a>.BagHash; $bh<a>:delete; $bh };
my $emh  = do { my $mh = <a>.MixHash; $mh<a>:delete; $mh };

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Set,
  <a b c>.SetHash,    <a b c>.Set,
  <a b c>.Bag,        <a b c>.Bag,
  <a b c>.BagHash,    <a b c>.Bag,
  <a b c>.Mix,        <a b c>.Mix,
  <a b c>.MixHash,    <a b c>.Mix,
  <a b c>,            <a b c>.Set,
  {:42a,:0b},         <a>.Set,
  :{:42a,:0b},        <a>.Set,
  42,                 42.Set,
;

my @triplets =

  # result should be a Set
  set(),                        set(),             set(),
  SetHash.new,                  SetHash.new,       set(),
  $esh,                         $esh,              set(),
  <a b>.Set,                    set(),             set(),
  <a b>.SetHash,                set(),             set(),
  <a b>.Set,                    <a b>.Set,         <a b>.Set,
  <a b>.SetHash,                <a b>.SetHash,     <a b>.Set,
  <a b>.Set,                    <c d>.Set,         set(),
  <a b c>.Set,                  <b c d>.Set,       <b c>.Set,
  <a b>.SetHash,                <c d>.SetHash,     set(),
  <a b c>.SetHash,              <b c d>.SetHash,   <b c>.Set,

  # result should be a Bag
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             bag(),
  <a b b>.BagHash,              bag(),             bag(),
  <a b b>.Bag,                  <a b>.Bag,         <a b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         bag(),
  <a b b c>.Bag,                <b c d>.Bag,       <b c>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     bag(),
  <a b b c>.BagHash,            <b c d>.BagHash,   <b c>.Bag,

  # result should be a Mix
  mix(),                        mix(),             mix(),
  MixHash.new,                  MixHash.new,       mix(),
  $emh,                         $emh,              mix(),
  (a=>pi,b=>tau).Mix,           mix(),             mix(),
  (a=>pi,b=>tau).MixHash,       mix(),             mix(),
  (a=>pi,b=>tau).Mix,           <a b>.Mix,         <a b>.Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash,     <a b>.Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,         mix(),
  (a=>pi,b=>tau).Mix,           <b c>.Mix,         <b>.Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash,     mix(),
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash,     <b>.Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a b>.Bag,
  <a b>.SetHash,                <a b b>.BagHash,   <a b>.Bag,

  <a b>.Bag,                    <a b b>.Mix,       <a b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <a b>.Mix,

  <a b c>.Set,                  <a b c d>,         <a b c>.Set,
  <a b c>.Bag,                  <a b c d>,         <a b c>.Bag,
  <a b c>.Mix,                  <a b c d>,         <a b c>.Mix,

  <a b c>,                      <c d e>,           <c>.Set,
  (:42a,:0b),                   (:c,:42d,"e"),     set(),
  (:42a,:0b),                   (:a,:42d,"e"),     <a>.Set,
  {:42a,:0b},                   {:a,:c,:42d},      <a>.Set,
  :{42=>"a",666=>""},           :{55=>"c",66=>1},  set(),
  :{42=>"a",666=>""},           :{55=>"c",666=>1}, set(),
  :{42=>"a",666=>""},           :{42=>"c",666=>1}, 42.Set,
  :{42=>"a",666=>""},           {:c,:42d},         set(),
  :{a=>42,666=>""},             {:a,:42d},         <a>.Set,
  {:42a,:0b},                   <c d e>,           set(),
  {:42a,:0b},                   <a d e>,           <a>.Set,
  :{42=>"a",666=>""},           <a b c>,           set(),
  :{a=>42,666=>""},             <a b c>,           <a>.Set,
  42,                           666,               set(),
;

plan 4 * (1 + @pairs/2 + 2 * @triplets/3) + 2 * @types;

# intersection
for
  &infix:<∩>,       "∩",
  &infix:<(&)>,   "(&)",
  &infix:<R∩>,     "R∩",
  &infix:<R(&)>, "R(&)"
-> &op, $name {

    is-deeply op(), set(), "does $name\() return set()";

    for @pairs -> $parameter, $result {
#exit dd $parameters, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $parameters, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
#exit dd $parameters, $result unless
        is-deeply op($right,$left), $result,
          "$right.gist() $name $left.gist()";
    }
}

for @types -> \qh {
pass;
#    throws-like { qh.new (&) ^Inf }, X::Cannot::Lazy,
#      "Cannot {qh.perl}.new (&) lazy list";
pass;
#    throws-like { qh.new(<a b c>) (&) ^Inf }, X::Cannot::Lazy,
#      "Cannot {qh.perl}.new(<a b c>) (&) lazy list";
}

# vim: ft=perl6
