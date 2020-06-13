use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 77;

isa-ok (5, 7, 8), List, '(5, 7, 8) is List';
is +(5, 7, 8), 3, 'prefix:<+> on a List';
is ~(5, 7, 8), '5 7 8', 'prefix:<~> on a List';
is (5, 7, 8).Str, '5 7 8', '.Str on a List';

# .raku
is ().raku, '()', '.raku on empty List';
is ().item.raku, '$( )', '.item.raku on empty List';
is-deeply ().item, ().item.raku.EVAL, 'can roundtrip ().item';
#?rakudo.jvm skip 'dies with t/harness5'
cmp-ok ().item.VAR, '===', ().item.raku.EVAL.VAR,
    '().item .raku.EVAL roundtrip preserves itemization';

# L<S02/Quoting forms/Elsewhere it is equivalent to a parenthesized list of strings>

isa-ok <5 7 8>, List, '<5 7 8> is List';
is +<5 7 8>, 3, 'prefix:<+> on an angle bracket List';
is ~<5 7 8>, '5 7 8', 'prefix:<~> on an angle bracket List';
is <5 7 8>.Str, '5 7 8', '.Str on an angle bracket List';

isa-ok (5, 7, 8).List, List, '.List returns a list';
is (5, 7, 8).List, [5,7,8], '.List contains the right items';
is (5, 7, 8).List.elems, 3, '.List contains the right number of elements';

is ?(), False, 'empty List is False';
is ?(1,2,3), True, 'non-empty List is True';

lives-ok { <5 7 8>[] }, 'can zen slice a List';

# https://github.com/Raku/old-issue-tracker/issues/2922
# modified for lolly branch
is $(;).elems, 0, '$(;) parses, and is empty';

# .rotate
{
    my $p = <a b c d e>;
    is ~$p.rotate, 'b c d e a', 'List.rotate defaults to +1';
    is ~$p, 'a b c d e', 'original list unmodified';

    is ~$p.rotate(2), 'c d e a b', '.rotate(2)';
    is ~$p, 'a b c d e', 'original list still unmodified';

    is ~$p.rotate(-2), 'd e a b c', '.rotate(-2)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~$p.rotate(0), 'a b c d e', '.rotate(0)';
    is ~$p.rotate(5), 'a b c d e', '.rotate(5)';
    is ~$p.rotate(15), 'a b c d e', '.rotate(15)';

    is ~$p.rotate(7), 'c d e a b', '.rotate(7)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~$p.rotate(-8), 'c d e a b', '.rotate(-8)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';
} #14

# all the same but rotate() sub
{
    my $p = <a b c d e>;
    is ~rotate($p), 'b c d e a', 'rotate(@a)';
    is ~$p, 'a b c d e', 'original list unmodified';

    is ~rotate($p, 2), 'c d e a b', 'rotate(@a, 2)';
    is ~$p, 'a b c d e', 'original list still unmodified';

    is ~rotate($p, -2), 'd e a b c', 'rotate(@a, -2)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate($p, 0), 'a b c d e', 'rotate(@a, 0)';
    is ~rotate($p, 5), 'a b c d e', 'rotate(@a, 5)';
    is ~rotate($p, 15), 'a b c d e', 'rotate(@a, 15)';

    is ~rotate($p, 7), 'c d e a b', 'rotate(@a, 7)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate($p, -8), 'c d e a b', 'rotate(@a, -8)';
    is ~$p, 'a b c d e', 'original still unmodified (negative)';
} #13

# https://github.com/Raku/old-issue-tracker/issues/4433
# Make sure List.rotate is Cool with stuff
{
    my $p = <a b c d e>;
    is ~$p.rotate('2'), 'c d e a b', '.rotate("2")';
    is ~$p.rotate(2.5), 'c d e a b', '.rotate(2.5)';
} #2

{
    ok <a b c> !=== <a b c>, 'a b c !=== a b c (List is not a value type)';
    ok (my $x1=42,1) !=== (42,1), '$x1 = 42,1 !=== 42,1';
    ok (my $x2=42,1) !=== (my $y=42,1), '$x2 = 42,1 !=== $y = 42,1';
    ok (my $x3=42,1) !=== (my $y2:=$x3,1), '$x3=42,1 !=== $y2 := $x3,1 (List is not a value type)';
} #4

