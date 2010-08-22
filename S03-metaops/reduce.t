use v6;
use Test;

plan 92;

=begin pod

=head1 DESCRIPTION

This test tests the C<[...]> reduce metaoperator.

Reference:
L<"http://groups.google.de/group/perl.perl6.language/msg/bd9eb275d5da2eda">

=end pod

# L<S03/"Reduction operators">

# [...] reduce metaoperator
{
  my @array = <5 -3 7 0 1 -9>;
  my $sum   = 5 + -3 + 7 + 0 + 1 + -9; # laziness :)

  is(([+] @array),      $sum, "[+] works");
  is(([*]  1,2,3),    (1*2*3), "[*] works");
  is(([-]  1,2,3),    (1-2-3), "[-] works");
  is(([/]  12,4,3),  (12/4/3), "[/] works");
  is(([div]  12,4,3),  (12 div 4 div 3), "[div] works");
  is(([**] 2,2,3),  (2**2**3), "[**] works");
  is(([%]  13,7,4), (13%7%4),  "[%] works");
  is(([mod]  13,7,4), (13 mod 7 mod 4),  "[mod] works");

  is((~ [\+] @array), "5 2 9 9 10 1", "[\\+] works");
  is((~ [\-] 1, 2, 3), "1 -1 -4",      "[\\-] works");
}

{
  is ([~] <a b c d>), "abcd", "[~] works";
  is (~ [\~] <a b c d>), "a ab abc abcd", "[\\~] works";
}

{
    ok (    [<]  1, 2, 3, 4), "[<] works (1)";
    ok (not [<]  1, 3, 2, 4), "[<] works (2)";
    ok (    [>]  4, 3, 2, 1), "[>] works (1)";
    ok (not [>]  4, 2, 3, 1), "[>] works (2)";
    ok (    [==] 4, 4, 4),    "[==] works (1)";
    ok (not [==] 4, 5, 4),    "[==] works (2)";
    ok (    [!=] 4, 5, 6),    "[!=] works (1)";
    ok (not [!=] 4, 4, 4),    "[!=] works (2)";
}

{
    ok (! [eq] <a a b a>),    '[eq] basic sanity (positive)';
    ok (  [eq] <a a a a>),    '[eq] basic sanity (negative)';
    ok (  [ne] <a b c a>),    '[ne] basic sanity (positive)';
    ok (! [ne] <a a b c>),    '[ne] basic sanity (negative)';
    ok (  [lt] <a b c e>),    '[lt] basic sanity (positive)';
    ok (! [lt] <a a c e>),    '[lt] basic sanity (negative)';
}

#?rakudo skip "=:= NYI"
{
    my ($x, $y);
    ok (    [=:=]  $x, $x, $x), '[=:=] basic sanity 1';
    ok (not [=:=]  $x, $y, $x), '[=:=] basic sanity 2';
    ok (    [!=:=] $x, $y, $x), '[!=:=] basic sanity (positive)';
    ok (not [!=:=] $y, $y, $x), '[!=:=] basic sanity (negative)';
    $y := $x;
    ok (    [=:=]  $y, $x, $y), '[=:=] after binding';
}

{
    my $a = [1, 2];
    my $b = [1, 2];

    ok (    [===] 1, 1, 1, 1),      '[===] with literals';
    ok (    [===] $a, $a, $a),      '[===] with vars (positive)';
    ok (not [===] $a, $a, [1, 2]),  '[===] with vars (negative)';
    ok (    [!===] $a, $b, $a),     '[!===] basic sanity (positive)';
    ok (not [!===] $a, $b, $b),     '[!===] basic sanity (negative)';
}

{
    is (~ [\<]  1, 2, 3, 4), "1 1 1 1", "[\\<] works (1)";
    is (~ [\<]  1, 3, 2, 4), "1 1 0 0", "[\\<] works (2)";
    is (~ [\>]  4, 3, 2, 1), "1 1 1 1", "[\\>] works (1)";
    is (~ [\>]  4, 2, 3, 1), "1 1 0 0", "[\\>] works (2)";
    is (~ [\==]  4, 4, 4),   "1 1 1",   "[\\==] works (1)";
    is (~ [\==]  4, 5, 4),   "1 0 0",   "[\\==] works (2)";
    is (~ [\!=]  4, 5, 6),   "1 1 1",   "[\\!=] works (1)";
    is (~ [\!=]  4, 5, 5),   "1 1 0",   "[\\!=] works (2)";
    is (~ [\**]  1, 2, 3),   "3 8 1",   "[\\**] (right assoc) works (1)";
    is (~ [\**]  3, 2, 0),   "0 1 3",   "[\\**] (right assoc) works (2)";
}

