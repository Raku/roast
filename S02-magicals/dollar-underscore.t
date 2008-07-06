use v6;

# Tests for a bug uncovered when Jesse Vincent was testing 
# functionality for Patrick Michaud
# TODO: add smartlinks, more tests

use Test;

plan 3;


my @list = ('a');


# Do pointy subs send along a declared param?

for @list -> $letter { is( $letter , 'a') }

# Do pointy subs send along an implicit param? No!
for @list -> { isnt($_, 'a') }

# Hm. PIL2JS currently dies here (&statement_control:<for> passes one argument
# to the block, but the block doesn't expect any arguments). Is PIL2JS correct?

# Do pointy subs send along an implicit param even when a param is declared? No!
for @list -> $letter { isnt( $_ ,'a' ) }

# vim: ft=perl6
