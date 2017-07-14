use v6;
use Test;

# This test file tests the following set operators:
#   (+)     baggy addition (Texas)
#   ⊎       baggy addition

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

  # result should be a Set
  set(),                        set(),             bag(),
  SetHash.new,                  SetHash.new,       bag(),
  $esh,                         $esh,              bag(),
  <a b>.Set,                    set(),             <a b>.Bag,
  <a b>.SetHash,                set(),             <a b>.Bag,
  <a b>.Set,                    <a b>.Set,         <a a b b>.Bag,
  <a b>.SetHash,                <a b>.SetHash,     <a a b b>.Bag,
  <a b>.Set,                    <c d>.Set,         <a b c d>.Bag,
  <a b c>.Set,                  <b c d>.Set,       <a b b c c d>.Bag,
  <a b>.SetHash,                <c d>.SetHash,     <a b c d>.Bag,
  <a b c>.SetHash,              <b c d>.SetHash,   <a b b c c d>.Bag,

  # result should be a Bag
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             <a b b>.Bag,
  <a b b>.BagHash,              bag(),             <a b b>.Bag,
  <a b b>.Bag,                  <a b>.Bag,         <a a b b b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a a b b b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         <a b b c d>.Bag,
  <a b b c>.Bag,                <b c d>.Bag,       <a b b b c c d>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     <a b b c d>.Bag,
  <a b b c>.BagHash,            <b c d>.BagHash,   <a b b b c c d>.Bag,

  # result should be a Mix
  mix(),                        mix(),         mix(),
  MixHash.new,                  MixHash.new,   mix(),
  $emh,                         $emh,          mix(),
  mix(),                        <a b>.Mix,     <a b>.Mix,
  MixHash.new,                  <a b>.MixHash, <a b>.Mix,
  (a=>pi,b=>tau).Mix,           mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>(pi+1),b=>(tau+1)).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>(pi+1),b=>(tau+1)).Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     (a=>pi,b=>tau,c=>1,d=>1).Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, (a=>pi,b=>tau,c=>1,d=>1).Mix,
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (a=>pi,b=>(tau+1),c=>1).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (a=>pi,b=>(tau+1),c=>1).Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a a b b b>.Bag,
  <a b>.SetHash,                <a b b>.BagHash,   <a a b b b>.Bag,

  <a b>.Set,                    <a b b>.Mix,       <a a b b b>.Mix,
  <a b>.SetHash,                <a b b>.MixHash,   <a a b b b>.Mix,

  <a b>.Set,                    (b=>-1).Mix,       <a>.Mix,
  <a b>.SetHash,                (b=>-1).MixHash,   <a>.Mix,

  <a b>.Bag,                    <a b b>.Mix,       <a a b b b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <a a b b b>.Mix,

  <a b>.Bag,                    (b=>-1).Mix,       <a>.Mix,
  <a b>.BagHash,                (b=>-1).MixHash,   <a>.Mix,

  <a b c>.Set,                  {:42a,:0b},        (:43a,:1b,:1c).Bag,
  <a b c>.SetHash,              {:42a,:0b},        (:43a,:1b,:1c).Bag,
  <a b b c>.Bag,                {:42a,:0b},        (:43a,:2b,:1c).Bag,
  <a b b c>.BagHash,            {:42a,:0b},        (:43a,:2b,:1c).Bag,
  <a b b c>.Mix,                {:42a,:0b},        (:43a,:2b,:1c).Mix,
  <a b b c>.MixHash,            {:42a,:0b},        (:43a,:2b,:1c).Mix,

  <a b c>.Set,                  <a b c d>,         <a a b b c c d>.Bag,
  <a b c>.SetHash,              <a b c d>,         <a a b b c c d>.Bag,
  <a b b c>.Bag,                <a b c d>,         <a a b b b c c d>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <a a b b b c c d>.Bag,
  <a b b c>.Mix,                <a b c d>,         <a a b b b c c d>.Mix,
  <a b b c>.MixHash,            <a b c d>,         <a a b b b c c d>.Mix,

  <a b c>,                      <c d e>,           <a b c c d e>.Bag,
  (:42a,:0b,:c),                (:4c,:42d,"e"),    (:42a,:5c,:42d,:1e).Bag,
  (:2a,:40a,:0b,:c),            (:4c,:42d,"e"),    (:42a,:5c,:42d,:1e).Bag,
  (:b,:c,:42d,"e"),             (:42a,:0b,:c),     (:42a,:1b,:2c,:42d,:1e).Bag,
  (:42a,:0b),                   (:a,:42d,"e"),     (:43a,:42d,:1e).Bag,
  {:42a,:0b},                   {:a,:c,:42d},      (:43a,:1c,:42d).Bag,
  :{:42a,:0b},                  {:a,:c,:42d},      (:43a,:1c,:42d).Bag,
  {:42a,:0b},                   <c d e>,           (:42a,:1c,:1d,:1e).Bag,
  {:42a,:0b},                   <a d e>,           (:43a,:1d,:1e).Bag,
  42,                           42,                (42 => 2).Bag,
  42,                           666,               (42,666).Bag,
;

plan 2 * (1 + @pairs/2 + 2 * @triplets/3) + @types * 2;

# addition
for
  &infix:<(+)>, "(+)",
  &infix:<⊎>,     "⊎"
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
