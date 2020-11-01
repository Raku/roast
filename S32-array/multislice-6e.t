use v6.e.PREVIEW;
use Test;

plan 797;

# Testing array multislices, aka @a[0;1;2] and associated adverbs

my @array;
sub set-up-array(--> Nil) {
    @array = [[[42,666,[314]],],];
}
sub leftover-ok($leftover --> Nil) is test-assertion {
    is-deeply @array, $leftover,
      'is array as expected after deletion of index?';
    set-up-array;
}
sub assignable-ok(\target, \values, @result --> Nil) is test-assertion {
    subtest "check assignability with {values.raku}" => {
        is-deeply (try target = values), values,
          "could we assign {values.raku} and did we get {values.raku} back";
        is-deeply @array, @result,
          "did we assign value at the right place";
    }
    set-up-array;
}
sub non-assignable-ok(\target, \value, $comment --> Nil) is test-assertion {
    subtest $comment => {
        is-deeply target, value,  "was the value ok";
        dies-ok { target = 999 }, "did assignment die"
          unless target eqv ();  # () = foo does **not** die
    }
}

# tests taking 3 indices with a single (non-)result and result after deletion
set-up-array;
for

  0, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  "0", 0e0, 0/1, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  *-1, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, *-1, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  *-1, *-1, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, 0, 1, 666,
    [[[42,Any,[314]],],],
    [[[42,999,[314]],],],

  0, 0, 2, [314],
    [[[42,666],],],
    [[[42,666,999],],],

  *-1, *-1, *-1, [314],
    [[[42,666],],],
    [[[42,666,999],],],

  0, 0, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  0, 1, 0, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314]],[999]],],

  1, 0, 0, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314]],],[[999],]]

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a ~~ Callable ?? '*-1' !! $a.raku;
    my $braku   := $b ~~ Callable ?? '*-1' !! $b.raku;
    my $craku   := $c ~~ Callable ?? '*-1' !! $c.raku;
    my $abc     := ($a ~~ Callable ?? 0 !! $a.Int,
                    $b ~~ Callable ?? 0 !! $b.Int,
                    $c ~~ Callable ?? 2 !! $c.Int
                   );
    my $abcraku := $abc.raku;
    my $exists  := defined($result);
    my $resnona := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # fast-path checks
        unless $delete {
            is-deeply @array[$a;$b;$c],
              $exists ?? $result !! Any,
              "\@array\[$araku;$braku;$craku] gives {
                  $exists ?? $result !! "Any"
              } (fast-path)";
            is-deeply (try @array[$a;$b;$c] = 999), 999,
              "could we assign 999 and did we get 999 back (fast-path)";
            is-deeply @array, $assigned,
              "did we assign value at the right place (fast-path)";
            set-up-array;
        }

        is-deeply @array[$a;$b;$c]:$delete,
          $exists
            ?? $delete ?? $resnona !! $result
            !! $delete ?? Nil      !! Any,
          "\@array\[$araku;$braku;$craku]{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        $delete
          ?? leftover-ok($leftover)
          !! assignable-ok(@array[$a;$b;$c], 999, $assigned);

        non-assignable-ok @array[$a;$b;$c]:exists:$delete,
          $exists,
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives $exists";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c]:!exists = 999 },
               "\@array\[$araku;$braku;$craku]:!exists:delete dies ok")
          !! non-assignable-ok( @array[$a;$b;$c]:!exists,
               !$exists,
               "\@array\[$araku;$braku;$craku]:!exists gives {!$exists}");

        non-assignable-ok @array[$a;$b;$c]:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:exists:p:$delete,
          $exists ?? Pair.new($abc,$exists) !! Nil,
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$exists)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:k:$delete,
          $exists ?? $abc !! Nil,
          "\@array\[$araku;$braku;$craku]:k:{
              ":delete" if $delete
          } gives {$exists ?? $abcraku !! "Nil"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:kv:$delete,
          $exists ?? ($abc,$resnona) !! (),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,$raku" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:p:$delete,
          $exists ?? Pair.new($abc,$resnona) !! Nil,
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives {
              $exists ?? "Pair.new($abcraku,$raku)" !! "Nil"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:v:$delete,
          $exists ?? $resnona !! Nil,
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives {$exists ?? $raku !! "Nil"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 indices with a single (non-)result and one or more whatevers
for

  *, 0, 0, 42,
    [[[Any,666,[314]],],],
    [[[999,666,[314]],],],

  0, *, 1, 666,
    [[[42,Any,[314]],],],
    [[[42,999,[314]],],],

  *, *, 2, [314,],
    [[[42,666],],],
    [[[42,666,999],],],

  *, *, "2", [314,],
    [[[42,666],],],
    [[[42,666,999],],],

  *, 0, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  0, *, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],],

  *, *, 3, Nil,
    [[[42,666,[314]],],],
    [[[42,666,[314],999],],]

-> $a, $b, $c, $result, $leftover, $assigned {
    my $raku    := $result.raku;
    my $araku   := $a.raku;
    my $braku   := $b.raku;
    my $craku   := $c.raku;
    my $abc     := (0,0,$c.Int);
    my $abcraku := $abc.raku;
    my $exists  := defined($result);
    my $resnona := $result ~~ Array ?? $result.List !! $result;

    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @array[$a;$b;$c],
              $exists ?? ($result,) !! (Any,),
              "\@array\[$araku;$braku;$craku] gives {
                  $exists ?? "($raku,)" !! "Any"
              } (fast-path)";
            is-deeply (try @array[$a;$b;$c] = (999,)), (999,),
              "could we assign (999,) and did we get (999,) back (fast-path)";
            is-deeply @array, $assigned,
              "did we assign value at the right place (fast-path)";
            set-up-array;
        }

        is-deeply @array[$a;$b;$c]:$delete,
          $exists
            ?? $delete ?? ($resnona,) !! ($result,)
            !! $delete ?? (Nil,)      !! (Any,),
          "\@array\[$araku;$braku;$craku]{
              ":delete" if $delete
          } gives {
              $exists
                ?? $delete ?? "($resnona.raku(),))" !! "($raku,)"
                !! $delete ?? "(Nil,)"              !! "(Any,)",
          }";
        $delete
          ?? leftover-ok($leftover)
          !! assignable-ok(@array[$a;$b;$c], (999,), $assigned);

        non-assignable-ok @array[$a;$b;$c]:exists:$delete,
          ($exists,),
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives ($exists,)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c]:!exists:delete = 999 },
               "\@array\[$araku;$braku;$craku]:!exists:delete dies ok")
          !! non-assignable-ok( @array[$a;$b;$c]:!exists,
               (!$exists,),
               "\@array\[$araku;$braku;$craku]:!exists gives ({!$exists},)");

        non-assignable-ok @array[$a;$b;$c]:exists:kv:$delete,
          $exists ?? ($abc,$exists) !! (),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ({
              "$abcraku,True" if $exists
          })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:exists:p:$delete,
          $exists ?? (Pair.new($abc,$exists),) !! (),
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$exists),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:k:$delete,
          $exists ?? ($abc,) !! (),
          "\@array\[$araku;$braku;$craku]:k{
              ":delete" if $delete
          } gives {$exists ?? "($abcraku,)" !! "()"}";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:kv:$delete,
          $exists ?? ($abc,$resnona) !! (),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ({ "$abcraku,$raku" if $exists })";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:p:$delete,
          $exists ?? (Pair.new($abc,$resnona),) !! (),
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives {
              $exists ?? "(Pair.new($abcraku,$raku),)" !! "()"
          }";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c]:v:$delete,
          $exists ?? ($resnona,) !! (),
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives {$exists ?? "($raku,)" !! "()"}";
        leftover-ok($leftover) if $delete;
    }
}

