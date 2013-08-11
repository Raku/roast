use v6;
use Test;
plan 3;

# A user-declared infix:<;> clashes with statement stopper ';' in Rakudo

my $marker = 0;

sub infix:<;>($a, $b) { 
 $marker = 1;
 0, 0
}; 

my @a = 1; 2; 3; 


is +@a, 1, '@a is array with 1 element';
is @a[0], 1, 'first element of @a eq 1';
is $marker, 0, 'overloaded infix ; hasn\'t been called';

