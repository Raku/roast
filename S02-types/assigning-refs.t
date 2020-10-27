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

# %hash = $hashitem
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = ($hashitem,) };

  is +%hash, 0, '%hash = ($hashitem,) does not flatten the hashitem';
}

{
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = ($hashitem,) };

  is +%hash, 0, '%hash = ($hashitem,) does not flatten the hashitem';
}

{
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  try { %hash = $hashitem };

  is +%hash, 3, '%hash = $hashitem works due to single argument rule';
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

# $hashitem2 = $hashitem1
# Of course, these (should) give a warning ("odd number in hash construction").
{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = ($foo,);

  is +$bar, 1, '$bar = ($foo,) does not flatten the hashitem';
}

{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = ($foo);

  is +$bar, 3, '$bar = ($foo) does flatten the hashitem';
}

{
  my $foo = {:a(1), :b(2), :c(3)};
  my $bar = $foo;

  is +$bar, 3, '$bar = $foo does flatten the hashitem';
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
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = ($hashitem,);

  is +%hash, 1, '%hash<a> = ($hashitem,) does not flatten the hashitem';
}

{
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = ($hashitem);

  is +%hash, 1, '%hash<a> = ($hashitem) does not flatten the hashitem';
}

{
  my $hashitem = {:a(1), :b(2), :c(3)};
  my %hash;
  %hash<a>    = $hashitem;

  is +%hash, 1, '%hash<a> = $hashitem does not flatten the hashitem';
}

# vim: expandtab shiftwidth=4