{
    my $p = List.new( <a b c> );
    is $p.elems, 1, 'did we get the list';
    is $p, <a b c>, 'did we get what we put in';

    $p = List.new( 'a','b','c' );
    is $p.elems, 3, 'did we get the parameters';
    is $p, <a b c>, 'did we get what we put in';
} #4

# https://github.com/Raku/old-issue-tracker/issues/3035
{
    role sidecat {};
    my @a = 1,2,3;
    my @b = @a.pick(*).sort.list but sidecat;
    is @b.gist, "[1 2 3]", "can gist a list with a role";
}

{
    for <push pop shift unshift append prepend> -> $method {
        throws-like { (1,2,3)."$method"(42) }, X::Immutable,
          method   => $method,
          typename => 'List',
        ;
    }
}

{
    is (1,2,3,4).sum, 10, 'can we do .sum on a List';
    is (.1,.2,.3,.4).sum, 1, 'even if they are not ints';
    is <1 2 3 4>.sum, 10, 'even if they are numified strings';
    throws-like { <a b c d>.sum }, X::Str::Numeric,
      reason => "base-10 number must begin with valid digits or '.'",
      'fail if they are non-numeric strings';
}

# https://github.com/Raku/old-issue-tracker/issues/5610
{
    is-deeply (a => 2).first(/a/), (a => 2), "first with a Regexp object";
    is-deeply (a => 2).grep(/a/), ((a => 2),), "grep with a Regexp object";
}

subtest '.sum can handle Junctions' => {
    # http://www.perlmonks.org/?node_id=1176379
    plan 7;
    constant @a = (2, 3|4, 5, 6|7);
    my $sum = @a.sum;
    is-deeply-junction  sum(@a), $sum, 'sum() produces same thing as .sum';
    is-deeply-junction ([+] @a), $sum, '[+] produces same thing as .sum';
    cmp-ok $sum,  '==', 2+3+5+6, 'sum is correct (1)';
    cmp-ok $sum,  '==', 2+4+5+6, 'sum is correct (2)';
    cmp-ok $sum,  '==', 2+3+5+7, 'sum is correct (3)';
    cmp-ok $sum,  '==', 2+4+5+7, 'sum is correct (4)';
    ok     $sum   !==        42, 'sum is correct (6)';
}

# https://github.com/Raku/old-issue-tracker/issues/5819
{
    my @a := <a b c>[0..2, 0..2].flat.cache;
    @a.Bool;
    @a.elems;
    is-deeply @a, <a b c a b c>, '.flat does not skip inner iterables';
}

# https://github.com/Raku/old-issue-tracker/issues/4500
{
  my $a = (1, 2, 3);
  throws-like { $a[42] = 21 }, X::Assignment::RO,
    value => $a,
    'cannot assign to a element of an immutable List';

  my $b = (^10);
  throws-like { $b[1] = 21 }, X::Assignment::RO,
    value => $b,
    'cannot assign to a element of an immutable Range';

  my $c = [1, 2, 3];
  lives-ok { $c[5] = 21 };
  is $c[0, 1, 2, 5], [1, 2, 3, 21], 'can assign to a List element if it is a container';
}

# https://github.com/rakudo/rakudo/issues/1260
subtest 'List.new does not create unwanted containers' => {
    plan 4;
    my $l := List.new: 1, 2, my $ = 3;

    is-deeply $l, (1, 2, 3), 'right values';
    throws-like { $l[0] = 42 }, X::Assignment::RO,
        'no containers were created';
    lives-ok { $l[2] = 42 }, 'passed containers get preserved';
    is-deeply $l[2], 42, 'value assigneed to passed container is right';
}

# [Github Issue 1261](https://github.com/rakudo/rakudo/issues/1261)
{
    my $s = 21;
    my $l = ( 1, 2, $s );

    throws-like { $l[0] := 10 }, X::Bind, 'Cannot bind at pos of immutable List';
    throws-like { $l[2] := 10 }, X::Bind, 'Cannot bind at pos of immutable List, Scalar at pos';
}

# vim: expandtab shiftwidth=4
