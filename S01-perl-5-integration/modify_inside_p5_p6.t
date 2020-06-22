use v6;
use Test;
plan(2);

my $x = 'test';
my $y = 'case';
{
  use v5;
  $x .= 'ing';

 {
    use v6;
    $y ~= 'book';
  };
};

is $x, 'testing', "scalar modified inside Perl block";

is $y, 'casebook', "scalar modified inside Raku block inside Perl block";

# vim: expandtab shiftwidth=4
