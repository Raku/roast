use v6;

use Test;

plan 7;
# L<S06/"Parameter traits"/"=item is rw">


{
  sub foo($a is rw) {
    $a = 42;
    return 19;
  }

  my $bar = 23;
  is $bar,      23, "basic sanity";
  is foo($bar), 19, "calling a sub with an is rw param";
  is $bar,      42, "sub changed our variable";
  # RT #74830
  dies_ok { eval('foo(28)') }, 'is rw requires a variable';
}

{
  my $anon = -> $a is rw { $a++ };
  my $bar = 10;
  $anon.($bar);
  is($bar, 11, "anon sub changed variable");
}

# See thread "is rw basically a null-op on objects/references?" on p6l
# L<"http://www.nntp.perl.org/group/perl.perl6.language/20671">
{
  my %hash = (a => 23);
  # First check .value = ... works (as this is a dependency for the next test)
  try { %hash.pairs[0].value = 42 };
#?rakudo todo ''
  is %hash<a>, 42, "pairs are mutable";

  for %hash.pairs -> $pair {     # Note: No "is rw"!
    try { $pair.value += 100 };  # Modifies %hash
  }
#?rakudo todo 'Depends on preceding test working'
  is %hash<a>, 142, "'is rw' not necessary on objects/references";
}

# for ... -> ... is rw {...} already tested for in t/statements/for.t.

# vim: ft=perl6
