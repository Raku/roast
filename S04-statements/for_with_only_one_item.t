use v6;

use Test;

# L<S04/The C<for> statement>

# Test primarily aimed at PIL2JS

plan 12;

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

# for with only one item, an arrayitem
# See thread "for $arrayitem {...}" on p6l started by Ingo Blechschmidt,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22970">
{
  my $arrayitem = [1,2,3];

  my $count=0;
  for ($arrayitem,) { $count++ }

  is $count, 1, 'for ($arrayitem,) {...} executes the loop body only once';
}

{
  my $arrayitem = [1,2,3];

  my $count=0;
  for ($arrayitem) { $count++ }

  is $count, 1, 'for ($arrayitem) {...} executes the loop body only once';
}

{
  my $arrayitem = [1,2,3];

  my $count=0;
  for $arrayitem { $count++ }

  is $count, 1, 'for $arrayitem {...} executes the loop body only once';
}

# for with only one item, is rw
{
  my $a = 42;

  for ($a,) -> $v is rw { $v++ }
  is $a, 43, "for on (a_single_var,) -> is rw";
}

{
  my $a = 42;

  try for ($a) -> $v is rw { $v++ }
  is $a, 43, "for on (a_single_var) -> is rw";
}

{
  my $a = 42;

  try for $a -> $v is rw { $v++ }
  is $a, 43, "for on a_single_var -> is rw";
}

# https://github.com/Raku/old-issue-tracker/issues/1590
{
  my $capture = \[1,2,3];
  my $count = 0;
  for $capture { $count++ }

  is $count, 1, 'for $capture {...} executes the loop body only once';
}

# vim: expandtab shiftwidth=4
