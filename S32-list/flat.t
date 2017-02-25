use v6;
use Test;

plan 3;

{
  my int @a = 1..5;
  is(@a, @a.flat, '.flat on an already flat list works');

  my @b = ((1,2,3), (4));
  is(@b.flat, @b, '.flat does not recurse into sublists');

  is((1 .. 5).flat, @a, '.flat flattens a Range');
}
