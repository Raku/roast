use v6;
use Test;

# This test file tests the following set operators:
#   (|)     union (Texas)
#   ∪       union

# special case empties (with an empty internal hash)
my $esh  = do { my $sh = <a>.SetHash; $sh<a>:delete; $sh };
my $ebh  = do { my $bh = <a>.BagHash; $bh<a>:delete; $bh };
my $emh  = do { my $mh = <a>.MixHash; $mh<a>:delete; $mh };

my @triplets =

  # result should be a Set
  set(),                        set(),             set(),
  SetHash.new,                  SetHash.new,       set(),
  $esh,                         $esh,              set(),
  <a b>.Set,                    set(),             <a b>.Set,
  <a b>.SetHash,                set(),             <a b>.Set,
  <a b>.Set,                    <a b>.Set,         <a b>.Set,
  <a b>.SetHash,                <a b>.SetHash,     <a b>.Set,
  <a b>.Set,                    <c d>.Set,         <a b c d>.Set,
  <a b>.SetHash,                <c d>.SetHash,     <a b c d>.Set,

  # result should be a Bag
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             <a b b>.Bag,
  <a b b>.BagHash,              bag(),             <a b b>.Bag,
  <a b b>.Bag,                  <a b>.Bag,         <a b b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a b b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         <a b b c d>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     <a b b c d>.Bag,

  # result should be a Mix
  mix(),                        mix(),             mix(),
  MixHash.new,                  MixHash.new,       mix(),
  $emh,                         $emh,              mix(),
  (a=>pi,b=>tau).Mix,           mix(),             (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       mix(),             (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash,     (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,         (a=>pi,b=>tau,c=>1,d=>1).Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash,     (a=>pi,b=>tau,c=>1,d=>1).Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a b b>.Bag,
  <a b>.SetHash,                <a b b>.BagHash,   <a b b>.Bag,

  <a b>.Bag,                    <a b b>.Mix,       <a b b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <a b b>.Mix,

  <a b c>,                      <c d e>,           <a b c d e>.Set,
  {:42a,:0b},                   {:c,:42d},         <a c d>.Set,
  :{42=>"a",666=>""},           :{55=>"c",66=>1},  (42,55,66).Set,
  :{42=>"a",666=>""},           {:c,:42d},         (42,"c","d").Set,
  {:42a,:0b},                   <c d e>,           <a c d e>.Set,
  :{42=>"a",666=>""},           <a b c>,           (42,"a","b","c").Set,
  42,                           666,               (42,666).Set,
;

plan 4 * (2 * @triplets/3);

# is an element of / contains
for
  &infix:<∪>,       "∪",
  &infix:<(|)>,   "(|)",
  &infix:<R∪>,     "R∪",
  &infix:<R(|)>, "R(|)"
-> &op, $name {
    for @triplets -> $left, $right, $result {
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
        is-deeply op($right,$left), $result,
          "$right.gist() $name $left.gist()";
    }
}

# vim: ft=perl6
