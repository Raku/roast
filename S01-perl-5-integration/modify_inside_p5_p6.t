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

is $x, 'testing', "scalar modified inside perl5 block";

is $y, 'casebook', "scalar modified inside perl6 block inside perl5 block";

# vim: ft=perl6
