use v6.e.PREVIEW;
use Test;

# Testing hash multislices, aka %h{a;b;c} and associated adverbs

my %hash = a => { b => { c => 42, d => 666, e => { f => 314 } } };

# tests taking 3 keys with a single (non-)result
my @three-single =
  "a", "b", "c", 42,
  "a", "b", "d", 666,
  "a", "b", "e", { f => 314 },
  "a", "b", "x", Nil,
  "a", "x", "e", Nil,
  "x", "b", "e", Nil,
;

# tests taking 3 keys with a single (non-)result and one or more whatevers
my @three-whatever =
    *, "b", "c", 42,
  "a",   *, "d", 666,
    *,   *, "e", { f => 314 },
    *, "b", "x", Nil,
  "a",   *, "x", Nil,
    *,   *, "x", Nil,
;

plan 8 * ( @three-single / 4 + @three-whatever / 4 );

for @three-single -> $a, $b, $c, $result {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := ($a,$b,$c);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);

    is-deeply %hash{$a;$b;$c}, $result,
      "\%hash\{$araku;$braku;$craku} = {$exists ?? $raku !! "Nil"}";

    is-deeply %hash{$a;$b;$c}:exists, $exists,
      "\%hash\{$araku;$braku;$craku}:exists = $exists";

    is-deeply %hash{$a;$b;$c}:exists:kv, $exists ?? ($abc,$exists) !! (),
      "\%hash\{$araku;$braku;$craku}:exists:kv = ({
          "$abcraku,True" if $exists
      })";

    is-deeply %hash{$a;$b;$c}:exists:p,
      $exists ?? Pair.new($abc,$exists) !! Nil,
      "\%hash\{$araku;$braku;$craku}:exists:p = {
          $exists ?? "Pair.new($abcraku,$exists)" !! "Nil"
      }";

    is-deeply %hash{$a;$b;$c}:k, $exists ?? $abc !! Nil,
      "\%hash\{$araku;$braku;$craku}:k = {$exists ?? $abcraku !! "Nil"}";

    is-deeply %hash{$a;$b;$c}:kv, $exists ?? ($abc,$result) !! (),
      "\%hash\{$araku;$braku;$craku}:kv = ({
          "$abcraku,$raku" if $exists
      })";

    is-deeply %hash{$a;$b;$c}:p, $exists ?? Pair.new($abc,$result) !! Nil,
      "\%hash\{$araku;$braku;$craku}:p = {
          $exists ?? "Pair.new($abcraku,$raku)" !! "Nil"
      }";;

    is-deeply %hash{$a;$b;$c}:v, $exists ?? $result !! Nil,
      "\%hash\{$araku;$braku;$craku}:v = {$exists ?? $raku !! "Nil"}";
}

for @three-whatever -> $a, $b, $c, $result {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := ("a","b",$c);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);

    is-deeply %hash{$a;$b;$c}, $exists ?? ($result,) !! (Any,),
      "\%hash\{$araku;$braku;$craku} = {$exists ?? "($raku,)" !! "(Any,)"}";

    is-deeply %hash{$a;$b;$c}:exists, ($exists,),
      "\%hash\{$araku;$braku;$craku}:exists = ($exists,)";

    is-deeply %hash{$a;$b;$c}:exists:kv, $exists ?? ($abc,$exists) !! (),
      "\%hash\{$araku;$braku;$craku}:exists:kv = ({
          "$abcraku,True" if $exists
      })";

    is-deeply %hash{$a;$b;$c}:exists:p,
      $exists ?? (Pair.new($abc,$exists),) !! (),
      "\%hash\{$araku;$braku;$craku}:exists:p = {
          $exists ?? "(Pair.new($abcraku,$exists),)" !! "()"
      }";

    is-deeply %hash{$a;$b;$c}:k, $exists ?? ($abc,) !! (),
      "\%hash\{$araku;$braku;$craku}:k = {$exists ?? "($abcraku,)" !! "()"}";

    is-deeply %hash{$a;$b;$c}:kv, $exists ?? ($abc,$result) !! (),
      "\%hash\{$araku;$braku;$craku}:kv = ({
          "$abcraku,$raku" if $exists
      })";

    is-deeply %hash{$a;$b;$c}:p, $exists ?? (Pair.new($abc,$result),) !! (),
      "\%hash\{$araku;$braku;$craku}:p = {
          $exists ?? "(Pair.new($abcraku,$raku),)" !! "()"
      }";

    is-deeply %hash{$a;$b;$c}:v, $exists ?? ($result,) !! (),
      "\%hash\{$araku;$braku;$craku}:v = {$exists ?? "($raku,)" !! "()"}";
}

# vim: expandtab shiftwidth=4
