use v6;

use Test;

# See thread "@array = $scalar" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22959">

plan 18;

# @array = $arrayref
{
  my $arrayref = [<a b c>];
  my @array    = ($arrayref,);

  is +@array, 1, '@array = ($arrayref,) does not flatten the arrayref';
}

{
  my $arrayref = [<a b c>];
  my @array    = ($arrayref);

  is +@array, 1, '@array = ($arrayref) does not flatten the arrayref';
}

{
  my $arrayref = [<a b c>];
  my @array    = $arrayref;

  is +@array, 1, '@array = $arrayref does not flatten the arrayref';
}

# %hash = $hashref
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = ($hashref,) };

  #?niecza todo
  is +%hash, 0, '%hash = ($hashref,) does not flatten the hashref';
}

{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = ($hashref) };

  #?pugs todo 'non-flattening hash refs'
  #?niecza todo
  is +%hash, 0, '%hash = ($hashref) does not flatten the hashref';
}

{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = $hashref };

  #?pugs todo 'non-flattening hash refs'
  #?niecza todo
  is +%hash, 0, '%hash = $hashref does not flatten the hashref';
}

# Same as above, but now we never use arrays, but only array*refs*.
# $arrayref2 = $arrayref1
{
  my $foo = [<a b c>];
  my $bar = ($foo,);

  is +$bar, 1, '$bar = ($foo,) does not flatten the arrayref';
}

{
  my $foo = [<a b c>];
  my $bar = ($foo);

  is +$bar, 3, '$bar = ($foo) does flatten the arrayref';
}

{
  my $foo = [<a b c>];
  my $bar = $foo;

  is +$bar, 3, '$bar = $foo does flatten the arrayref';
}

# $hashref2 = $hashref1
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = ($foo,);

  is +$bar, 1, '$bar = ($foo,) does not flatten the hashref';
}

{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = ($foo);

  is +$bar, 3, '$bar = ($foo) does flatten the hashref';
}

{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = $foo;

  is +$bar, 3, '$bar = $foo does flatten the hashref';
}

# Same as above, but now we directly assign into an element.
{
  my $arrayref = [<a b c>];
  my @array;
  @array[0]    = ($arrayref,);

  is +@array, 1, '@array[0] = ($arrayref,) does not flatten the arrayref';
}

{
  my $arrayref = [<a b c>];
  my @array;
  @array[0]    = ($arrayref);

  is +@array, 1, '@array[0] = ($arrayref) does not flatten the arrayref';
}

{
  my $arrayref = [<a b c>];
  my @array;
  @array[0]    = $arrayref;

  is +@array, 1, '@array[0] = $arrayref does not flatten the arrayref';
}

# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = ($hashref,);

  is +%hash, 1, '%hash<a> = ($hashref,) does not flatten the hashref';
}

{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = ($hashref);

  is +%hash, 1, '%hash<a> = ($hashref) does not flatten the hashref';
}

{
  my $hashref = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = $hashref;

  is +%hash, 1, '%hash<a> = $hashref does not flatten the hashref';
}

# vim: ft=perl6
