use v6;
use Test;

# This test file tests the following set operators:
#   (.)  set multiplication (ASCII)
#   ⊍    set multiplication

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Bag,
  <a b c>.SetHash,    <a b c>.BagHash,
  <a b c>.Bag,        <a b c>.Bag,
  <a b c>.BagHash,    <a b c>.BagHash,
  <a b c>.Mix,        <a b c>.Mix,
  <a b c>.MixHash,    <a b c>.MixHash,
  <a b c>,            <a b c>.Bag,
  {:42a,:0b},         (:42a).Bag,
  :{:42a,:0b},        (:42a).Bag,
  42,                 42.Bag,
;

# left, right, result
my @triplets =

  # using sets, should return a Bag(Hash)
  set(),                        set(),             bag(),
  SetHash.new,                  set(),             BagHash.new,
  set(),                        SetHash.new,       bag(),
  SetHash.new,                  SetHash.new,       BagHash.new,
  $esh,                         set(),             BagHash.new,
  set(),                        $esh,              bag(),
  $esh,                         $esh,              BagHash.new,

  <a b>.Set,                    set(),             bag(),
  <a b>.SetHash,                set(),             BagHash.new,
  <a b>.Set,                    <a b>.Set,         <a b>.Bag,
  <a b>.SetHash,                <a b>.SetHash,     <a b>.BagHash,
  <a b>.Set,                    <c d>.Set,         bag(),
  <a b c>.Set,                  <b c d>.Set,       <b c>.Bag,
  <a b>.SetHash,                <c d>.SetHash,     BagHash.new,
  <a b c>.SetHash,              <b c d>.SetHash,   <b c>.BagHash,

  # using bags, should return a Bag(Hash)
  bag(),                        bag(),             bag(),
  BagHash.new,                  bag(),             BagHash.new,
  bag(),                        BagHash.new,       bag(),
  BagHash.new,                  BagHash.new,       BagHash.new,
  $ebh,                         bag(),             BagHash.new,
  bag(),                        $ebh,              bag(),
  $ebh,                         $ebh,              BagHash.new,

  <a b b>.Bag,                  bag(),             bag(),
  <a b b>.BagHash,              bag(),             BagHash.new,
  <a b b>.Bag,                  <a b>.Bag,         <a b b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a b b>.BagHash,
  <a b b>.Bag,                  <c d>.Bag,         bag(),
  <a b b c>.Bag,                <b c d>.Bag,       <b b c>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     BagHash.new,
  <a b b c>.BagHash,            <b c d>.BagHash,   <b b c>.BagHash,

  # using mixes, should return a Mix(Hash)
  mix(),                        mix(),         mix(),
  MixHash.new,                  mix(),         MixHash.new,
  mix(),                        MixHash.new,   mix(),
  MixHash.new,                  MixHash.new,   MixHash.new,
  $emh,                         mix(),         MixHash.new,
  mix(),                        $emh,          mix(),
  $emh,                         $emh,          MixHash.new,

  mix(),                        <a b>.Mix,     mix(),
  MixHash.new,                  <a b>.MixHash, MixHash.new,
  (a=>pi,b=>tau).Mix,           mix(),         mix(),
  (a=>pi,b=>tau).MixHash,       mix(),         MixHash.new,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>pi,b=>tau).MixHash,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     mix(),
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, MixHash.new,
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (b=>tau).MixHash,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a b b>.Bag,
  <a b>.Set,                    <a b b>.BagHash,   <a b b>.Bag,
  <a b>.SetHash,                <a b b>.Bag,       <a b b>.BagHash,
  <a b>.SetHash,                <a b b>.BagHash,   <a b b>.BagHash,

  <a b>.Set,                    <a b b>.Mix,       <a b b>.Mix,
  <a b>.Set,                    <a b b>.MixHash,   <a b b>.Mix,
  <a b>.SetHash,                <a b b>.Mix,       <a b b>.MixHash,
  <a b>.SetHash,                <a b b>.MixHash,   <a b b>.MixHash,

  <a b>.Set,                    (b=>-1).Mix,       (b=>-1).Mix,
  <a b>.SetHash,                (b=>-1).Mix,       (b=>-1).MixHash,
  <a b>.Set,                    (b=>-1).MixHash,   (b=>-1).Mix,
  <a b>.SetHash,                (b=>-1).MixHash,   (b=>-1).MixHash,

  <a b>.Bag,                    <a b b>.Mix,       <a b b>.Mix,
  <a b>.BagHash,                <a b b>.Mix,       <a b b>.MixHash,
  <a b>.Bag,                    <a b b>.MixHash,   <a b b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <a b b>.MixHash,

  <a b>.Bag,                    (b=>-1).Mix,       (b=>-1).Mix,
  <a b>.BagHash,                (b=>-1).Mix,       (b=>-1).MixHash,
  <a b>.Bag,                    (b=>-1).MixHash,   (b=>-1).Mix,
  <a b>.BagHash,                (b=>-1).MixHash,   (b=>-1).MixHash,

  <a b c>.Set,                  {:42a,:0b},        (:42a).Bag,
  <a b c>.SetHash,              {:42a,:0b},        (:42a).BagHash,
  <a b b c>.Bag,                {:42a,:0b},        (:42a).Bag,
  <a b b c>.BagHash,            {:42a,:0b},        (:42a).BagHash,
  <a b b c>.Mix,                {:42a,:0b},        (:42a).Mix,
  <a b b c>.MixHash,            {:42a,:0b},        (:42a).MixHash,

  <a b c>.Set,                  <a b c d>,         <a b c>.Bag,
  <a b c>.SetHash,              <a b c d>,         <a b c>.BagHash,
  <a b b c>.Bag,                <a b c d>,         <a b b c>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <a b b c>.BagHash,
  <a b b c>.Mix,                <a b c d>,         <a b b c>.Mix,
  <a b b c>.MixHash,            <a b c d>,         <a b b c>.MixHash,

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

