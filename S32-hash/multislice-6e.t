use v6.e.PREVIEW;
use Test;

plan 544;

# Testing hash multislices, aka %h{a;b;c} and associated adverbs

my %hash;
sub set-up-hash(--> Nil) {
    %hash = a => { b => { c => 42, d => 666, e => { f => 314 } } };
}
sub leftover-ok($leftover --> Nil) is test-assertion {
    is-deeply %hash, $leftover,
      'is hash as expected after deletion of key?';
    set-up-hash;
}
sub assignable-ok(\target, \values, %result --> Nil) is test-assertion {
    subtest "check assignability with {values.raku}" => {
        is-deeply (target = values), values,
          "could we assign {values.raku} and did we get {values.raku} back";
        is-deeply %hash, %result,
          "did we assign value at the right place";
    }
    set-up-hash;
}
sub non-assignable-ok(\target, \value, $comment) is test-assertion {
    subtest $comment => {
        is-deeply target, value,  "was the value ok";
        dies-ok { target = 999 }, "did assignment die"
          unless target eqv ();  # () = foo does **not** die
    }
}

# tests taking 3 keys with a single (non-)result and result after deletion
set-up-hash;
for

  "a", "b", "c", 42,
    %(a => { b => { d => 666, e => { f => 314 } } }),
    %(a => { b => { c => 999, d => 666, e => { f => 314 } } }),

  "a", "b", "d", 666,
    %(a => { b => { c => 42, e => { f => 314 } } }),
    %(a => { b => { c => 42, d => 999, e => { f => 314 } } }),

  "a", "b", "e", { f => 314 },
    %(a => { b => { c => 42, d => 666 } }),
    %(a => { b => { c => 42, d => 666, e => 999 } }),

  "a", "b", "x", Nil,
    %hash,
    %(a => { b => { c => 42, d => 666, e => { f => 314 }, x => 999 } }),

  "a", "x", "e", Nil,
    %hash,
    %(a => { b => { c => 42, d => 666, e => { f => 314 } }, x => { e => 999 } }),

  "x", "b", "e", Nil,
    %hash,
    %(a => { b => { c => 42, d => 666, e => { f => 314 } } }, x => { b => { e => 999 } })

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := ($a,$b,$c);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);

    for False, True -> $delete {
        is-deeply %hash{$a;$b;$c}:$delete,
          !$exists && !$delete ?? Any !! $result,  # XXX
          "\%hash\{$araku;$braku;$craku}{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        $delete
          ?? leftover-ok($leftover)
          !! assignable-ok(%hash{$a;$b;$c}, 999, $assigned);

        non-assignable-ok %hash{$a;$b;$c}:exists:$delete,
          $exists,
          "\%hash\{$araku;$braku;$craku}:exists{
              ":delete" if $delete
          } gives $exists";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ %hash{$a;$b;$c}:!exists = 999 },
               "\%hash\{$araku;$braku;$craku}:!exists:delete dies ok")
          !! non-assignable-ok( %hash{$a;$b;$c}:!exists,
               !$exists,
               "\%hash\{$araku;$braku;$craku}:!exists gives {!$exists}");

        non-assignable-ok %hash{$a;$b;$c}:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\%hash\{$araku;$braku;$craku}:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:exists:p:$delete,
          $exists ?? Pair.new($abc,$exists) !! Nil,
          "\%hash\{$araku;$braku;$craku}:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$exists)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:k:$delete,
          $exists ?? $abc !! Nil,
          "\%hash\{$araku;$braku;$craku}:k:{
              ":delete" if $delete
          } gives {$exists ?? $abcraku !! "Nil"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:kv:$delete,
          $exists ?? ($abc,$result) !! (),
          "\%hash\{$araku;$braku;$craku}:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,$raku" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:p:$delete,
          $exists ?? Pair.new($abc,$result) !! Nil,
          "\%hash\{$araku;$braku;$craku}:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$raku)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:v:$delete,
          $exists ?? $result !! Nil,
          "\%hash\{$araku;$braku;$craku}:v{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 keys with a single (non-)result and one or more whatevers
for

  *, "b", "c", 42,
    %(a => { b => { d => 666, e => { f => 314 } } }),
    %(a => { b => { c => 999, d => 666, e => { f => 314 } } }),

  "a", *, "d", 666,
    %(a => { b => { c =>  42, e => { f => 314 } } }),
    %(a => { b => { c =>  42, d => 999, e => { f => 314 } } }),

  *, *, "e", { f => 314 },
    %(a => { b => { c =>  42, d => 666 } }),
    %(a => { b => { c =>  42, d => 666, e => 999 } }),

  *, "b", "x", Nil,
    %hash,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } }),

  "a", *, "x", Nil,
    %hash,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } }),

  *, *, "x", Nil,
    %hash,
    %(a => { b => { c =>  42, d => 666, e => { f => 314 }, x => 999 } })

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := ("a","b",$c);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);

    for False, True -> $delete {

        # always non-deterministic
        non-assignable-ok %hash{$a;$b;$c}:$delete,
          !$exists && !$delete ?? (Any,) !! ($result,),  # XXX
          "\%hash\{$araku;$braku;$craku}{
              ":delete" if $delete
          } gives {
              $exists ?? "($raku,)" !! "(Nil,)"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:exists:$delete,
          ($exists,),
          "\%hash\{$araku;$braku;$craku}:exists{
              ":delete" if $delete
          } gives ($exists,)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ %hash{$a;$b;$c}:!exists:delete = 999 },
               "\%hash\{$araku;$braku;$craku}:!exists:delete dies ok")
          !! non-assignable-ok( %hash{$a;$b;$c}:!exists,
               (!$exists,),
               "\%hash\{$araku;$braku;$craku}:!exists gives ({!$exists},)");

        non-assignable-ok %hash{$a;$b;$c}:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\%hash\{$araku;$braku;$craku}:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:exists:p:$delete,
          $exists ?? (Pair.new($abc,$exists),) !! (),
          "\%hash\{$araku;$braku;$craku}:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$exists),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:k:$delete,
          $exists ?? ($abc,) !! (),
          "\%hash\{$araku;$braku;$craku}:k{
              ":delete" if $delete
          } gives {$exists ?? "($abcraku,)" !! "()"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:kv:$delete,
          $exists ?? ($abc,$result) !! (),
          "\%hash\{$araku;$braku;$craku}:kv{
              ":delete" if $delete
          } gives ({ "$abcraku,$raku" if $exists })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:p:$delete,
          $exists ?? (Pair.new($abc,$result),) !! (),
          "\%hash\{$araku;$braku;$craku}:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$raku),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok %hash{$a;$b;$c}:v:$delete,
          $exists ?? ($result,) !! (),
          "\%hash\{$araku;$braku;$craku}:v{
              ":delete" if $delete
          } gives {$exists ?? "($raku,)" !! "()"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 keys with multi at highest level, result always the same
for

  "a", "b", <c d e>,
    *, "b", <c d e>,
  "a",   *, <c d e>,
    *,   *, <c d e>,
  "a", "b", *,
    *, "b", *,
  "a",   *, *,
    *,   *, *

-> $a, $b, $c {
    my $araku    := $a.raku;
    my $braku    := $b.raku;
    my $craku    := $c<>.raku;
    my $leftover := %(a => %(b => { }));
    my $assigned := %(a => { b => { c => 777, d => 888, e => 999 } });
    my $deterministic := !($a | $b | $c ~~ Whatever);

    # Note: because $c may contain a list as an item, we need to decont
    # it before using it as an index, otherwise we will never get a match.
    # So the use of $c<> here is an artefact of the test, not of the way
    # indexing works on multi-level hashes.
    for False, True -> $delete {

        ($deterministic && !$delete ?? &is-deeply !! &non-assignable-ok)(
          (%hash{$a;$b;$c<>}:$delete).sort,
          (42, 666, { f => 314 }),
          "\%hash\{$araku;$braku;$craku}{
              ":delete" if $delete
          } gives (42, 666, \{ f => 314 })"
        );
        if $delete {
            leftover-ok($leftover);
        }
        elsif $deterministic {
            assignable-ok(%hash{$a;$b;$c<>}, (777,888,999), $assigned);
        }

        non-assignable-ok %hash{$a;$b;$c<>}:exists:$delete,
          (True,True,True),
          "\%hash\{$araku;$braku;$craku}:exists{
              ":delete" if $delete
          } gives (True,True,True)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ %hash{$a;$b;$c<>}:!exists:delete },
               "\%hash\{$araku;$braku;$craku}:!exists:delete dies ok")
          !! non-assignable-ok( %hash{$a;$b;$c<>}:!exists,
               (False,False,False),
               "\%hash\{$araku;$braku;$craku}:!exists{
                   ":delete" if $delete
               } gives (False,False,False)");

        non-assignable-ok (%hash{$a;$b;$c<>}:exists:kv:$delete)
          .map(-> \key, \value { Pair.new(key,value) })
          .sort( *.key )
          .map( { |(.key, .value) } ),
          (<a b c>,True,<a b d>,True,<a b e>,True),
          "\%hash\{$araku;$braku;$craku}:exists:kv{
              ":delete" if $delete
          } gives <a b c>,True,<a b d>,True,<a b e>,True";
        leftover-ok($leftover) if $delete;

        non-assignable-ok (%hash{$a;$b;$c<>}:exists:p:$delete).sort( *.key ),
          (<a b c> => True,<a b d> => True,<a b e> => True),
          "\%hash\{$araku;$braku;$craku}:exists:p{
              ":delete" if $delete
          } gives <a b c> => True,<a b d> => True,<a b e> => True";
        leftover-ok($leftover) if $delete;

        non-assignable-ok (%hash{$a;$b;$c<>}:k:$delete).sort,
          (<a b c>,<a b d>,<a b e>),
          "\%hash\{$araku;$braku;$craku}:k{
              ":delete" if $delete
          } gives <a b c>,<a b d>,<a b e>";
        leftover-ok($leftover) if $delete;

        non-assignable-ok (%hash{$a;$b;$c<>}:kv:$delete)
          .map(-> \key, \value { Pair.new(key,value) })
          .sort( *.key )
          .map( { |(.key, .value) } ),
          (<a b c>,42,<a b d>,666,<a b e>,{ f => 314 }),
          "\%hash\{$araku;$braku;$craku}:kv{
              ":delete" if $delete
          } gives <a b c>,42,<a b d>,666,<a b e>,\{ f => 314 }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok (%hash{$a;$b;$c<>}:p:$delete).sort( *.key ),
          (<a b c> => 42,<a b d> => 666,<a b e> => { f => 314 }),
          "\%hash\{$araku;$braku;$craku}:p{
              ":delete" if $delete
          } gives <a b c> => 42,<a b d> => 666,<a b e> => \{ f => 314 }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok (%hash{$a;$b;$c<>}:v:$delete).sort,
          (42, 666, { f => 314 }),
          "\%hash\{$araku;$braku;$craku}:v{
              ":delete" if $delete
          } gives 42, 666, \{ f => 314 }";
        leftover-ok($leftover) if $delete;
    }
}

