use v6;

use Test;

plan 4;

# L<S04/"Conditional statements"/that the first expression within parens or brackets is parsed as a statement>

{
	my $answer = 1;
	my @x = 41, eval q[(42 if $answer)], 43;
	my @y = 41, ($answer ?? 42 !! ()), 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on true cond", :todo<feature>;
}

{
	my $answer = 0;
	my @x = 41, eval q[(42 if $answer)], 43;
	my @y = 41, ($answer ?? 42 !! ()), 43;
	my @z = 41, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on false cond", :todo<feature>;
}
