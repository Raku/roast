use v6;
use Test;

# This test file tests the following set operators:
#   (^)     set symmetric difference (ASCII)
#   ⊖       set symmetric difference

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
  <a b>.Set,                    <c d>.Set,         <a b c d>.Set,
  <a b c>.Set,                  <b c d>.Set,       <a d>.Set,
  <a b>.SetHash,                <c d>.SetHash,     <a b c d>.Set,
  <a b c>.SetHash,              <b c d>.SetHash,   <a d>.Set,

  # result should be a Bag
  bag(),                        bag(),             bag(),
  BagHash.new,                  BagHash.new,       bag(),
  $ebh,                         $ebh,              bag(),
  <a b b>.Bag,                  bag(),             <a b b>.Bag,
  <a b b>.BagHash,              bag(),             <a b b>.Bag,
  <a b b>.Bag,                  <a b>.Bag,         <b>.Bag,
  <a b b>.BagHash,              <a b>.BagHash,     <b>.Bag,
  <a b b>.Bag,                  <c d>.Bag,         <a b b c d>.Bag,
  <a b b c>.Bag,                <b c d>.Bag,       <a b d>.Bag,
  <a b b>.BagHash,              <c d>.BagHash,     <a b b c d>.Bag,
  <a b b c>.BagHash,            <b c d>.BagHash,   <a b d>.Bag,

  # result should be a Mix
  mix(),                        mix(),         mix(),
  MixHash.new,                  MixHash.new,   mix(),
  $emh,                         $emh,          mix(),
  mix(),                        <a b>.Mix,     <a b>.Mix,
  MixHash.new,                  <a b>.MixHash, <a b>.Mix,
  (a=>-pi).Mix,                 mix(),         (a=>pi).Mix,
  (a=>-pi).MixHash,             mix(),         (a=>pi).Mix,
  (a=>pi,b=>tau).Mix,           mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).MixHash,       mix(),         (a=>pi,b=>tau).Mix,
  (a=>pi,b=>tau).Mix,           <a b>.Mix,     (a=>(pi-1),b=>(tau-1)).Mix,
  (a=>pi,b=>tau).MixHash,       <a b>.MixHash, (a=>(pi-1),b=>(tau-1)).Mix,
  (a=>pi,b=>tau).Mix,           <c d>.Mix,     (a=>pi,b=>tau,:c,:d).Mix,
  (a=>pi,b=>tau).Mix,           <b c>.Mix,     (a=>pi,b=>(tau-1),:c).Mix,
  (a=>pi,b=>tau).MixHash,       <c d>.MixHash, (a=>pi,b=>tau,:c,:d).Mix,
  (a=>pi,b=>tau).MixHash,       <b c>.MixHash, (a=>pi,b=>(tau-1),:c).Mix,

  # coercions
  <a b>.Set,                    <a b b>.Bag,       <b>.Bag,
  <a b>.SetHash,                <a b b>.BagHash,   <b>.Bag,

  <a b>.Set,                    <a b b>.Mix,       <b>.Mix,
  <a b>.SetHash,                <a b b>.MixHash,   <b>.Mix,

  <a b>.Set,                    (b=>-1).Mix,       <a b b>.Mix,
  <a b>.SetHash,                (b=>-1).MixHash,   <a b b>.Mix,

  <a b>.Bag,                    <a b b>.Mix,       <b>.Mix,
  <a b>.BagHash,                <a b b>.MixHash,   <b>.Mix,

  <a b>.Bag,                    (b=>-1).Mix,       <a b b>.Mix,
  <a b>.BagHash,                (b=>-1).MixHash,   <a b b>.Mix,

  <a b c>.Set,                  {:42a,:0b},        <b c>.Set,
  <a b c>.SetHash,              {:42a,:0b},        <b c>.Set,
  <a b b c>.Bag,                {:42a,:0b},        (:41a,:2b,:c).Bag,
  <a b b c>.BagHash,            {:42a,:0b},        (:41a,:2b,:c).Bag,
  <a b b c>.Mix,                {:42a,:0b},        (:41a,:2b,:c).Mix,
  <a b b c>.MixHash,            {:42a,:0b},        (:41a,:2b,:c).Mix,

  {:42a,:0b},                   <a b c>.Set,       <b c>.Set,
  {:42a,:0b},                   <a b c>.SetHash,   <b c>.Set,
  {:42a,:0b},                   <a b b c>.Bag,     (:41a,:2b,:c).Bag,
  {:42a,:0b},                   <a b b c>.BagHash, (:41a,:2b,:c).Bag,
  {:42a,:0b},                   <a b b c>.Mix,     (:41a,:2b,:c).Mix,
  {:42a,:0b},                   <a b b c>.MixHash, (:41a,:2b,:c).Mix,

  <a b c>.Set,                  <a b c d>,         <d>.Set,
  <a b c>.SetHash,              <a b c d>,         <d>.Set,
  <a b b c>.Bag,                <a b c d>,         <b d>.Bag,
  <a b b c>.BagHash,            <a b c d>,         <b d>.Bag,
  <a b b c>.Mix,                <a b c d>,         <b d>.Mix,
  <a b b c>.MixHash,            <a b c d>,         <b d>.Mix,

  <a b c d>,                    <a b c e>.Set,     <d e>.Set,
  <a b c d>,                    <a b c e>.SetHash, <d e>.Set,
  <a b c d>,                    <a b c e>.Bag,     <d e>.Bag,
  <a b c d>,                    <a b c e>.BagHash, <d e>.Bag,
  <a b c d>,                    <a b c e>.Mix,     <d e>.Mix,
  <a b c d>,                    <a b c e>.MixHash, <d e>.Mix,

  <a b c>,                      <c d e>,           <a b d e>.Set,
  (:42a,:0b,:c),                (:c,:42d,"e"),     <a d e>.Set,
  (:b,:c,:42d,"e"),             (:42a,:0b,:c),     <a b d e>.Set,
  (:42a,:0b),                   (:a,:42d,"e"),     <d e>.Set,
  {:42a,:0b},                   {:a,:c,:42d},      <c d>.Set,
  :{42=>"a",666=>""},           :{55=>"c",66=>1},  (42,55,66).Set,
  :{42=>"a",666=>""},           :{55=>"c",666=>1}, (42,55,666).Set,
  :{42=>"a",666=>""},           :{42=>"c",666=>1}, 666.Set,
  :{42=>"a",666=>""},           {:c,:42d},         (42,"c","d").Set,
  :{a=>42,666=>""},             {:a,:42d},         <d>.Set,
  {:42a,:0b},                   <c d e>,           <a c d e>.Set,
  {:42a,:0b},                   <a d e>,           <d e>.Set,
  :{42=>"a",666=>""},           <a b c>,           (42,"a","b","c").Set,
  :{a=>42,666=>""},             <a b c>,           <b c>.Set,
  42,                           666,               (42,666).Set,
