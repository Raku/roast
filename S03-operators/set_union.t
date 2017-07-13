use v6;
use Test;

# This test file tests the following set operators:
#   (|)     union (Texas)
#   ∪       union

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

# QuantHash types
my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Set,
  <a b c>.SetHash,    <a b c>.Set,
  <a b c>.Bag,        <a b c>.Bag,
  <a b c>.BagHash,    <a b c>.Bag,
  <a b c>.Mix,        <a b c>.Mix,
  <a b c>.MixHash,    <a b c>.Mix,
  {:42a},             <a>.Set,
  {:42a,:0b},         <a>.Set,
  :{:42a},            <a>.Set,
  :{:42a,:0b},        <a>.Set,
  <a b c>,            <a b c>.Set,
  ("a","b",:0c),      <a b>.Set,
  42,                 42.Set,
  :0b,                set(),
;

# two parameters, result
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
  (:42a,:0b),                   (:c,:42d,"e"),     <a c d e>.Set,
  {:42a,:0b},                   {:c,:42d},         <a c d>.Set,
  :{42=>"a",666=>""},           :{55=>"c",66=>1},  (42,55,66).Set,
  :{42=>"a",666=>""},           {:c,:42d},         (42,"c","d").Set,
  {:42a,:0b},                   <c d e>,           <a c d e>.Set,
  :{42=>"a",666=>""},           <a b c>,           (42,"a","b","c").Set,
  42,                           666,               (42,666).Set,
;

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <c d e>.Set, <e f g>.Set],         <a b c d e f g>.Set,
  [<a b c>.Bag, <c d e>.Bag, <e f g>.Bag],         <a b c d e f g>.Bag,
  [<a b c>.Mix, <c d e>.Mix, <e f g>.Mix],         <a b c d e f g>.Mix,
  [<a b c>.Set, <c d e>.Set, <e f g>.Bag],         <a b c d e f g>.Bag,
  [<a b c>.Set, <c d e>.Set, <e f g>.Mix],         <a b c d e f g>.Mix,
  [<a b c>.Set, <c d e>.Bag, <e f g>.Mix],         <a b c d e f g>.Mix,

  [<a b c>, <c d e>, <e f g>],                     <a b c d e f g>.Set,
  [<a b c>, <c d e>, <e f g>.Set],                 <a b c d e f g>.Set,
  [<a b c>, <c d e>, <e f g>.Bag],                 <a b c d e f g>.Bag,
  [<a b c>, <c d e>, <e f g>.Mix],                 <a b c d e f g>.Mix,
  [<a b c>, <c d e>.Bag, <e f g>.Mix],             <a b c d e f g>.Mix,

  [{:a,:b,:c}, {:c,:d,:e}, {:e,:f,:g}],            <a b c d e f g>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Set],           <a b c d e f g>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Bag],           <a b c d e f g>.Bag,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Mix],           <a b c d e f g>.Mix,

  [{:a,:b,:c}, <c d e>, {:e,:f,:g}],               <a b c d e f g>.Set,
  [{:a,:b,:c}, <c d e>, <e f g>.Set],              <a b c d e f g>.Set,
  [{:a,:b,:c}, <c d e>, <e f g>.Bag],              <a b c d e f g>.Bag,
  [{:a,:b,:c}, <c d e>, <e f g>.Mix],              <a b c d e f g>.Mix,

  <a b c>,                                         <a b c>.Set,
;

plan 4 * (1 + 3 * @types + 2 * @pairs/2 + 3 * @triplets/3 + 6 * @quads/2);

# union
for
  &infix:<∪>,       "∪",
  &infix:<(|)>,   "(|)",
  &infix:<R∪>,     "R∪",
  &infix:<R(|)>, "R(|)"
-> &op, $name {

    is-deeply op(), set(), "does $name\() return set()";

    for @types -> \qh {
        is-deeply op(qh.new,qh.new,qh.new), ::(qh.^name.substr(0,3)).new,
          "Sequence of empty {qh.^name} is the empty {qh.^name.substr(0,3)}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new (|) lazy list";
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new(<a b c>) (|) lazy list";
    }

    for @pairs -> $parameter, $result {
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
#exit dd $parameter xx 3, $result unless
        is-deeply op($parameter,$parameter,$parameter), $result,
          "infix:<$name>($parameter.gist() xx 3)";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
#exit dd $left, $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "[$name] $left.gist(), $left.gist(), $right.gist()";
#exit dd $right, $left, $result unless
        is-deeply op($right,$left), $result,
          "$right.gist() $name $left.gist()";
    }

    for @quads -> @params, $result {
        for @params.permutations -> @mixed {
#exit dd @mixed, $result unless
            is-deeply op(|@mixed), $result,
              "[$name] @mixed>>.gist()";
        }
    }
}

# vim: ft=perl6