{
  my @array = (Mu, Mu, 3, Mu, 5);
  is ([//]  @array), 3, "[//] works";
   #?rakudo skip '[orelse]'
  is ([orelse] @array), 3, "[orelse] works";
}

{
  my @array = (Mu, Mu, 0, 3, Mu, 5);
  is ([||] @array), 3, "[||] works";
  is ([or] @array), 3, "[or] works";

  # Mu as well as [//] should work too, but testing it like
  # this would presumably emit warnings when we have them.
  is (~ [\||] 0, 0, 3, 4, 5), "0 0 3 3 3", "[\\||] works";
}

{
  my @array = (Mu, Mu, 0, 3, Mu, 5);
  my @array1 = (2, 3, 4);
  nok ([&&] @array), "[&&] works with 1 false";
  is ([&&] @array1), 4, "[&&] works";
  nok ([and] @array), "[and] works with 1 false";
  is ([and] @array1), 4, "[and] works";
}

# not currently legal without an infix subscript operator
# {
#   my $hash = {a => {b => {c => {d => 42, e => 23}}}};
#   is try { [.{}] $hash, <a b c d> }, 42, '[.{}] works';
# }
# 
# {
#   my $hash = {a => {b => 42}};
#   is ([.{}] $hash, <a b>), 42, '[.{}] works two levels deep';
# }
# 
# {
#   my $arr = [[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]];
#   is ([.[]] $arr, 1, 0, 2), 9, '[.[]] works';
# }

{
  # 18:45 < autrijus> hm, I found a way to easily do linked list consing in Perl6
  # 18:45 < autrijus> [=>] 1..10;
  my $list = [=>] 1,2,3;
  is $list.key,                 1, "[=>] works (1)";
  is (try {$list.value.key}),   2, "[=>] works (2)";
  is (try {$list.value.value}), 3, "[=>] works (3)";
}

{
    my @array = <5 -3 7 0 1 -9>;
    # according to http://irclog.perlgeek.de/perl6/2008-09-10#i_560910
    # [,] returns a scalar (holding an Array)
    my $count = 0;
    $count++ for [,] @array;
    is $count, 1, '[,] returns a single Array';
    ok ([,] @array) ~~ Positional, '[,] returns something Positional';
}

# Following two tests taken verbatim from former t/operators/reduce.t
lives_ok({my @foo = [1..3] >>+<< [1..3] >>+<< [1..3]},'Sanity Check');
lives_ok({my @foo = [>>+<<] ([1..3],[1..3],[1..3])},'Parse [>>+<<]');

# Check that user defined infix ops work with [...], too.
#?pugs todo 'bug'
#?rakudo skip 'reduce of user defined op'
{
    sub infix:<more_than_plus>(Int $a, Int $b) { $a + $b + 1 }
    is (try { [more_than_plus] 1, 2, 3 }), 8, "[...] reduce metaop works on user defined ops";
}

# {
#   my $arr = [ 42, [ 23 ] ];
#   $arr[1][1] = $arr;
# 
#   is try { [.[]] $arr, 1, 1, 1, 1, 1, 0 }, 23, '[.[]] works with infinite data structures';
# }
# 
# {
#   my $hash = {a => {b => 42}};
#   $hash<a><c> = $hash;
# 
#   is try { [.{}] $hash, <a c a c a b> }, 42, '[.{}] works with infinite data structures';
# }

# L<S03/"Reduction operators"/"Among the builtin operators, [+]() returns 0 and [*]() returns 1">

is( ([*]()), 1, "[*]() returns 1");
is( ([+]()), 0, "[+]() returns 0");

is( ([*] 41), 41, "[*] 41 returns 41");
is( ([*] 42), 42, "[*] 42 returns 42");
is( ~([\*] 42), "42", "[\*] 42 returns (42)");
is( ([~] 'towel'), 'towel', "[~] 'towel' returns 'towel'");
is( ([~] 'washcloth'), 'washcloth', "[~] 'washcloth' returns 'washcloth'");
is( ([\~] 'towel'), 'towel', "[\~] 'towel' returns 'towel'");
ok( ([\~] 'towel') ~~ Iterable, "[\~] 'towel' returns something Iterable");
is( ([<] 42), Bool::True, "[<] 42 returns true");
is( ~([\<] 42), "1", "[\<] 42 returns '1'");
ok( ([\<] 42) ~~ Iterable, "[\<] 42 returns something Iterable");

is( ([\*] 1..*).[^10].join(', '), '1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800', 
    'triangle reduce is lazy');
is( ([\R~] 'a'..*).[^8].join(', '), 'a, ba, cba, dcba, edcba, fedcba, gfedcba, hgfedcba',
    'triangle reduce is lazy');

# RT #65164 (TODO: implement [^^])
#?rakudo skip 'implement [^^]'
{
    is [^^](0, 42), 42, '[^^] works (one of two true)';
    is [^^](42, 0), 42, '[^^] works (one of two true)';
    ok ! [^^](1, 42),   '[^^] works (two true)';
    ok ! [^^](0, 0),    '[^^] works (two false)';

    ok ! [^^](0, 0, 0), '[^^] works (three false)';
    ok ! [^^](5, 9, 17), '[^^] works (three true)';

    is [^^](5, 9, 0),  (5 ^^ 9 ^^ 0),  '[^^] mix 1';
    is [^^](5, 0, 17), (5 ^^ 0 ^^ 17), '[^^] mix 2';
    is [^^](0, 9, 17), (0 ^^ 9 ^^ 17), '[^^] mix 3';
    is [^^](5, 0, 0),  (5 ^^ 0 ^^ 0),  '[^^] mix 4';
    is [^^](0, 9, 0),  (0 ^^ 9 ^^ 0),  '[^^] mix 5';
    is [^^](0, 0, 17), (0 ^^ 0 ^^ 17), '[^^] mix 6';
}

# RT #75234
# rakudo had a problem where once-used meta operators weren't installed
# in a sufficiently global location, so using a meta operator in class once
# makes it unusable further on
{
    class A {
        method m { return [~] gather for ^3 {take 'a'} }
    }
    class B {
        method n { return [~] gather for ^4 {take 'b'}}
    }
    is A.new.m, 'aaa',  '[~] works in first class';
    is B.new.n, 'bbbb', '[~] works in second class';
    is ([~] 1, 2, 5), '125', '[~] works outside class';
}

done_testing;
# vim: ft=perl6
