use Test;

# This test file tests the following set operators:
#   (-)     set difference (ASCII)
#   ∖       set difference

# Empty mutables that have the internal hash allocated
(my $esh = <a>.SetHash)<a>:delete;
(my $ebh = <a>.BagHash)<a>:delete;
(my $emh = <a>.MixHash)<a>:delete;

my @types = Set, SetHash, Bag, BagHash, Mix, MixHash;

# single parameter, result
my @pairs =
  <a b c>.Set,        <a b c>.Set, $?LINE,
  <a b c>.SetHash,    <a b c>.Set, $?LINE,
  <a b c>.Bag,        <a b c>.Bag, $?LINE,
  <a b c>.BagHash,    <a b c>.Bag, $?LINE,
  <a b c>.Mix,        <a b c>.Mix, $?LINE,
  <a b c>.MixHash,    <a b c>.Mix, $?LINE,
  {:42a},             <a>.Set,     $?LINE,
  {:42a,:0b},         <a>.Set,     $?LINE,
  :{:42a},            <a>.Set,     $?LINE,
  :{:42a,:0b},        <a>.Set,     $?LINE,
  <a b c>,            <a b c>.Set, $?LINE,
  ("a","b",:0c),      <a b>.Set,   $?LINE,
  42,                 42.Set,      $?LINE,
  :0b,                set(),       $?LINE,
;

# two parameters, result
my @triplets =

  # result should be a Set
  set(),                     set(),             set(),       $?LINE,
  SetHash.new,               set(),             SetHash.new, $?LINE,
  set(),                     SetHash.new,       set(),       $?LINE,
  SetHash.new,               SetHash.new,       SetHash.new, $?LINE,
  $esh,                      set(),             SetHash.new, $?LINE,
  set(),                     $esh,              set(),       $?LINE,
  $esh,                      $esh,              SetHash.new, $?LINE,

  <a b>.Set,                 set(),             <a b>.Set,     $?LINE,
  <a b>.SetHash,             set(),             <a b>.SetHash, $?LINE,
  <a b>.Set,                 <a b>.Set,         set(),         $?LINE,
  <a b>.SetHash,             <a b>.SetHash,     SetHash.new,   $?LINE,
  <a b>.Set,                 <c d>.Set,         <a b>.Set,     $?LINE,
  <a b c>.Set,               <b c d>.Set,       <a>.Set,       $?LINE,
  <a b>.SetHash,             <c d>.SetHash,     <a b>.SetHash, $?LINE,
  <a b c>.SetHash,           <b c d>.SetHash,   <a>.SetHash,   $?LINE,

  # result should be a Bag
  bag(),                     bag(),             bag(),       $?LINE,
  BagHash.new,               bag(),             BagHash.new, $?LINE,
  bag(),                     BagHash.new,       bag(),       $?LINE,
  BagHash.new,               BagHash.new,       BagHash.new, $?LINE,
  $ebh,                      bag(),             BagHash.new, $?LINE,
  bag(),                     $ebh,              bag(),       $?LINE,
  $ebh,                      $ebh,              BagHash.new, $?LINE,

  <a b b>.Bag,               bag(),             <a b b>.Bag,     $?LINE,
  <a b b>.BagHash,           bag(),             <a b b>.BagHash, $?LINE,
  <a b b>.Bag,               <a b>.Bag,         <b>.Bag,         $?LINE,
  <a b b>.BagHash,           <a b>.BagHash,     <b>.BagHash,     $?LINE,
  <a b b>.Bag,               <c d>.Bag,         <a b b>.Bag,     $?LINE,
  <a b b c>.Bag,             <b c d>.Bag,       <a b>.Bag,       $?LINE,
  <a b b>.BagHash,           <c d>.BagHash,     <a b b>.BagHash, $?LINE,
  <a b b c>.BagHash,         <b c d>.BagHash,   <a b>.BagHash,   $?LINE,
  # https://github.com/Raku/old-issue-tracker/issues/6679
  <a a a b>.Bag,             <a a>,             <a b>.Bag,       $?LINE,

  # result should be a Mix
  mix(),                     mix(),         mix(),       $?LINE,
  MixHash.new,               mix(),         MixHash.new, $?LINE,
  mix(),                     MixHash.new,   mix(),       $?LINE,
  MixHash.new,               MixHash.new,   MixHash.new, $?LINE,
  $emh,                      mix(),         MixHash.new, $?LINE,
  mix(),                     $emh,          mix(),       $?LINE,
  $emh,                      $emh,          MixHash.new, $?LINE,

  mix(),                     <a b>.Mix,     (a=>-1,b=>-1).Mix,                  $?LINE,
  MixHash.new,               <a b>.MixHash, (a=>-1,b=>-1).MixHash,              $?LINE,
  (a=>pi,b=>tau).Mix,        mix(),         (a=>pi,b=>tau).Mix,                 $?LINE,
  (a=>pi,b=>tau).Mix,        mix(),         (a=>pi,b=>tau).Mix,                 $?LINE,