;

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <c d e>.Set, <e f g>.Set],         <a b d f g>.Set,
  [<a b c>.Bag, <c d e>.Bag, <e f g>.Bag],         <a b d f g>.Bag,
  [<a b c>.Mix, <c d e>.Mix, <e f g>.Mix],         <a b d f g>.Mix,
  [<a b c>.Set, <c d e>.Set, <e f g>.Bag],         <a b d f g>.Bag,
  [<a b c>.Set, <c d e>.Set, <e f g>.Mix],         <a b d f g>.Mix,
  [<a b c>.Set, <c d e>.Bag, <e f g>.Mix],         <a b d f g>.Mix,

  [<a b c>, <c d e>, <e f g>],                     <a b d f g>.Set,
  [<a b c>, <c d e>, <e f g>.Set],                 <a b d f g>.Set,
  [<a b c>, <c d e>, <e f g>.Bag],                 <a b d f g>.Bag,
  [<a b c>, <c d e>, <e f g>.Mix],                 <a b d f g>.Mix,
  [<a b c>, <c d e>.Bag, <e f g>.Mix],             <a b d f g>.Mix,

  [{:a,:b,:c}, {:c,:d,:e}, {:e,:f,:g}],            <a b d f g>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Set],           <a b d f g>.Set,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Bag],           <a b d f g>.Bag,
  [{:a,:b,:c}, {:c,:d,:e}, <e f g>.Mix],           <a b d f g>.Mix,

  [{:a,:b,:c}, <c d e>, {:e,:f,:g}],               <a b d f g>.Set,
  [{:a,:b,:c}, <c d e>, <e f g>.Set],              <a b d f g>.Set,
  [{:a,:b,:c}, <c d e>, <e f g>.Bag],              <a b d f g>.Bag,
  [{:a,:b,:c}, <c d e>, <e f g>.Mix],              <a b d f g>.Mix,

  [(:42a).Bag, (:7a).Bag, (:43a).Bag],             <a>.Bag,
  [(:42a).Bag, bag(), (:43a).Bag],                 <a>.Bag,
  [(a=>-42).Mix, <a>.Mix, (:42a).Mix],             (:41a).Mix,
  [(a=>-42).Mix, set(), (:42a).Mix],               (:42a).Mix,
  [(a=>-42).Mix, bag(), (:42a).Mix],               (:42a).Mix,
  [(a=>-42).Mix, mix(), (:42a).Mix],               (:42a).Mix,
  [(a=>-42).Mix, <b>.Set, (:42a).Bag],             (:42a,:b).Mix,
  [(a=>-42).Mix, <b>.Bag, (:42a).Bag],             (:42a,:b).Mix,
  [(a=>-42).Mix, <b>.Mix, (:42a).Bag],             (:42a,:b).Mix,

  <a b c>,                                         <a b c>.Set,
;

plan 2 * (1 + 3 * @types + @pairs/2 + 2 * @triplets/3 + 6 * @quads/2);

# symmetric difference
for
  &infix:<(^)>, "(^)",
  &infix:<⊖>,     "⊖"
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
#exit dd $parameter, $result unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
    }

    for @triplets -> $left, $right, $result {
#exit dd $left, $right, $result unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
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
