use v6;

use Test;

=begin description

This test tests the C<produce> builtin.

=end description

plan 23;

{
    is-deeply (produce *+*, 1..10), +«<1 3 6 10 15 21 28 36 45 55>, "produce listop works on a range (+)";
    is-deeply (1..10).produce(*+*), +«<1 3 6 10 15 21 28 36 45 55>, "produce method works on a range (+)";
    is-deeply (1..10).produce(*+*), [\+](1..10), "produce method is identical to triangle reduce (+)";
}

{
    is-deeply (produce &[*], 1..5), +«<1 2 6 24 120>, "produce listop works on a range (*)";
    is-deeply (1..5).produce(&[*]), +«<1 2 6 24 120>, "produce method works on a range (*)";
    is-deeply (1..5).produce(&[*]), [\*](1..5), "produce method is identical to triangle reduce (*)";
    is-deeply (2..4).produce(&[**]), [\**](2..4), "produce method is identical to triangle reduce (**)";
}

{
  my @array = <5 -3 7 0 1 -9>;
  is-deeply (produce &[+], @array), [\+](@array), "produce listop works on random integers (+)";
  is-deeply (produce &[*], @array), [\*](@array), "produce listop works on random integers (*)";
  is-deeply (produce &[/], @array), [\/](@array), "produce listop works on random integers (/)";
  is-deeply (produce &[~], @array), [\~](@array), "produce listop works on random integers (~)";
}

# Produce with n-ary functions
#?rakudo skip "busted"
{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my @result =
       1 + 2 * 3,
      (1 + 2 * 3) + 4 * 5,
     ((1 + 2 * 3) + 4 * 5) + 6 * 7,
    (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * 9;

  is (@array.produce: { $^a + $^b * $^c }).gist, @result.gist, "n-ary produce() works";
}

# Produce with right associative n-ary functions
#?rakudo skip "busted"
{
  my @array  = <1 2 3 4 5 6 7 8 9>;
  my @result =
                               7 + 8 * 9,
                      5 + 6 * (7 + 8 * 9),
             3 + 4 * (5 + 6 * (7 + 8 * 9)),
    1 + 2 * (3 + 4 * (5 + 6 * (7 + 8 * 9)));
  sub rightly is assoc<right> { $^a + $^b * $^c }

  is (@array.produce: &rightly).gist, @result.gist, "right assoc n-ary produce() works";
}

{
  is( 42.produce( {$^a+$^b} ), 42,  "method form of produce works on numbers");
  is( 'str'.produce( {$^a+$^b} ), 'str', "method form of produce works on strings");
  is ((42,).produce: { $^a + $^b }), 42, "method form of produce should work on arrays";
}

{
  my $hash = {a => {b => {c => 42}}};
  my @reftypes;
  sub foo (Hash $hash, Str $key) {
    push @reftypes, $hash ~~ Hash;
    $hash.{$key};
  }
  is((produce(&foo, flat $hash, <a b c>)).gist, '(a => b => c => 42 b => c => 42 c => 42 42)', 'produce(&foo) (foo ~~ .{}) works three levels deep');
  ok ([&&] @reftypes), "All the types were hashes";
}

is( (1).list.produce({$^a * $^b}), 1, "Produce of one element list produces correct result");

eval-lives-ok( 'produce -> $a, $b, $c? { $a + $b * ($c//1) }, 1, 2', 'Use proper arity calculation');

{
    is( ((1..10).list.produce: &infix:<+>), '1 3 6 10 15 21 28 36 45 55', '.produce: &infix:<+> works' );
    is( ((1..4).list.produce: &infix:<*>), '1 2 6 24', '.produce: &infix:<*> works' );
}

# RT #66352
{
    multi a (Str $a, Str $b) { [+$a, +$b] };
    multi a (Array $a,$b where "+") { [+] @($a) };  #OK not used
    is ("1", "2", "+").produce(&a).gist, '(1 [1 2] 3)', 'produce and multi subs';
}

# vim: ft=perl6
