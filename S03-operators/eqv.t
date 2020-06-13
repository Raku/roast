use v6;
use Test;

plan 59;

# L<S03/Comparison semantics/Binary eqv tests equality much like === does>
# L<S32::Basics/Any/"=item eqv">

# eqv on values
{
  ok  (1 eqv 1), "eqv on values (1)";
  ok  (0 eqv 0), "eqv on values (2)";
  ok !(0 eqv 1), "eqv on values (3)";
}

# Value types
{
  my $a = 1;
  my $b = 1;

  ok $a eqv $a, "eqv on value types (1-1)";
  ok $b eqv $b, "eqv on value types (1-2)";
  ok $a eqv $b, "eqv on value types (1-3)";
}


{
  my $a = 1;
  my $b = 2;

  ok  ($a eqv $a), "eqv on value types (2-1)";
  ok  ($b eqv $b), "eqv on value types (2-2)";
  ok !($a eqv $b), "eqv on value types (2-3)";
}

{
  my @a = (1,2,3);
  my @b = (1,2,3);

  ok  (\@a eqv \@a), "eqv on array references (1)";
  ok  (\@b eqv \@b), "eqv on array references (2)";
  #?rakudo todo 'huh?'
  ok !(\@a eqv \@b), "eqv on array references (3)";
  @a := @b;
  ok \@a eqv \@b, '\@array of two bound arrays are eqv';
}

{
  my $a = \3;
  my $b = \3;

  ok ($a eqv $a), "eqv on scalar references (1-1)";
  ok ($b eqv $b), "eqv on scalar references (1-2)";
  ok ($a eqv $b), "eqv on scalar references (1-3)";
  #?rakudo todo 'huh?'
  ok (\$a !eqv \$b), "eqv on scalar references (1-4)";
}

{
  my $a = { 3 };
  my $b = { 3 };

  ok ($a eqv $a), "eqv on sub references (1-1)";
  ok ($b eqv $b), "eqv on sub references (1-2)";
  # it's impossible to compare blocks for equivalence in general,
  # and they have associations to different source locations
  # (line number, column)
  nok ($a eqv $b), "eqv on sub references (1-3)";
  nok ($a eqv { 5 }), 'eqv on sub references (1-4)';
}

{
  ok  (&say eqv &say), "eqv on sub references (2-1)";
  ok  (&map eqv &map), "eqv on sub references (2-2)";
  ok !(&say eqv &map), "eqv on sub references (2-3)";
}

{
  my $num = 3; my $a   = \$num;
  my $b   = \$num;

  ok  ($a eqv $a), "eqv on scalar references (2-1)";
  ok  ($b eqv $b), "eqv on scalar references (2-2)";
  ok  ($a eqv $b), "eqv on scalar references (2-3)";
}

{
  nok ([1,2,3] eqv [4,5,6]), "eqv on anonymous array references (1)";
  ok ([1,2,3] eqv [1,2,3]), "eqv on anonymous array references (2)";
  ok ([]      eqv []),      "eqv on anonymous array references (3)";
}

{
  ok !({a => 1} eqv {a => 2}), "eqv on anonymous hash references (-)";
  ok  ({a => 1} eqv {a => 1}), "eqv on anonymous hash references (+)";
  ok ({a => 2, b => 1} eqv { b => 1, a => 2}), 'order really does not matter';
  ok !({a => 1} eqv {a => 1, b => 2}), 'hashes: different number of pairs';
}

{
  ok !(\3 eqv \4),         "eqv on anonymous scalar references (1)";
  # XXX the following seems bogus nowadays
  #?rakudo todo 'huh?'
  ok !(\3 eqv \3),         "eqv on anonymous scalar references (2)";
  #?rakudo skip 'huh?'
  ok !(\Mu eqv \Mu), "eqv on anonymous scalar references (3)";
}

# Chained eqv (not specced, but obvious)
{
  ok  (3 eqv 3 eqv 3), "chained eqv (1)";
  ok !(3 eqv 3 eqv 4), "chained eqv (2)";
}

# Subparam binding doesn't affect eqv test
{
  my $foo;
  my $test = -> $arg { $foo eqv $arg };

  $foo = 3;
  ok  $test($foo), "subparam binding doesn't affect eqv (1)";
  ok  $test(3),    "subparam binding doesn't affect eqv (2)";

  ok !$test(4),    "subparam binding doesn't affect eqv (3)";
  my $bar = 4;
  ok !$test($bar), "subparam binding doesn't affect eqv (4)";
}

{
    is(1 eqv 1, Bool::True,  'eqv returns Bool::True when true');
    is(0 eqv 1, Bool::False, 'eqv returns Bool::False when false');
}

{
    is Any eqv Any, Bool::True, 'Any eqv Any';
}

{
    ok 'a' eqv any(<a b c>), "eqv autothreads correctly";
}

