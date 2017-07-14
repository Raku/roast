use v6;
use Test;

# This test file tests the following set operators:
#   (&)     intersection (Texas)
#   ∩       intersection

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

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

# two parameters, result
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

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <b c d>.Set, <c d e>.Set],         <c>.Set,
  [<a b c>.Bag, <b c d>.Bag, <c d e>.Bag],         <c>.Bag,
  [<a b c>.Mix, <b c d>.Mix, <c d e>.Mix],         <c>.Mix,
  [<a b c>.Set, <b c d>.Set, <c d e>.Bag],         <c>.Bag,
  [<a b c>.Set, <b c d>.Set, <c d e>.Mix],         <c>.Mix,
  [<a b c>.Set, <b c d>.Bag, <c d e>.Mix],         <c>.Mix,

  [<a b c>, <b c d>, <c d e>],                     <c>.Set,
  [<a b c>, <b c d>, <c d e>.Set],                 <c>.Set,
  [<a b c>, <b c d>, <c d e>.Bag],                 <c>.Bag,
  [<a b c>, <b c d>, <c d e>.Mix],                 <c>.Mix,
  [<a b c>, <b c d>.Bag, <c d e>.Mix],             <c>.Mix,

  [{:a,:b,:c}, {:b,:c,:d}, {:c,:d,:e}],            <c>.Set,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Set],           <c>.Set,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Bag],           <c>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Mix],           <c>.Mix,

  [{:a,:b,:c}, <b c d>, {:c,:d,:e}],               <c>.Set,
  [{:a,:b,:c}, <b c d>, <c d e>.Set],              <c>.Set,
  [{:a,:b,:c}, <b c d>, <c d e>.Bag],              <c>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Mix],              <c>.Mix,

  [(:42a).Bag, (:7a).Bag, (:43a).Bag],             (:7a).Bag,
  [(:42a).Bag, bag(), (:43a).Bag],                 bag(),
  [(a=>-42).Mix, <a>.Mix, (:42a).Mix],             (a=>-42).Mix,
  [(a=>-42).Mix, set(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, bag(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, mix(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, <b>.Set, (:42a).Bag],             mix(),
  [(a=>-42).Mix, <b>.Bag, (:42a).Bag],             mix(),
  [(a=>-42).Mix, <b>.Mix, (:42a).Bag],             mix(),

  <a b c>,                                         set()
;

plan 2 * (1 + 3 * @types + @pairs/2 + 2 * @triplets/3 + 6 * @quads/2);

# intersection
for
  &infix:<(&)>,   "(&)",
  &infix:<∩>,       "∩"
-> &op, $name {

    is-deeply op(), set(), "does $name\() return set()";

    for @types -> \qh {         
        is-deeply op(qh.new,qh.new,qh.new), ::(qh.^name.substr(0,3)).new,
          "Sequence of empty {qh.^name} is the empty {qh.^name.substr(0,3)}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new $name lazy list";    
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new(<a b c>) $name lazy list";
    }

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

    for @quads -> @params, $result {
        for @params.permutations -> @mixed {
#exit dd @mixed, $result unless
            is-deeply op(|@mixed), $result,
              "[$name] @mixed>>.gist()";
        }
    }
}

# vim: ft=perl6