#  (a=>pi,b=>tau).MixHash,    mix(),         (a=>pi,b=>tau).MixHash,             $?LINE,
  (a=>pi,b=>tau).Mix,        <a b>.Mix,     (a=>(pi-1),b=>(tau-1)).Mix,         $?LINE,
#  (a=>pi,b=>tau).MixHash,    <a b>.MixHash, (a=>(pi-1),b=>(tau-1)).MixHash,     $?LINE,
  (a=>pi,b=>tau).Mix,        <c d>.Mix,     (a=>pi,b=>tau,c=>-1,d=>-1).Mix,     $?LINE,
#  (a=>pi,b=>tau).Mix,        <b c>.Mix,     (a=>pi,b=>(tau-1),c=>-1).Mix,       $?LINE,
  (a=>pi,b=>tau).MixHash,    <c d>.MixHash, (a=>pi,b=>tau,c=>-1,d=>-1).MixHash, $?LINE,
#  (a=>pi,b=>tau).MixHash,    <b c>.MixHash, (a=>pi,b=>(tau-1),c=>-1).MixHash,   $?LINE,

  # coercions
  <a b>.Set,                 <a b b>.Bag,       bag(),       $?LINE,
  <a b>.SetHash,             <a b b>.BagHash,   BagHash.new, $?LINE,
  <a b b>.Bag,               <a b>.Set,         <b>.Bag,     $?LINE,
  <a b b>.BagHash,           <a b>.SetHash,     <b>.BagHash, $?LINE,

  <a b>.Set,                 <a b b>.Mix,       (b=>-1).Mix,     $?LINE,
  <a b>.SetHash,             <a b b>.MixHash,   (b=>-1).MixHash, $?LINE,
#  <a b b>.Mix,               <a b>.Set,         <b>.Mix,         $?LINE,
#  <a b b>.MixHash,           <a b>.SetHash,     <b>.MixHash,     $?LINE,

  <a b>.Set,                 (b=>-1).Mix,       <a b b>.Mix,           $?LINE,
  <a b>.SetHash,             (b=>-1).MixHash,   <a b b>.MixHash,       $?LINE,
#  (b=>-1).Mix,               <a b>.Set,         (a=>-1,b=>-2).Mix,     $?LINE,
#  (b=>-1).MixHash,           <a b>.SetHash,     (a=>-1,b=>-2).MixHash, $?LINE,

#  <a b>.Bag,                 <a b b>.Mix,       (b=>-1).Mix,     $?LINE,
  <a b>.BagHash,             <a b b>.MixHash,   (b=>-1).MixHash, $?LINE,
#  <a b>.Mix,                 <a b b>.Bag,       (b=>-1).Mix,     $?LINE,
#  <a b>.MixHash,             <a b b>.BagHash,   (b=>-1).MixHash, $?LINE,

#  <a b>.Bag,                 (b=>-1).Mix,       <a b b>.Mix,           $?LINE,
  <a b>.BagHash,             (b=>-1).MixHash,   <a b b>.MixHash,       $?LINE,
#  (b=>-1).Mix,               <a b b>.Bag,       (a=>-1,b=>-3).Mix,     $?LINE,
#  (b=>-1).MixHash,           <a b b>.BagHash,   (a=>-1,b=>-3).MixHash, $?LINE,

  <a b c>.Set,               {:42a,:0b},        <b c>.Set,       $?LINE,
  <a b c>.SetHash,           {:42a,:0b},        <b c>.SetHash,   $?LINE,
  <a b b c>.Bag,             {:42a,:0b},        <b b c>.Bag,     $?LINE,
  <a b b c>.BagHash,         {:42a,:0b},        <b b c>.BagHash, $?LINE,
