use v6;

use Test;

plan 1;

#L<S02/The C<Num> and C<Rat> Types/For applications that really need arbitrary precision>
{
  my $fatty := FatRat.new(9,10);
  isa_ok( $fatty, FatRat);
}

# vim: ft=perl6
