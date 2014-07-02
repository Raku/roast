use v6;

use Test;

plan 10;

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
  # L<S02/Arrays/In order to interpolate an entire hash>
  my %hash = b => 2;
  #?niecza 2 todo 'zen hash slice'
  is "%hash{}", "b\t2", 'interpolation with curly braces';
  is "%hash<>", "b\t2", 'interpolation with angle brackets';
  is "%hash", '%hash', 'no interpolation';
}

{
    # "%hash{a}" actually calls a(). Test that.
    my %hash = (a => 1, b => 2);
    sub do_a {
        'b';
    }
    is "%hash{do_a}", "2",  '%hash{do_a} calls do_a()';

    is "%hash{'b'}",  "2",  'can quote hash indexes in interpolations 1';
    is "%hash{"b"}",  "2",  'can quote hash indexes in interpolations 2';
}

# vim: ft=perl6