# make sure recursion works
{
    my %hash;
    is-deeply (%hash{<a b>;"c"} = 42,666), (42,666),
      'did assignment to non-existing hashes return the assigned values';
    is-deeply %hash, { a => { c => 42 }, b => { c => 666 } },
      'did initialization work';
    is-deeply (%hash{<a b>;"c"} = 777, 888), (777,888),
      'did assignment return the assigned values';
    is-deeply %hash, { a => { c => 777 }, b => { c => 888 } },
      'did the hash get changed correctly';
    is-deeply (%hash{<a b>;"c"}:delete), (777,888),
      'did deletion return the expected values';
    is-deeply %hash, { a => { }, b => { } },
      'did the hash get changed correctly';
    is-deeply (%hash{<a b>;"d"} = 333, 444), (333,444),
      'did assignment to non-existing keys return the assigned values';
    is-deeply %hash, { a => { d => 333 }, b => { d => 444 } },
      'did the hash get changed correctly';
}

# make sure || syntax works
{
    my %hash;
    my @indices := <a b>, <c>;   # need binding, no containers!

    is-deeply (%hash{|| @indices} = 42,666), (42,666),
      '|| did assignment to non-existing hashes return the assigned values';
    is-deeply %hash, { a => { c => 42 }, b => { c => 666 } },
      '|| did initialization work';
    is-deeply (%hash{|| @indices} = 777, 888), (777,888),
      '|| did assignment return the assigned values';
    is-deeply %hash, { a => { c => 777 }, b => { c => 888 } },
      '|| did the hash get changed correctly';
    is-deeply (%hash{|| @indices}:delete), (777,888),
      '|| did deletion return the expected values';
    is-deeply %hash, { a => { }, b => { } },
      '|| did the hash get changed correctly';
    is-deeply (%hash{|| <a b>, "d"} = 333, 444), (333,444),
      '|| did assignment to non-existing keys return the assigned values';
    is-deeply %hash, { a => { d => 333 }, b => { d => 444 } },
      '|| did the hash get changed correctly';
    is-deeply %hash{|| "b"}, { d => 444 },
      '|| did single key get handled correctly';
}

# vim: expandtab shiftwidth=4
