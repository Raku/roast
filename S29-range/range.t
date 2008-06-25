use v6;

use Test;

plan 5;

{
  my $r = 1..1;
  is $r.WHAT, Range;
}

{
  is (1..5).perl, '1..5', ".perl ..";
  is (1^..5).perl, '1^..5', ".perl ^..";
  is (1..^5).perl, '1..^5', ".perl ..^";
  is (1^..^5).perl, '1^..^5', ".perl ^..^";
}

{
  my $r = 1..5;
  # Will have to check if "is" is eager
  #is $r, $r, "equals to self";
  #my $s = 1..5;
  #is $r, $s, "equals";
}

# shift
{
  my $r = 1..5;
  my $n = $r.shift;
  #is $n, 1, "shift result";
  my $s = 2..5;
  #is $r, $s, "range modified after shift";
}

# vim:set ft=perl:
