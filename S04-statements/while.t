use v6;

# L<S04/The C<while> and C<until> statements>

use Test;

plan 10;

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


#?mildew skip 1
# L<S04/The C<for> statement/It is also possible to write>
# while ... -> $x {...}
{
  my @array = 1..5;
  my $str = "";
  while @array.pop -> $x {
      $str ~= $x;
  }
  is $str, '54321', 'while ... -> $x {...} worked (1)';
}

#?mildew skip 1
{
  my @array = 0..5;
  my $str = "";
  while pop @array -> $x {
      $str ~= $x;
  }
  is $str, '54321', 'while ... -> $x {...} worked (2)';
}

#?mildew skip 1
# L<S04/Statement parsing/keywords require whitespace>
{
    throws-like 'my $i = 1; while($i < 5) { $i++; }', X::Comp::Group,
        'keyword needs at least one whitespace after it';
}

# RT #125876
lives-ok { EVAL 'while 0 { my $_ }' }, 'Can declare $_ in a loop body';

# vim: ft=perl6
