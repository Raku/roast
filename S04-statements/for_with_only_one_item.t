use v6;

use Test;

# L<S04/The C<for> statement>

# Test primarily aimed at PIL2JS

plan 9;

# sanity tests
{
  my $res='';

  for <a b c> { $res ~= $_ }
  is $res, "abc", "for works with an <...> array literal";
}

{
  my $res='';

  for (<a b c>) { $res ~= $_ }
  is $res, "abc", "for works with an (<...>) array literal";
}

# for with only one item, a constant
{
  my $res='';

  for ("a",) { $res ~= $_ }
  is $res, "a", "for works with an (a_single_constant,) array literal";
}

{
  my $res='';

  for ("a") { $res ~= $_ }
  is $res, "a", "for works with (a_single_constant)";
}

{
  my $res='';

  for "a" { $res ~= $_ }
  is $res, "a", "for works with \"a_single_constant\"";
}

# for with only one item, an arrayref
# See thread "for $arrayref {...}" on p6l started by Ingo Blechschmidt,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22970">
{
  my $arrayref = [1,2,3];

  my $count=0;
  for ($arrayref,) { $count++ }

  is $count, 1, 'for ($arrayref,) {...} executes the loop body only once';
}

{
  my $arrayref = [1,2,3];

  my $count=0;
  for ($arrayref) { $count++ }

  is $count, 1, 'for ($arrayref) {...} executes the loop body only once';
}

{
  my $arrayref = [1,2,3];

  my $count=0;
  for $arrayref { $count++ }

  is $count, 1, 'for $arrayref {...} executes the loop body only once';
}

# RT #73400
{
  my $capture = \[1,2,3];
  my $count = 0;
  for $capture { $count++ }

  is $count, 1, 'for $capture {...} executes the loop body only once';
}

# vim: ft=perl6
