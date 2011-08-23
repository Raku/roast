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
  my %hash = { a=> 1, b => 2 };
  #?rakudo 2 skip 'zen hash slice'
  #?niecza 2 skip 'zen hash slice'
  is "%hash{}", "a\t1\nb\t2\n", 'interpolation with curly braces';
  is "%hash<>", "a\t1\nb\t2\n", 'interpolation with angle brackets';
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