# https://github.com/Raku/old-issue-tracker/issues/1785
# Rakudo used to be confused when lists began with ()
{
    nok ((), "x") eqv ((), 9), 'list starting with () - 1';
    nok ((), (), 1) eqv ((), 9), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), (), ""), 'list starting with () - 1';
    nok ((), (), (), 1) eqv ((), 4), 'list starting with () - 1';
    ok ((), ()) eqv ((), ()), '((), ())';
}

# Nieczabug #142
{
    nok 4 eqv 4.0, "Values should be eqv only if they are the same type";
    nok 4 eqv '4', 'Str vs. Int';
}

subtest 'Setty eqv Setty' => {
    plan 8;

    my $a = ["arr"];
    is-deeply Set.new(1, "a", Cool, $a) eqv Set.new(1, "a", Cool, $a), True,
        'identical Sets eqv each other';
    is-deeply SetHash.new(1, "a", Cool, $a) eqv SetHash.new(1, "a", Cool, $a),
        True, 'identical SetHashes eqv each other';
    is-deeply Set.new(42) eqv SetHash.new(42), False,
      'Set does not eqv SetHash';

    is-deeply set(<42>) eqv set( 42 ), False, 'IntStr does not eqv Int';
    is-deeply set(<42>) eqv set('42'), False, 'IntStr does not eqv Str';
    is-deeply set( 42 ) eqv set(<42>), False, 'Int    does not eqv IntStr';
    is-deeply set('42') eqv set(<42>), False, 'Str    does not eqv IntStr';
    is-deeply set(<42>) eqv set(<42>), True, 'IntStr does     eqv IntStr';
}

subtest 'Seq eqv List' => {
    my @tests = ().Seq => (),  (1, 2).Seq => (1, 2),           ().Seq => (1, 2),
            (1, 2).Seq => (),       (1…∞) => (1…∞).List,   (1…∞).List => (1…∞);

    plan +@tests;
    is-deeply (.key eqv .value), False,
        "{.key.^name}({.key}) not eqv {.value.^name}({.value})"
    for @tests;
}

subtest 'Seq eqv Seq' => {
    plan 7;

    my $a = (^2).Seq;
    my $b = $a; # .iterator can be called only once

    my $result;
    lives-ok { $result = $a eqv $b },
        'eqv between identical Seqs does not die';

    is-deeply $result, True,
        'eqv between identical Seqs returns True';

    $a = lazy ^2;
    $b = $a;

    $a.cache; # now .iterator can be called on both
    lives-ok { $result = $a eqv $b },
        'eqv between identical lazy Seqs does not die';

    is-deeply $result, True,
        'eqv between identical lazy Seqs returns True';

    $a = (0,1).Seq;
    $b = (0,1,2).Seq;
    is-deeply $a eqv $b, False,
        'eqv between shorter and longer Seq';

    $a = (0,1,2).Seq;
    $b = (0,1).Seq;
    is-deeply $a eqv $b, False,
        'eqv between longer and shorter Seq';

    $a = (0,1,2).Seq;
    $b = (0,1,42).Seq;
    is-deeply $a eqv $b, False,
        'eqv between Seqs with different end values';
}

# rakudo/issues/3346
{
    my $test = start {
        my $a = (0,1).hyper;
        my $b = (0,2).hyper;
        die if $a eqv $b;
    };

    await Promise.anyof($test, Promise.in(5));
    is $test.status, Kept, 'HyperSeq eqv HyperSeq';
}

subtest 'Throws/lives in lazy cases' => {
    plan 8;

    # Note that `eqv` *can* compare lazy iterables when the answer
    # doesn't require iterating over them. These cases do NOT throw:
    #   1. Only one of the arguments is lazy
    #   2. Both arguments are lazy, but are of different type

    throws-like { (1…∞)       eqv (1…∞)       }, X::Cannot::Lazy, :action<eqv>,
        'both lazy, same types (Seqs)';
    throws-like { (1…∞).List  eqv (1…∞).List  }, X::Cannot::Lazy, :action<eqv>,
        'both lazy, same types (Lists)';
    throws-like { (1…∞).Array eqv (1…∞).Array }, X::Cannot::Lazy, :action<eqv>,
        'both lazy, same types (Arrays)';

    lives-ok    { (1…∞) eqv (1…∞).List }, 'both lazy, different types';
    lives-ok    { (1…∞) eqv (1,3)      }, 'different types, only one lazy';

    lives-ok    { (1…∞)       eqv (1…3)       }, 'Seqs, only one lazy';
    lives-ok    { (1…∞).List  eqv (1…3).List  }, 'Lists, only one lazy';
    lives-ok    { (1…∞).Array eqv (1…3).Array }, 'Arrays, only one lazy';
}

# vim: expandtab shiftwidth=4