# tests taking 3 indices with multi at highest level, result always the same
for
   0, 0, (0,1,2),
   *, 0, ^3,
   0, *, (0...2),
   *, *, (0,1,2),
   0, 0, *,
   *, 0, *,
   0, *, *,
   *, *, *

-> $a, $b, $c {
    my $araku    := $a.raku;
    my $braku    := $b.raku;
    my $craku    := $c<>.raku;
    my $leftover := [[[],],];
    my $assigned := [[[777,888,999],],];

    # Note: because $c may contain a list as an item, we need to decont
    # it before using it as an index, otherwise we will never get a match.
    # So the use of $c<> here is an artefact of the test, not of the way
    # indexing works on multi-level arrayes.
    for False, True -> $delete {

        # check fast-paths
        unless $delete {
            is-deeply @array[$a;$b;$c<>],
              (42,666,[314]),
              "\@array\[$araku;$braku;$craku] gives (42,666,[314]) (fast-path)";
            is-deeply (try @array[$a;$b;$c<>] = (777,888,999)),
              (777,888,999),
              "could we assign (777,888,999) and get it back (fast-path)";
            is-deeply @array, $assigned,
              "did we assign value at the right place (fast-path)";
            set-up-array;
        }

        if $delete {
            non-assignable-ok @array[$a;$b;$c<>]:delete,
              (42,666,(314,)),
              "\@array\[$araku;$braku;$craku]:delete gives (42,666,(314,))";
            leftover-ok($leftover);
        }
        else {
            is-deeply @array[$a;$b;$c<>]:!delete,
              (42,666,[314]),
              "\@array\[$araku;$braku;$craku] gives (42,666,[314])";
            assignable-ok(@array[$a;$b;$c<>], (777,888,999), $assigned);
        }

        non-assignable-ok @array[$a;$b;$c<>]:exists:$delete,
          (True,True,True),
          "\@array\[$araku;$braku;$craku]:exists{
              ":delete" if $delete
          } gives (True,True,True)";
        leftover-ok($leftover) if $delete;

        $delete
          ?? dies-ok({ @array[$a;$b;$c<>]:!exists:delete },
               "\@array\[$araku;$braku;$craku]:!exists:delete dies ok")
          !! non-assignable-ok( @array[$a;$b;$c<>]:!exists,
               (False,False,False),
               "\@array\[$araku;$braku;$craku]:!exists{
                   ":delete" if $delete
               } gives (False,False,False)");

        non-assignable-ok @array[$a;$b;$c<>]:exists:kv:$delete,
          ((0,0,0),True,(0,0,1),True,(0,0,2),True),
          "\@array\[$araku;$braku;$craku]:exists:kv{
              ":delete" if $delete
          } gives ((0,0,0),True,(0,0,1),True,(0,0,2),True)";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:exists:p:$delete,
          ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True),
          "\@array\[$araku;$braku;$craku]:exists:p{
              ":delete" if $delete
          } gives ((0,0,0) => True,(0,0,1) => True,(0,0,2) => True)";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:k:$delete,
          ((0,0,0),(0,0,1),(0,0,2)),
          "\@array\[$araku;$braku;$craku]:k{
              ":delete" if $delete
          } gives ((0,0,0),(0,0,1),(0,0,2))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:kv:$delete,
          ((0,0,0),42,(0,0,1),666,(0,0,2),(314,)),
          "\@array\[$araku;$braku;$craku]:kv{
              ":delete" if $delete
          } gives ((0,0,0),42,(0,0,1),666,(0,0,2),(314,))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:p:$delete,
          ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,)),
          "\@array\[$araku;$braku;$craku]:p{
              ":delete" if $delete
          } gives ((0,0,0) => 42,(0,0,1) => 666,(0,0,2) => (314,))";
        leftover-ok($leftover) if $delete;

        non-assignable-ok @array[$a;$b;$c<>]:v:$delete,
          (42, 666, (314,)),
          "\@array\[$araku;$braku;$craku]:v{
              ":delete" if $delete
          } gives 42, 666, (314,)";
        leftover-ok($leftover) if $delete;
    }
}

