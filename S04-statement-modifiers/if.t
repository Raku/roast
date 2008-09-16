use v6;

use Test;

plan 8;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl 5>

# test the if statement modifier
{
    my $a = 1;
    $a = 2 if 'a' eq 'a';
    is($a, 2, "post if");
}

{
    my $a = 1;
    $a = 3 if 'a' eq 'b';
    is($a, 1, "post if");
}

{
	my $answer = 1;
	my @x = 41, [eval (42 if $answer)], 43;
	my @y = 41, [($answer ?? 42 !! ())], 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on true cond"; 
}

#?rakudo todo '(N if $expr) is not equiv. to ($expr ?? N !! ()).'
{
	my $answer = 0;
	my @x = 41, [eval (42 if $answer)], 43;
	my @y = 41, [($answer ?? 42 !! ())], 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on true cond"; 
}


#testing else part of the operator 
{
	my $answer = 0;
	my $x = $answer ?? 42 !! 43;
	is $x, 43, "?? || sanity check";
}

{
	sub foo() {
	 return if 1;
	 123;
	}
	
	my $ok = 1;
	for foo() -> @foo {
	    $ok = 0;
	}
	ok $ok, "condition in statement level respects context" 
}
