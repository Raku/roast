use v6;

use Test;

plan 8;

{
    my $i = 0;
    while $i < 5 { $i++; };
    is($i, 5, 'while $i < 5 {} works');
}

{
    my $i = 0;
    while 5 > $i { $i++; };
    is($i, 5, 'while 5 > $i {} works');
}

# with parens
{
    my $i = 0;
    while ($i < 5) { $i++; };
    is($i, 5, 'while ($i < 5) {} works');
}

{
    my $i = 0;
    while (5 > $i) { $i++; };
    is($i, 5, 'while (5 > $i) {} works');
}

# single value
{
    my $j = 0;
    while 0 { $j++; };
    is($j, 0, 'while 0 {...} works');
}

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
  is $str, '54321', 'while ... -> $x {...} worked (1)';
}

#?rakudo skip 'No pointy blocks on while loops yet'
{
  my @array = 0..5;
  my $str;
  while pop @array -> $x {
      $str ~= $x;
  }
  is $str, '54321', 'while ... -> $x {...} worked (2)';
}
