use v6;

use Test;

plan 16;


# basic Range

my $r = 1..5;
isa_ok $r, 'Range';
is $r.WHAT, Range;
is $r.perl, '1..5', 'canonical representation';

is (1..5).perl, '1..5', ".perl ..";
is (1^..5).perl, '1^..5', ".perl ^..";
is (1..^5).perl, '1..^5', ".perl ..^";
is (1^..^5).perl, '1^..^5', ".perl ^..^";

my @r = $r;
is @r, [1, 2, 3, 4, 5], 'got the right array';

# Range of Str

my $r = 'a'..'c';
isa_ok $r, 'Range';
is $r.perl, '"a".."c"', 'canonical representation';
my @r = $r;
is @r, [< a b c >], 'got the right array';


# Range in comparisons
#?rakudo 2 skip
ok(3 == 1..5, 'value in range');
ok('b' == 'a'..'z', 'value in range');


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
  is $n, 1, "got the right shift result";
  my @r = $r;
  is @r, [2, 3, 4, 5], 'got the right state change';
  #my $s = 2..5;
  #is $r, $s, "range modified after shift";
}

# vim:set ft=perl:
