use v6;

use Test;

plan 15;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

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
	my @x = 41, (42 if $answer), 43;
	my @y = 41, ($answer ?? 42 !! slip()), 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on true cond";
}

{
	my $answer = 0;
	my @x = 41, (42 if $answer), 43;
	my @y = 41, ($answer ?? 42 !! slip()), 43;
	my @z = 41, 43;
	is @y, @z, "sanity check";
	is @x, @y, "if expr on false cond";
}


#testing else part of the operator
{
	my $answer = 0;
	my $x = $answer ?? 42 !! 43;
	is $x, 43, "?? || sanity check";
}

{
	sub foo() {
	 return () if 1;
	 123;
	}

	my $ok = 1;
	for foo() -> @foo {
	    $ok = 0;
	}
	ok $ok, "condition in statement level respects context"
}

{
    my $x = (3 if 1);
    my $y = (3 if 0);
    is $x, 3, '(3 if 1) worked in scalar context';
    ok !$y, 'my $y = (3 if 0) leaves $y false';
}

# return value of false 'if' should be Empty
# RT #66544
{
    is-deeply (42 if 0), Empty, '"$something if 0" is Empty';
}

{
    my $a = 'oops';
    { $a = 'ok' } if 1;
    is $a, 'ok', 'Statement-modifier if runs bare block';
}

# RT #78142
{
    my $a = 'oops';
    { $a = $^x } if 100;
    is $a, 100, 'Statement-modifier if runs block with placeholder';
}

# RT #79174
{
    is (1,2, if 3), "1 2", "if is a terminator even after comma";
}

# https://github.com/rakudo/rakudo/issues/2601
{
    my $res;
    for 1..3 {
        { $res = $_; last } if $_ == 2;
    }
    is $res, 2, 'Correct handling of $_ in block to left of statement modifer if';
}

# vim: ft=perl6
