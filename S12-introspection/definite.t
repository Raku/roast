use v6;

use Test;

plan 4;

=begin pod

Tests for .DEFINITE from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The DEFINITE macro">

is Int.DEFINITE, False, ".DEFINITE on type object";
is 42.DEFINITE, True,   ".DEFINITE on literal value";

my $x;
is $x.DEFINITE, False,  ".DEFINITE on undeclared variable";
$x = 'OMG THAT KANGAROO IS ON FIRE!!!11!';
is $x.DEFINITE, True,   ".DEFINITE on variable with value";
