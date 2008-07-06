use v6;
use Test;
plan 52;

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
  is(([**] 2,2,3),  (2**2**3), "[**] works");

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

    is ([~] [\<]  1, 2, 3, 4), "1 1 1 1", "[\\<] works (1)";
    is ([~] [\<]  1, 3, 2, 4), "1 1 0 0", "[\\<] works (2)";
    is ([~] [\>]  4, 3, 2, 1), "1 1 1 1", "[\\>] works (1)";
    is ([~] [\>]  4, 2, 3, 1), "1 1 0 0", "[\\>] works (2)";
    is ([~] [\==]  4, 4, 4),   "1 1 1",   "[\\==] works (1)";
    is ([~] [\==]  4, 5, 4),   "1 0 0",   "[\\==] works (2)";
    is ([~] [\!=]  4, 5, 6),   "1 1 1",   "[\\!=] works (1)";
    is ([~] [\!=]  4, 5, 4),   "1 0 0",   "[\\!=] works (2)";
}

{
  my @array = (undef, undef, 3, undef, 5);
  is ([//]  @array), 3, "[//] works";
  is ([orelse] @array), 3, "[orelse] works";
}

{
  my @array = (undef, undef, 0, 3, undef, 5);
  is ([||] @array), 3, "[||] works";
  is ([or] @array), 3, "[or] works";

  # undefs as well as [//] should work too, but testing it like
  # this would presumably emit warnings when we have them.
  is (~ [\||] 0, 0, 3, 4, 5), "0 0 3 3 3", "[\\||] works";
}

{
  my $hash = {a => {b => {c => {d => 42, e => 23}}}};
  is try { [.{}] $hash, <a b c d> }, 42, '[.{}] works';
}

{
  my $hash = {a => {b => 42}};
  is ([.{}] $hash, <a b>), 42, '[.{}] works two levels deep';
}

{
  my $arr = [[[1,2,3],[4,5,6]],[[7,8,9],[10,11,12]]];
  is ([.[]] $arr, 1, 0, 2), 9, '[.[]] works';
}

{
  # 18:45 < autrijus> hm, I found a way to easily do linked list consing in Perl6
  # 18:45 < autrijus> [=>] 1..10;
  my $list = [=>] 1,2,3;
  is $list.key,              1, "[=>] works (1)";
  is try{$list.value.key},   2, "[=>] works (2)";
  is try{$list.value.value}, 3, "[=>] works (3)";
}

{
  my @array = <5 -3 7 0 1 -9>;
  is ([,] @array), @array, "[,] works (a noop)";
}

# Following two tests taken verbatim from former t/operators/reduce.t
lives_ok({my @foo = [1..3] >>+<< [1..3] >>+<< [1..3]},'Sanity Check');
lives_ok({my @foo = [>>+<<] ([1..3],[1..3],[1..3])},'Parse [>>+<<]');

# Check that user defined infix ops work with [...], too.
sub infix:<more_than_plus>(Int $a, Int $b) { $a + $b + 1 }
is(try { [more_than_plus] 1, 2, 3 }, 8, "[...] reduce metaop works on user defined ops", :todo<bug>);

{
  my $arr = [ 42, [ 23 ] ];
  $arr[1][1] = $arr;

  is try { [.[]] $arr, 1, 1, 1, 1, 1, 0 }, 23, '[.[]] works with infinite data structures';
}

{
  my $hash = {a => {b => 42}};
  $hash<a><c> = $hash;

  is try { [.{}] $hash, <a c a c a b> }, 42, '[.{}] works with infinite data structures';
}

# L<S03/"Reduction operators"/"Among the builtin operators, [+]() returns 0 and [*]() returns 1">

is( [*](), 1, "[*]() returns 1");
is( [+](), 0, "[+]() returns 0");

{
  my ($a, $b);

  ok ([=] $a, $b, 3), '[=] evaluates successfully', :todo<feature>;
  is($a, 3, '[=] assigns successfully (1)', :todo<feature>);
  is($b, 3, '[=] assigns successfully (2)', :todo<feature>);

  ok try { ([=] $a, $b, 4) = 5 }, '[=] lvalue context restored (1)';
  is($a, 5, '[=] lvalue context restored (2)', :todo<feature>);
  is($b, 4, '[=] lvalue context restored (3)', :todo<feature>);

  dies_ok { [=] "this_is_a_constant", 42 },
      "[=] can't assign to constants (1)", :todo<feature>;
  dies_ok { [=] $a, $b, "this_is_a_constant", 42 },
      "[=] can't assign to constants (2)", :todo<feature>;
}
