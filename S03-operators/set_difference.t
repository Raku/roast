use v6;
use Test;

# This test file tests the following set operators:
#   (-)     set difference (Texas)
#   ∖       set difference

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
  <a b>.Set,                    <a b>.Set,         set(),
  <a b>.SetHash,                <a b>.SetHash,     set(),
  <a b>.Set,                    <c d>.Set,         <a b>.Set,
  <a b c>.Set,                  <b c d>.Set,       <a>.Set,
  <a b>.SetHash,                <c d>.SetHash,     <a b>.Set,
  <a b c>.SetHash,              <b c d>.SetHash,   <a>.Set,

  # result should be a Bag
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             <a b b>.Bag,
  <a b b>.BagHash,              bag(),             <a b b>.Bag,
  <a b b>.Bag,                  <a b>.Bag,         <b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         <a b b>.Bag,
  <a b b c>.Bag,                <b c d>.Bag,       <a b>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     <a b b>.Bag,
  <a b b c>.BagHash,            <b c d>.BagHash,   <a b>.Bag,

  # result should be a Mix
  mix(),                        mix(),         mix(),
  MixHash.new,                  MixHash.new,   mix(),
  $emh,                         $emh,          mix(),
  mix(),                        <a b>.Mix,     (a=>-1,b=>-1).Mix,
  MixHash.new,                  <a b>.MixHash, (a=>-1,b=>-1).Mix,
  (a=>pi,b=>tau).Mix,           mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>(pi-1),b=>(tau-1)).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>(pi-1),b=>(tau-1)).Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     (a=>pi,b=>tau,c=>-1,d=>-1).Mix,
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (a=>pi,b=>(tau-1),c=>-1).Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, (a=>pi,b=>tau,c=>-1,d=>-1).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (a=>pi,b=>(tau-1),c=>-1).Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       bag(),
  <a b>.SetHash,                <a b b>.BagHash,   bag(),
  <a b b>.Bag,                  <a b>.Set,         <b>.Bag,
  <a b b>.BagHash,              <a b>.SetHash,     <b>.Bag,

  <a b>.Set,                    <a b b>.Mix,       (b=>-1).Mix,
  <a b>.SetHash,                <a b b>.MixHash,   (b=>-1).Mix,
  <a b b>.Mix,                  <a b>.Set,         <b>.Mix,
  <a b b>.MixHash,              <a b>.SetHash,     <b>.Mix,

  <a b>.Set,                    (b=>-1).Mix,       <a b b>.Mix,
  <a b>.SetHash,                (b=>-1).MixHash,   <a b b>.Mix,
  (b=>-1).Mix,                  <a b>.Set,         (a=>-1,b=>-2).Mix,
  (b=>-1).MixHash,              <a b>.SetHash,     (a=>-1,b=>-2).Mix,

  <a b>.Bag,                    <a b b>.Mix,       (b=>-1).Mix,
  <a b>.BagHash,                <a b b>.MixHash,   (b=>-1).Mix,
  <a b>.Mix,                    <a b b>.Bag,       (b=>-1).Mix,
  <a b>.MixHash,                <a b b>.BagHash,   (b=>-1).Mix,

  <a b>.Bag,                    (b=>-1).Mix,       <a b b>.Mix,
  <a b>.BagHash,                (b=>-1).MixHash,   <a b b>.Mix,
  (b=>-1).Mix,                  <a b b>.Bag,       (a=>-1,b=>-3).Mix,
  (b=>-1).MixHash,              <a b b>.BagHash,   (a=>-1,b=>-3).Mix,

  <a b c>.Set,                  {:42a,:0b},        <b c>.Set,
  <a b c>.SetHash,              {:42a,:0b},        <b c>.Set,
  <a b b c>.Bag,                {:42a,:0b},        <b b c>.Bag,
  <a b b c>.BagHash,            {:42a,:0b},        <b b c>.Bag,
  <a b b c>.Mix,                {:42a,:0b},        <b b c>.Mix,
  <a b b c>.MixHash,            {:42a,:0b},        <b b c>.Mix,

  {:42a,:0b},                   <a b c>.Set,       set(),
  {:42a,:0b},                   <a b c>.SetHash,   set(),
  {:42a,:0b},                   <a b b c>.Bag,     (:41a).Bag,
  {:42a,:0b},                   <a b b c>.BagHash, (:41a).Bag,
  {:42a,:0b},                   <a b b c>.Mix,     (:41a,b=>-2,c=>-1).Mix,
  {:42a,:0b},                   <a b b c>.MixHash, (:41a,b=>-2,c=>-1).Mix,

  <a b c>.Set,                  <a b c d>,         set(),
  <a b c>.SetHash,              <a b c d>,         set(),
  <a b b c>.Bag,                <a b c d>,         <b>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <b>.Bag,
  <a b b c>.Mix,                <a b c d>,         (b=>1,d=>-1).Mix,
  <a b b c>.MixHash,            <a b c d>,         (b=>1,d=>-1).Mix,

  <a b c d>,                    <a b c e>.Set,     <d>.Set,
  <a b c d>,                    <a b c e>.SetHash, <d>.Set,
  <a b c d>,                    <a b c e>.Bag,     <d>.Bag,
  <a b c d>,                    <a b c e>.BagHash, <d>.Bag,
  <a b c d>,                    <a b c e>.Mix,     (d=>1,e=>-1).Mix,
  <a b c d>,                    <a b c e>.MixHash, (d=>1,e=>-1).Mix,

  <a b c>,                      <c d e>,           <a b>.Set,
  (:42a,:0b,:c),                (:c,:42d,"e"),     <a>.Set,
  (:b,:c,:42d,"e"),             (:42a,:0b,:c),     <b d e>.Set,
  (:42a,:0b),                   (:a,:42d,"e"),     set(),
  {:42a,:0b},                   {:a,:c,:42d},      set(),
  :{42=>"a",666=>""},           :{55=>"c",66=>1},  42.Set,
  :{42=>"a",666=>""},           :{55=>"c",666=>1}, 42.Set,
  :{42=>"a",666=>""},           :{42=>"c",666=>1}, set(),
  :{42=>"a",666=>""},           {:c,:42d},         42.Set,
  :{a=>42,666=>""},             {:a,:42d},         set(),
  {:42a,:0b},                   <c d e>,           <a>.Set,
  {:42a,:0b},                   <a d e>,           set(),
  :{42=>"a",666=>""},           <a b c>,           42.Set,
  :{a=>42,666=>""},             <a b c>,           set(),
  42,                           666,               42.Set,