#  <a b b c>.Mix,             {:42a,:0b},        <b b c>.Mix,     $?LINE,
#  <a b b c>.MixHash,         {:42a,:0b},        <b b c>.MixHash, $?LINE,

  {:42a,:0b},                <a b c>.Set,       set(),                  $?LINE,
  {:42a,:0b},                <a b c>.SetHash,   set(),                  $?LINE,
  {:42a,:0b},                <a b b c>.Bag,     (:41a).Bag,             $?LINE,
  {:42a,:0b},                <a b b c>.BagHash, (:41a).Bag,             $?LINE,
  {:42a,:0b},                <a b b c>.Mix,     (:41a,b=>-2,c=>-1).Mix, $?LINE,
  {:42a,:0b},                <a b b c>.MixHash, (:41a,b=>-2,c=>-1).Mix, $?LINE,

  <a b c>.Set,               <a b c d>,         set(),                $?LINE,
  <a b c>.SetHash,           <a b c d>,         SetHash.new,          $?LINE,
  <a b b c>.Bag,             <a b c d>,         <b>.Bag,              $?LINE,
  <a b b c>.BagHash,         <a b c d>,         <b>.BagHash,          $?LINE,
#  <a b b c>.Mix,             <a b c d>,         (b=>1,d=>-1).Mix,     $?LINE,
#  <a b b c>.MixHash,         <a b c d>,         (b=>1,d=>-1).MixHash, $?LINE,

  <a b c d>,                 <a b c e>.Set,     <d>.Set,          $?LINE,
  <a b c d>,                 <a b c e>.SetHash, <d>.Set,          $?LINE,
  <a b c d>,                 <a b c e>.Bag,     <d>.Bag,          $?LINE,
  <a b c d>,                 <a b c e>.BagHash, <d>.Bag,          $?LINE,
  <a b c d>,                 <a b c e>.Mix,     (d=>1,e=>-1).Mix, $?LINE,
  <a b c d>,                 <a b c e>.MixHash, (d=>1,e=>-1).Mix, $?LINE,

  <a b c>,                   <c d e>,           <a b>.Set,   $?LINE,
  (:42a,:0b,:c),             (:c,:42d,"e"),     <a>.Set,     $?LINE,
  (:b,:c,:42d,"e"),          (:42a,:0b,:c),     <b d e>.Set, $?LINE,
  (:42a,:0b),                (:a,:42d,"e"),     set(),       $?LINE,
  {:42a,:0b},                {:a,:c,:42d},      set(),       $?LINE,
  :{42=>"a",666=>""},        :{55=>"c",66=>1},  42.Set,      $?LINE,
  :{42=>"a",666=>""},        :{55=>"c",666=>1}, 42.Set,      $?LINE,
  :{42=>"a",666=>""},        :{42=>"c",666=>1}, set(),       $?LINE,
  :{42=>"a",666=>""},        {:c,:42d},         42.Set,      $?LINE,
  :{a=>42,666=>""},          {:a,:42d},         set(),       $?LINE,
  {:42a,:0b},                <c d e>,           <a>.Set,     $?LINE,
  {:42a,:0b},                <a d e>,           set(),       $?LINE,
  :{42=>"a",666=>""},        <a b c>,           42.Set,      $?LINE,
  :{a=>42,666=>""},          <a b c>,           set(),       $?LINE,
  42,                        666,               42.Set,      $?LINE,
;

