use v6;
use Test;

# This test file tests the following set operators:
#   (+)     baggy addition (ASCII)
#   ⊎       baggy addition

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

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

  # result should be a Bag(Hash)
  Set,                          Set,               bag(Set,Set),
  Set,                          set(),             bag(Set),
  set(),                        Set,               bag(Set),
  set(),                        set(),             bag(),
  Set.new,                      SetHash.new,       bag(),
  SetHash.new,                  Set.new,           ().BagHash,
  SetHash.new,                  SetHash.new,       ().BagHash,
  set(),                        $esh,              bag(),
  $esh,                         set(),             ().BagHash,
  $esh,                         $esh,              ().BagHash,

  <a b>.Set,                    set(),             <a b>.Bag,
  <a b>.SetHash,                set(),             <a b>.BagHash,
  <a b>.Set,                    <a b>.Set,         <a a b b>.Bag,
  <a b>.SetHash,                <a b>.SetHash,     <a a b b>.BagHash,
  <a b>.Set,                    <c d>.Set,         <a b c d>.Bag,
  <a b c>.Set,                  <b c d>.Set,       <a b b c c d>.Bag,
  <a b>.SetHash,                <c d>.SetHash,     <a b c d>.BagHash,
  <a b c>.SetHash,              <b c d>.SetHash,   <a b b c c d>.BagHash,

  # result should be a Bag(Hash)
  Bag,                          Bag,               bag(Bag,Bag),
  Bag,                          bag(),             bag(Bag),
  bag(),                        Bag,               bag(Bag),
  bag(),                        bag(),             bag(),
  Bag.new,                      BagHash.new,       bag(),
  BagHash.new,                  Bag.new,           ().BagHash,
  BagHash.new,                  BagHash.new,       ().BagHash,
  bag(),                        $ebh,              bag(),
  $ebh,                         bag(),             ().BagHash,
  $ebh,                         $ebh,              ().BagHash,

  <a b b>.Bag,                  bag(),             <a b b>.Bag,
  <a b b>.BagHash,              bag(),             <a b b>.BagHash,
  <a b b>.Bag,                  <a b>.Bag,         <a a b b b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a a b b b>.BagHash,
  <a b b>.Bag,                  <c d>.Bag,         <a b b c d>.Bag,
  <a b b c>.Bag,                <b c d>.Bag,       <a b b b c c d>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     <a b b c d>.BagHash,
  <a b b c>.BagHash,            <b c d>.BagHash,   <a b b b c c d>.BagHash,

  # result should be a Mix(Hash)
  Mix,                          Mix,           mix(Mix,Mix),
  Mix,                          mix(),         mix(Mix),
  mix(),                        Mix,           mix(Mix),
  mix(),                        mix(),         mix(),
  Mix.new,                      MixHash.new,   mix(),
  MixHash.new,                  Mix.new,       ().MixHash,
  MixHash.new,                  MixHash.new,   ().MixHash,
  mix(),                        $emh,          mix(),
  $emh,                         mix(),         ().MixHash,
  $emh,                         $emh,          ().MixHash,

  mix(),                        <a b>.Mix,     <a b>.Mix,
  MixHash.new,                  <a b>.MixHash, <a b>.MixHash,
  (a=>pi,b=>tau).Mix,           mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       mix(),         (a=>pi,b=>tau).MixHash,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>(pi+1),b=>(tau+1)).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>(pi+1),b=>(tau+1)).MixHash,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     (a=>pi,b=>tau,c=>1,d=>1).Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, (a=>pi,b=>tau,c=>1,d=>1).MixHash,
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (a=>pi,b=>(tau+1),c=>1).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (a=>pi,b=>(tau+1),c=>1).MixHash,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a a b b b>.Bag,
  <a b>.Set,                    <a b b>.BagHash,   <a a b b b>.Bag,
  <a b>.SetHash,                <a b b>.Bag,       <a a b b b>.BagHash,
  <a b>.SetHash,                <a b b>.BagHash,   <a a b b b>.BagHash,

  <a b>.Set,                    <a b b>.Mix,       <a a b b b>.Mix,
  <a b>.Set,                    <a b b>.MixHash,   <a a b b b>.Mix,
  <a b>.SetHash,                <a b b>.Mix,       <a a b b b>.MixHash,
  <a b>.SetHash,                <a b b>.MixHash,   <a a b b b>.MixHash,

  <a b>.Set,                    (b=>-1).Mix,       <a>.Mix,
  <a b>.Set,                    (b=>-1).MixHash,   <a>.Mix,
  <a b>.SetHash,                (b=>-1).Mix,       <a>.MixHash,
  <a b>.SetHash,                (b=>-1).MixHash,   <a>.MixHash,

  <a b>.Bag,                    <a b b>.Mix,       <a a b b b>.Mix,
  <a b>.Bag,                    <a b b>.MixHash,   <a a b b b>.Mix,
  <a b>.BagHash,                <a b b>.Mix,       <a a b b b>.MixHash,
  <a b>.BagHash,                <a b b>.MixHash,   <a a b b b>.MixHash,

  <a b>.Bag,                    (b=>-1).Mix,       <a>.Mix,
  <a b>.Bag,                    (b=>-1).MixHash,   <a>.Mix,
  <a b>.BagHash,                (b=>-1).Mix,       <a>.MixHash,
  <a b>.BagHash,                (b=>-1).MixHash,   <a>.MixHash,

  <a b c>.Set,                  {:42a,:0b},        (:43a,:1b,:1c).Bag,
  <a b c>.SetHash,              {:42a,:0b},        (:43a,:1b,:1c).BagHash,
  <a b b c>.Bag,                {:42a,:0b},        (:43a,:2b,:1c).Bag,
  <a b b c>.BagHash,            {:42a,:0b},        (:43a,:2b,:1c).BagHash,
  <a b b c>.Mix,                {:42a,:0b},        (:43a,:2b,:1c).Mix,
  <a b b c>.MixHash,            {:42a,:0b},        (:43a,:2b,:1c).MixHash,

  <a b c>.Set,                  <a b c d>,         <a a b b c c d>.Bag,
  <a b c>.SetHash,              <a b c d>,         <a a b b c c d>.BagHash,
  <a b b c>.Bag,                <a b c d>,         <a a b b b c c d>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <a a b b b c c d>.BagHash,
  <a b b c>.Mix,                <a b c d>,         <a a b b b c c d>.Mix,
  <a b b c>.MixHash,            <a b c d>,         <a a b b b c c d>.MixHash,

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

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <c d e>.Set, <d e f>.Set],         <a b c c d d e e f>.Bag,
  [<a b c>.Bag, <c d e>.Bag, <d e f>.Bag],         <a b c c d d e e f>.Bag,
  [<a b c>.Mix, <c d e>.Mix, <d e f>.Mix],         <a b c c d d e e f>.Mix,
  [<a b c>.Set, <c d e>.Set, <d e f>.Bag],         <a b c c d d e e f>.Bag,
  [<a b c>.Set, <c d e>.Set, <d e f>.Mix],         <a b c c d d e e f>.Mix,
  [<a b c>.Set, <c d e>.Bag, <d e f>.Mix],         <a b c c d d e e f>.Mix,

  [<a b c>, <c d e>, <d e f>],                     <a b c c d d e e f>.Bag,
  [<a b c>, <c d e>, <d e f>.Set],                 <a b c c d d e e f>.Bag,
  [<a b c>, <c d e>, <d e f>.Bag],                 <a b c c d d e e f>.Bag,
  [<a b c>, <c d e>, <d e f>.Mix],                 <a b c c d d e e f>.Mix,
  [<a b c>, <c d e>.Bag, <d e f>.Mix],             <a b c c d d e e f>.Mix,

  [{:a,:b,:c}, {:b,:c,:d}, {:c,:d,:e}],            <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Set],           <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Bag],           <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, {:b,:c,:d}, <c d e>.Mix],           <a b b c c c d d e>.Mix,

  [{:a,:b,:c}, <b c d>, {:c,:d,:e}],               <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Set],              <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Bag],              <a b b c c c d d e>.Bag,
  [{:a,:b,:c}, <b c d>, <c d e>.Mix],              <a b b c c c d d e>.Mix,

  [(:2a).Bag, (:7a).Bag, (:3a).Bag],               (:12a).Bag,
  [(:20a).Bag, bag(), (:22a).Bag],                 (:42a).Bag,
  [(a=>-21).Mix, <a>.Mix, (:2a).Mix],              (a=>-18).Mix,
  [(a=>-42).Mix, set(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, bag(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, mix(), (:42a).Mix],               mix(),
  [(a=>-42).Mix, <b>.Set, (:42a).Bag],             <b>.Mix,
  [(a=>-42).Mix, <b>.Bag, (:42a).Bag],             <b>.Mix,
  [(a=>-42).Mix, <b>.Mix, (:42a).Bag],             <b>.Mix,

  <a b c>,                                         <a b c>.Bag,
;

plan 2 * (3 + 3 * @types + @pairs/2 + @triplets/3 + 6 * @quads/2) + 4;

# addition
for
  &infix:<(+)>, "(+)",
  &infix:<⊎>,     "⊎"
-> &op, $name {

    is-deeply op(), bag(), "does $name\() return bag()";

    throws-like { op(1,Failure.new) }, Exception,
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";

    for @types -> \qh {
        is-deeply
          op(qh.new,qh.new,qh.new),
          (qh ~~ Set ?? Bag !! qh ~~ SetHash ?? BagHash !! qh).new,
          "Sequence of empty {qh.^name} is the empty {qh.^name}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new $name lazy list";
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new(<a b c>) $name lazy list";
    }

    for @pairs -> $parameter, $result {
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>($parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
#?rakudo.js.browser todo "broken on all backends when precompiling"
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

# https://github.com/rakudo/rakudo/issues/3945
{
    is-deeply (1..3, 1..3 Z(+) 2..4, 1..4),
      ((1,2,2,3,3,4).Bag, (1,1,2,2,3,3,4).Bag),
      'did Z handle (+) correctly (1)';

    is-deeply (1..3, 1..3 Z⊎ 2..4, 1..4),
      ((1,2,2,3,3,4).Bag, (1,1,2,2,3,3,4).Bag),
      'did Z handle ⊎ correctly (1)';

    is-deeply (1..3, 1..3 Z(+) 2..4, 1..4 Z(+) 3..5, 2..3),
      ((1,2,2,3,3,3,4,4,5).Bag, (1,1,2,2,2,3,3,3,4).Bag),
      'did Z handle (+) correctly (2)';

    is-deeply (1..3, 1..3 Z⊎ 2..4, 1..4 Z⊎ 3..5, 2..3),
      ((1,2,2,3,3,3,4,4,5).Bag, (1,1,2,2,2,3,3,3,4).Bag),
      'did Z handle ⊎ correctly (2)';
}

# vim: expandtab shiftwidth=4
