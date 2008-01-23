use v6-alpha;

use Test;

plan 10;

#?rakudo skip "can't parse"
{
  my $i = 0;
  while $i < 5 { $i++; };
  is($i, 5, 'while $i < 5 {} works');
}
#?rakudo skip "can't parse"
{
  my $i = 0;
  while 5 > $i { $i++; };
  is($i, 5, 'while 5 > $i {} works');
}
# with parens
#?rakudo skip "can't parse"
{
  my $i = 0;
  while ($i < 5) { $i++; };
  is($i, 5, 'while ($i < 5) {} works');
}
#?rakudo skip "can't parse"
{
  my $i = 0;
  while (5 > $i) { $i++; };
  is($i, 5, 'while (5 > $i) {} works');
}

# single value
#?rakudo skip "can't parse"
{
  my $j = 0;
  while 0 { $j++; };
  is($j, 0, 'while 0 {...} works');
}
#?rakudo skip "can't parse"
{
  my $k = 0;
  while $k { $k++; };
  is($k, 0, 'while $var {...} works');
}

#?rakudo skip 'No pointy blocks on while loops yet'
# L<S04/The C<for> statement/It is also possible to write>
# while ... -> $x {...}
{
  my @array = 1..5;
  my $str;
  while @array.pop -> $x {
      $str ~= $x;
  }
  is $!, undef, 'eval worked';
  is $str, '54321', 'while ... -> $x {...} worked (1)';
}

#?rakudo skip 'No pointy blocks on while loops yet'
{
  my @array = 0..5;
  my $str;
  while pop @array -> $x {
      $str ~= $x;
  }
  is $!, undef, 'eval worked';
  is $str, '54321', 'while ... -> $x {...} worked (2)';
}
