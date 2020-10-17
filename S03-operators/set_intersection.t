use v6;
use Test;

# This test file tests the following set operators:
#   (&)     intersection (ASCII)
#   ∩       intersection

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Set,
  <a b c>.SetHash,    <a b c>.SetHash,
  <a b c>.Bag,        <a b c>.Bag,
  <a b c>.BagHash,    <a b c>.BagHash,
  <a b c>.Mix,        <a b c>.Mix,
  <a b c>.MixHash,    <a b c>.MixHash,
  <a b c>,            <a b c>.Set,
  {:42a,:0b},         <a>.Set,
  :{:42a,:0b},        <a>.Set,
  42,                 42.Set,
;

# two parameters, result
my @triplets =

  # result should be a Set(Hash)
  Set,                          Set,               set(Set),
  Bag,                          Bag,               set(Bag),
  Mix,                          Mix,               set(Mix),
  Set,                          set(),             set(),
  set(),                        Set,               set(),
  set(),                        set(),             set(),
  SetHash.new,                  set(),             SetHash.new,
  set(),                        SetHash.new,       set(),
  SetHash.new,                  SetHash.new,       SetHash.new,
  $esh,                         set(),             SetHash.new,
  set(),                        $esh,              set(),
  $esh,                         $esh,              SetHash.new,

  <a b>.Set,                    set(),             set(),
  <a b>.SetHash,                set(),             SetHash.new,
  <a b>.Set,                    <a b>.Set,         <a b>.Set,
  <a b>.SetHash,                <a b>.SetHash,     <a b>.SetHash,
  <a b>.Set,                    <c d>.Set,         set(),
  <a b c>.Set,                  <b c d>.Set,       <b c>.Set,
  <a b>.SetHash,                <c d>.SetHash,     SetHash.new,
  <a b c>.SetHash,              <b c d>.SetHash,   <b c>.SetHash,

  # result should be a Bag(Hash)
  Bag,                          bag(),             bag(),
  bag(),                        Bag,               bag(),
  bag(),                        bag(),             bag(),
  BagHash.new,                  bag(),             BagHash.new,
  bag(),                        BagHash.new,       bag(),
  BagHash.new,                  BagHash.new,       BagHash.new,
  $ebh,                         bag(),             BagHash.new,
  bag(),                        $ebh,              bag(),
  $ebh,                         $ebh,              BagHash.new,

  <a b b>.Bag,                  bag(),             bag(),
  <a b b>.BagHash,              bag(),             BagHash.new,
  <a b b>.Bag,                  <a b>.Bag,         <a b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <a b>.BagHash,
  <a b b>.Bag,                  <c d>.Bag,         bag(),
  <a b b c>.Bag,                <b c d>.Bag,       <b c>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     BagHash.new,
  <a b b c>.BagHash,            <b c d>.BagHash,   <b c>.BagHash,

  # result should be a Mix(Hash)
  Mix,                          mix(),             mix(),
  mix(),                        Mix,               mix(),
  mix(),                        mix(),             mix(),
  MixHash.new,                  mix(),             MixHash.new,
  mix(),                        MixHash.new,       mix(),
  MixHash.new,                  MixHash.new,       MixHash.new,
  $emh,                         mix(),             MixHash.new,
  mix(),                        $emh,              mix(),
  $emh,                         $emh,              MixHash.new,

  (a=>pi,b=>tau).Mix,           mix(),             mix(),
  (a=>pi,b=>tau).MixHash,       mix(),             MixHash.new,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,         <a b>.Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash,     <a b>.MixHash,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,         mix(),
  (a=>pi,b=>tau).Mix,           <b c>.Mix,         <b>.Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash,     MixHash.new,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash,     <b>.MixHash,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <a b>.Bag,
  <a b>.Set,                    <a b b>.BagHash,   <a b>.Bag,
  <a b>.SetHash,                <a b b>.Bag,       <a b>.BagHash,
  <a b>.SetHash,                <a b b>.BagHash,   <a b>.BagHash,

  <a b>.Bag,                    <a b b>.Mix,       <a b>.Mix,
  <a b>.Bag,                    <a b b>.MixHash,   <a b>.Mix,
  <a b>.BagHash,                <a b b>.Mix,       <a b>.MixHash,
  <a b>.BagHash,                <a b b>.MixHash,   <a b>.MixHash,

  <a b c>.Set,                  <a b c d>,         <a b c>.Set,
  <a b c>.SetHash,              <a b c d>,         <a b c>.SetHash,
  <a b c>.Bag,                  <a b c d>,         <a b c>.Bag,
  <a b c>.BagHash,              <a b c d>,         <a b c>.BagHash,
  <a b c>.Mix,                  <a b c d>,         <a b c>.Mix,
  <a b c>.MixHash,              <a b c d>,         <a b c>.MixHash,

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

plan 2 * (3 + 3 * @types + @pairs/2 + @triplets/3 + 6 * @quads/2) + 4;

# intersection
for
  &infix:<(&)>,   "(&)",
  &infix:<∩>,       "∩"
-> &op, $name {

    is-deeply op(), set(), "does $name\() return set()";

    for @types -> \qh {
#exit dd qh unless
        is-deeply op(qh.new,qh.new,qh.new), qh.new,
          "Sequence of empty {qh.^name} is the empty {qh.^name}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new $name lazy list";
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new(<a b c>) $name lazy list";
    }

    for @pairs -> $parameter, $result {
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
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

    throws-like { op(1,Failure.new) }, Exception,
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";
}

# https://github.com/rakudo/rakudo/issues/3945
{
    is-deeply (1..3, 1..3 Z(&) 2..4, 1..4),
      ((2,3).Set, (1,2,3).Set),
      'did Z handle (&) correctly (1)';

    is-deeply (1..3, 1..3 Z∩ 2..4, 1..4),
      ((2,3).Set, (1,2,3).Set),
      'did Z handle ∩ correctly (1)';

    is-deeply (1..3, 1..3 Z(&) 2..4, 1..4 Z(&) 1..2, 3..4),
      ((2,).Set, (3,).Set),
      'did Z handle (&) correctly (2)';

    is-deeply (1..3, 1..3 Z∩ 2..4, 1..4 Z∩ 1..2, 3..4),
      ((2,).Set, (3,).Set),
      'did Z handle ∩ correctly (2)';
}

# vim: expandtab shiftwidth=4