;

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <c d e>.Set, <e f>.Set],       <a b>.Set,
  [<a b c>.Bag, <c d e>.Bag, <e f>.Bag],       <a b>.Bag,
  [<a b c>.Mix, <c d e>.Mix, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,
  [<a b c>.Set, <c d e>.Set, <e f>.Bag],       <a b>.Bag,
  [<a b c>.Set, <c d e>.Set, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,
  [<a b c>.Set, <c d e>.Bag, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,

  [<a b c>, <c d e>, <e f>],                   <a b>.Set,
  [<a b c>, <c d e>, <e f>.Set],               <a b>.Set,
  [<a b c>, <c d e>, <e f>.Bag],               <a b>.Bag,
  [<a b c>, <c d e>, <e f>.Mix],               (:a,:b,d=>-1,e=>-2,f=>-1).Mix,
  [<a b c>, <c d e>.Bag, <e f>.Mix],           (:a,:b,d=>-1,e=>-2,f=>-1).Mix,

  [{:a,:b,:c}, {:c,:d,:e}, {:e,:f}],           <a b>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Set],         <a b>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Bag],         <a b>.Bag,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Mix],         (:a,:b,d=>-1,e=>-2,f=>-1).Mix,

  [{:a,:b,:c}, <c d e>, {:e,:f}],              <a b>.Set,
  [{:a,:b,:c}, <c d e>, <e f>.Set],            <a b>.Set,
  [{:a,:b,:c}, <c d e>, <e f>.Bag],            <a b>.Bag,
  [{:a,:b,:c}, <c d e>, <e f>.Mix],            (:a,:b,d=>-1,e=>-2,f=>-1).Mix,

  [(:42a).Bag, (:7a).Bag, (:41a).Bag],         bag(),
  [(:42a).Bag, bag(), (:41a).Bag],             <a>.Bag,
  [(a=>-42).Mix, <a>.Mix, (:42a).Mix],         (a=>-85).Mix,
  [(a=>-42).Mix, set(), (:42a).Mix],           (a=>-84).Mix,
  [(a=>-42).Mix, bag(), (:42a).Mix],           (a=>-84).Mix,
  [(a=>-42).Mix, mix(), (:42a).Mix],           (a=>-84).Mix,
  [(a=>-42).Mix, <b>.Set, (a=>-42).Mix],       (b=>-1).Mix,
  [(a=>-42).Mix, <b>.Bag, (a=>-42).Mix],       (b=>-1).Mix,
  [(a=>-42).Mix, <b>.Mix, (a=>-42).Mix],       (b=>-1).Mix,

  <a b c>,                                     <a>.Set,
;

plan 2 * (1 + 3 * @types + @pairs/2 + @triplets/3 + @quads/2);

# difference
for
  &infix:<(-)>, "(-)",
  &infix:<∖>,     "∖"
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
#exit dd $parameters, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
    }

    for @quads -> @params, $result {
exit dd @params, $result unless
        is-deeply op(|@params), $result,
          "[$name] @params>>.gist()";
    }
}

# vim: ft=perl6