# List with 3 parameters, result
my @quads =
  [<a b c>.Set, <c d e>.Set, <e f>.Set],       <a b>.Set,                       $?LINE,
  [<a b c>.Bag, <c d e>.Bag, <e f>.Bag],       <a b>.Bag,                       $?LINE,
  [<a b c>.Mix, <c d e>.Mix, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<a b c>.Set, <c d e>.Set, <e f>.Bag],       <a b>.Bag,                       $?LINE,
  [<a b c>.Set, <c d e>.Set, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<a b c>.Set, <c d e>.Bag, <e f>.Mix],       (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [<a b c>, <c d e>, <e f>],                   <a b>.Set,                       $?LINE,
  [<a b c>, <c d e>, <e f>.Set],               <a b>.Set,                       $?LINE,
  [<a b c>, <c d e>, <e f>.Bag],               <a b>.Bag,                       $?LINE,
  [<a b c>, <c d e>, <e f>.Mix],               (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,
  [<a b c>, <c d e>.Bag, <e f>.Mix],           (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [{:a,:b,:c}, {:c,:d,:e}, {:e,:f}],           <a b>.Set,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Set],         <a b>.Set,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Bag],         <a b>.Bag,                       $?LINE,
  [{:a,:b,:c}, {:c,:d,:e}, <e f>.Mix],         (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [{:a,:b,:c}, <c d e>, {:e,:f}],              <a b>.Set,                       $?LINE,
  [{:a,:b,:c}, <c d e>, <e f>.Set],            <a b>.Set,                       $?LINE,
  [{:a,:b,:c}, <c d e>, <e f>.Bag],            <a b>.Bag,                       $?LINE,
  [{:a<a>,:b<b>,:c<c>}, <c d e>, <e f>.Mix],   (:a,:b,d=>-1,e=>-2,f=>-1).Mix,   $?LINE,

  [(:42a).Bag, (:7a).Bag, (:41a).Bag],         bag(),        $?LINE,
  [(:42a).Bag, bag(), (:41a).Bag],             <a>.Bag,      $?LINE,
  [(a=>-42).Mix, <a>.Mix, (:42a).Mix],         (a=>-85).Mix, $?LINE,
  [(a=>-42).Mix, set(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, bag(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, mix(), (:42a).Mix],           (a=>-84).Mix, $?LINE,
  [(a=>-42).Mix, <b>.Set, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,
  [(a=>-42).Mix, <b>.Bag, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,
  [(a=>-42).Mix, <b>.Mix, (a=>-42).Mix],       (b=>-1).Mix,  $?LINE,

  <a b c>,                                     <a>.Set, $?LINE,

  [<a>.Set,<a>.Set,<a>.Set,(a=>-2).Mix],       <a>.Mix, $?LINE,
;

plan 2 * (3 + 3 * @types + @pairs/3 + @triplets/4 + @quads/3) + 5;

# difference
for
  &infix:<(-)>, "(-)",
  &infix:<∖>,     "∖"
-> &op, $name {

    is-deeply op(), set(), "does $name\() return set()";

    for @types -> \qh {
        is-deeply op(qh.new,qh.new,qh.new), qh.new,
          "Sequence of empty {qh.^name} is the empty {qh.^name}";
        throws-like { op(qh.new,^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new $name lazy list";
        throws-like { op(qh.new(<a b c>),^Inf) }, X::Cannot::Lazy,
          "Cannot {qh.raku}.new(<a b c>) $name lazy list";
    }

    for @pairs -> $parameter, $result, $line {
#exit dd :$parameter, :$result, :$line unless
        is-deeply op($parameter.item), $result,
          "infix:<$name>(|$parameter.gist())";
    }

    for @triplets -> $left, $right, $result, $line {
#exit dd :$left, :$right, :$result, :$line unless
        is-deeply op($left,$right), $result,
          "$left.gist() $name $right.gist()";
    }

    for @quads -> @params, $result, $line {
#exit dd :@params, :$result, :$line unless
        is-deeply op(|@params), $result,
          "[$name] @params>>.gist()";
    }

    throws-like { op(1,Failure.new) }, Exception,
      "$name with a Failure:D on the RHS throws";
    throws-like { op(Failure.new,^3) }, Exception,
      "$name with a Failure:D on the LHS throws";
}

# https://github.com/rakudo/rakudo/issues/3945
{
    is-deeply (1..3, 1..3 Z(-) 2..4, 1..4),
      ((1,).Set, ().Set),
      'did Z handle (-) correctly (1)';

    is-deeply (1..3, 1..3 Z∖ 2..4, 1..4),
      ((1,).Set, ().Set),
      'did Z handle ∖ correctly (1)';

    is-deeply (1..3, 1..3 Z(-) 2..4, 1..2 Z(-) 2..3,2..3),
      ((1,).Set, ().Set),
      'did Z handle (-) correctly (2)';

    is-deeply (1..3, 1..3 Z∖ 2..4, 1..2 Z∖ 2..3,2..3),
      ((1,).Set, ().Set),
      'did Z handle ∖ correctly (2)';
}

# https://github.com/rakudo/rakudo/issues/2167
{
    is-deeply 1 (-) ($ = :42foo,), Set.new(1), 'no explosion';
}

# vim: expandtab shiftwidth=4
