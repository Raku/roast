use v6;

use Test;

plan 31;


# basic Range

my $r = 1..5;
isa_ok $r, Range, 'Type';
is $r.WHAT, Range, 'Type';
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


{
  my $r = 1..5;
  #?rakudo 4 skip '.ACCEPTS not implemented between ranges'
  ok(($r).ACCEPTS($r), 'accepts self');
  ok(($r).ACCEPTS(1..5), 'accepts same');
  ok($r ~~ $r, 'accepts self');
  ok($r ~~ 1..5, 'accepts same');
  # TODO check how to avoid "eager is"
  #is($r, $r, "equals to self");
  my $s = 1..5;
  #is($r, $s, "equals");
}


# Range in comparisons
ok((1..5).ACCEPTS(3), 'int in range');
ok(3 ~~ 1..5, 'int in range');
ok(3 !~~ 6..8, 'int not in range');

ok(('a'..'z').ACCEPTS('x'), 'str in range');
##?rakudo 3 skip 'infix:~~ not implemented between Range and Str'
ok('x' ~~ 'a'..'z', 'str in range');
ok('x' !~~ 'a'..'c', 'str not in range');
ok(('aa'..'zz').ACCEPTS('ax'), 'str in range');
ok(('a'..'zz').ACCEPTS('ax'), 'str in range');


#?rakudo 6 skip 'numification of Range not implemented'
is(+(6..6), 1, 'numification');
is(+(6^..6), 0, 'numification');
is(+(6..^6), 0, 'numification');
is(+(6..8), 3, 'numification');
ok(6..6 ~~ 1, 'numification');
ok(6..8 !~~ 3, 'numification');

# shift
{
  my $r = 1..5;
  my $n = $r.shift;
  is $n, 1, "got the right shift result";
  my @r = $r;
  is @r, [2, 3, 4, 5], 'got the right state change';
  my $s = 2..5;
  #is $r, $s, "range modified after shift";
}

# vim:set ft=perl:
