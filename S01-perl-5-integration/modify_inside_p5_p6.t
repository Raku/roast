use v6;
use Test;
plan(2);

my $x = 'test';
my $y = 'case';
{
  use v5;
  $x .= 'ing';

  #the following code hangs pugs.
 {
    # Smoke does not complete because of this
    # Uncomment the following two lines when this is fixed
    #?pugs emit #
    use v6;
    #?pugs emit #
    $y ~= 'book';
  };
};

is $x, 'testing', "scalar modified inside perl5 block";

#?pugs todo 'nested p5/p6 embedding'
is $y, 'casebook', "scalar modified inside perl6 block inside perl5 block";
