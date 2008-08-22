use v6;

use Test;

plan 7;

{
  my %hash = (a => 1, b => 2);
  is "%hash<a>",   1, '"%hash<a>" works';
  is "<%hash<a>>", '<1>', '"<%hash<a>>" works';
}

{
  my $hash = { a => 1, b => 2 };
  is "$hash<a>",   1, '"$hash<a>" works';
  is "<$hash<a>>", '<1>', '"<$hash<a>>" works';
}

{
  # L<S02/Literals/In order to interpolate an entire hash>
  my %hash = { a=> 1, b => 2 };
  is "%hash{}", "a\t1\nb\t2\n", 'interpolation with curly braces';
  is "%hash<>", "a\t1\nb\t2\n", 'interpolation with angle brackets';
  is "%hash", '%hash', 'no interpolation';
}