# List with 3 parameters, result
my @quads =
  [<a b b>.Set, <b b c>.Set, <b c d>.Set],         <b>.Bag,
  [<a b b>.Bag, <b b c>.Bag, <b c d>.Bag],         <b b b b>.Bag,
  [<a b b>.Mix, <b b c>.Mix, <b c d>.Mix],         <b b b b>.Mix,
  [<a b b>.Set, <b b c>.Set, <b c d>.Bag],         <b>.Bag,
  [<a b b>.Set, <b b c>.Set, <b c d>.Mix],         <b>.Mix,
  [<a b b>.Set, <b b c>.Bag, <b c d>.Mix],         <b b>.Mix,

  [<a b b>, <b b c>, <b c d>],                     <b b b b>.Bag,
  [<a b b>, <b b c>, <b c d>.Set],                 <b b b b>.Bag,
  [<a b b>, <b b c>, <b c d>.Bag],                 <b b b b>.Bag,
  [<a b b>, <b b c>, <b c d>.Mix],                 <b b b b>.Mix,
  [<a b b>, <b b c>.Bag, <b c d>.Mix],             <b b b b>.Mix,

  [{:a,:b,:c}, {:b,:c,:d}, {:c,:d,:e}],            <c>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Set],           <c>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Bag],           <c>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Mix],           <c>.Mix,

  [{:a,:b,:c}, <b c d>, {:c,:d,:e}],               <c>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Set],              <c>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Bag],              <c>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Mix],              <c>.Mix,

  [(:2a).Bag, (:7a).Bag, (:3a).Bag],               (:42a).Bag,
  [(:42a).Bag, bag(), (:43a).Bag],                 bag(),
  [(a=>-21).Mix, <a>.Mix, (:2a).Mix],              (a=>-42).Mix,
  [(a=>-42).Mix, set(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, bag(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, mix(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, <b>.Set, (:42a).Bag],             mix(),
  [(a=>-42).Mix, <b>.Bag, (:42a).Bag],             mix(),
  [(a=>-42).Mix, <b>.Mix, (:42a).Bag],             mix(),

  <a b c>,                                         bag()
;

plan 2 * (1 + 3 * @types + @pairs/2 + @triplets/3 + 6 * @quads/2);

# multiplication
for
  &infix:<(.)>, "(.)",
  &infix:<⊍>,     "⊍"
-> &op, $name {

    is-deeply op(), bag(), "does $name\() return bag()";

    for @types -> \qh {
        my $result := qh ~~ Setty ?? qh.Baggy.new !! qh.new;
#exit dd qh, $result unless
        is-deeply
          op(qh.new,qh.new,qh.new),
          $result,
          "Sequence of empty {qh.^name} is the empty {$result.^name}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new $name lazy list";
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.perl}.new(<a b c>) $name lazy list";
    }

    for @pairs -> $parameter, $result {
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>($parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
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
