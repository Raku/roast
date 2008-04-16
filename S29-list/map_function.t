use v6;
use Test;
plan 2;

# L<S29/"List"/"=item map">
sub dbl ( Int  $val ) { 2*$val };
is( ~((1..3).map:{ 2*$_ }),'2 4 6','intern method in map');
is( ~((1..3).map:{ dbl( $_ ) }),'2 4 6','extern method in map');