# make sure recursion works
{
    my @array;
    is-deeply (@array[0,1;0] = 42,666), (42,666),
      'did assignment to non-existing arrays return the assigned values';
    is-deeply @array, [[42],[666]],
      'did initialization work';
    is-deeply (@array[0,1;0] = 777, 888), (777,888),
      'did assignment return the assigned values';
    is-deeply @array, [[777],[888]],
      'did the array get changed correctly';
    is-deeply (@array[0,1;0]:delete), (777,888),
      'did deletion return the expected values';
    is-deeply @array, [[],[]],
      'did the array get changed correctly';
    is-deeply (@array[0,1;1] = 333, 444), (333,444),
      'did assignment to non-existing indices return the assigned values';
    is-deeply @array, [[Any,333],[Any,444]],
      'did the array get changed correctly';
}

# make sure || syntax works
{
    my @array;
    my @indices := (0,1), 0;   # need binding, no containers!

    is-deeply (@array[|| @indices] = 42,666), (42,666),
      '|| did assignment to non-existing arrayes return the assigned values';
    is-deeply @array, [[42],[666]],
      '|| did initialization work';
    is-deeply (@array[|| @indices] = 777, 888), (777,888),
      '|| did assignment return the assigned values';
    is-deeply @array, [[777],[888]],
      '|| did the array get changed correctly';
    is-deeply (@array[|| @indices]:delete), (777,888),
      '|| did deletion return the expected values';
    is-deeply @array, [[],[]],
      '|| did the array get changed correctly';
    is-deeply (@array[|| (0,1), 1] = 333, 444), (333,444),
      '|| did assignment to non-existing indices return the assigned values';
    is-deeply @array, [[Any,333],[Any,444]],
      '|| did the array get changed correctly';
    is-deeply @array[|| 1], [Any,444],
      '|| could we specify a single index';
}

# vim: expandtab shiftwidth=4
