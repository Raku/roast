use v6.c;

# L<S04/The C<while> and C<until> statements>

use Test;

plan 28;

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

# RT #126005
{
    my $undone = 0;
    my $x = 0;
    is (while ++$x < 3 { UNDO ++$undone; +$x }), '1 2', 'can return values from a while';
    is $undone, 0, "UNDO doesn't run in successful loop block";
}

{
    my $undone = 0;
    my $x = 0;
    is (while ++$x < 3 { UNDO ++$undone; Nil }).gist, '(Nil Nil)', 'can return undefined values from a while';
    is $undone, 2, "UNDO does run in unsuccessful loop block";
}

{
    my $undone = 0;
    my $x = 0;
    is (until ++$x > 2 { UNDO ++$undone; +$x }), '1 2', 'can return values from an until';
    is $undone, 0, "UNDO doesn't run in successful loop block";
}

{
    my $undone = 0;
    my $x = 0;
    ok (until ++$x > 2 { UNDO ++$undone; Failure.new }) ~~ (Failure,Failure), 'can return undefined values from an until';
    is $undone, 2, "UNDO does run in unsuccessful loop block";
}

{
    my $undone = 0;
    my $x = 0;
    while ++$x < 3 { UNDO ++$undone; True }
    is $undone, 0, "UNDO doesn't run in successful loop block, even in sink context";
}

{
    my $undone = 0;
    my $x = 0;
    while ++$x < 3 { UNDO ++$undone; Nil }
    is $undone, 2, "UNDO does run in unsuccessful loop block, even in sink context";
}

{
    my $undone = 0;
    is (loop (my $x = 0; ++$x < 3; ) { UNDO ++$undone; +$x }), '1 2', 'can return values from a loop';
    is $undone, 0, "UNDO doesn't run in successful loop block";
}

#?rakudo skip "bug, loops"
{
    my $undone = 0;
    is (loop (my $x = 1; $x < 3; ++$x) { UNDO ++$undone; +$x }), '1 2', 'can return values from a loop';
    is $undone, 0, "UNDO doesn't run in successful loop block";
}

{
    $_ = 0;
    is (+$_ while ++$_ < 10), '1 2 3 4 5 6 7 8 9', 'can use while modifier for values';
}

{
    $_ = 0;
    is (+$_ until ++$_ > 9), '1 2 3 4 5 6 7 8 9', 'can use while modifier for values';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 while ++$_ < 10), '2 4 6 8', 'can use while as list comprehension';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 until ++$_ > 9), '2 4 6 8', 'can use while as list comprehension';
}

# vim: ft=perl6
