use v6;

use Test;

plan 34;

# Test the topical aspects of the with statement modifier

# test the ``with'' statement modifier
{
    my $a = 0;
    $a = $_ with 2 * 3;
    is($a, 6, "post with");
}

# test the ``with'' statement modifier
{
    my $a;
    $a = $_ with 2 * 3;
    is($a, 6, "post with");
}

{
    my $a = '';
    $a = $_ with 'a';
    is($a, 'a', "post with");
}

# RT #121049
{
    my $a = '';
    for ^2 { my $b = $_ with 'a'; $a ~= $b; }
    is($a, 'aa', 'post with in a loop');
}

# L<S04/The C<for> statement/for and with privately temporize>
{
    my $i = 0;
    $_ = 10;
    $i += $_ with $_+3;
    is $_, 10, 'outer $_ did not get updated in lhs of with';
    is $i, 13, 'postfix with worked';
}

# RT #100746
{
    $_ = 'bogus';
    my @r = gather { take "{$_}" with 'cool' }
    is @r[0], 'cool', 'with modifies the $_ that is visible to the {} interpolator';
}

# RT #111704
{
    my $a = 'many ';
    try { $a ~= $_ } with 'pelmeni';
    is $a, 'many pelmeni', 'Correct $_ in try block in statement-modifying with';
}

{
    my $a;
    { $a = $^x } with 69;
    is $a, 69, 'with modifier with $_-using block runs block with correct arg';
}

{
    my $a;
    { $a = $^x } with 42;
    is $a, 42, 'with modifier with placeholder block runs block with correct arg';
}

{
    # Covers a bug where the block to first got compiled in the 'with' thunk
    my @a;
    for ^2 -> \c { 1 with first { @a.push(c); 0 }, ^2; };
    is @a, (0, 0, 1, 1), 'with thunk does not mess up statement modifier closures';
}

# Test the conditional of the with statement modifier

{
    my $a = 1;
    $a = 2 with 'a' eq 'a';
    is($a, 2, "post with True");
}

{
    my $a = 1;
    $a = 3 with 'a' eq 'b';
    is($a, 3, "post with False");
}

{
    my $a = 1;
    $a = 3 with Int;
    is($a, 1, "post with type object");
}

{
	my $answer = 1;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "with expr on true cond"; 
}

{
	my $answer = 0;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 42, 43;
	is @y, @z, "sanity check";
	is @x, @y, "with expr on true cond"; 
}

{
	my $answer = Nil;
	my @x = 41, (42 with $answer), 43;
	my @y = 41, ($answer andthen 42), 43;
	my @z = 41, 43;
	is @y, @z, "sanity check";
        #?niecza todo "empty list as element not flattened - https://github.com/sorear/niecza/issues/180"
	is @x, @y, "with expr on false cond"; 
}

{
	my $answer = Failure.new;
        my @x;
	try @x = 41, (42 with $answer), 43;
	my @y;
        try @y = 41, ($answer andthen 42), 43;
	my @z = 41, 43;

	is @y, @z, "sanity check";
        #?niecza todo "empty list as element not flattened - https://github.com/sorear/niecza/issues/180"
	is @x, @y, "with expr on false cond"; 
}

{
	sub foo() {
	 return () with 1;
	 123;
	}
	
	my $ok = 1;
	for foo() -> @foo {
	    $ok = 0;
	}
	ok $ok, "condition in statement level respects context" 
}

{
    my $x = (3 with 1);
    my $y = (3 with 0);
    my $z = (3 with Nil);
    is $x, 3, '(3 with 1) worked in scalar context';
    is $y, 3, '(3 with 0) worked in scalar context';
    ok !$z, 'my $y = (3 with Nil) leaves $y false';
}

{
    is-deeply (42 with Nil), Empty, '"$something with Nil" is Empty';
}

{
    my $a = 'oops';
    { $a = 'ok' } with 1;
    is $a, 'ok', 'Statement-modifier with runs bare block';
}

{
    my $a = 'oops';
    $a = $_ with 2;
    is $a, 2, 'Statement-modifier with runs bare code with topic';
}

{
    my $a = 'oops';
    { $a = $^x } with 100;
    is $a, 100, 'Statement-modifier with runs block with placeholder';
}

{
    my $ok = 0;
    my @a = 1; $ok = 1 with @a;
    ok $ok, "with treats @a with elems as defined";
}

# List comprehensions

{
    my @x;
    try (push @x, .abs with 12 div $_) for 0..4;
    is @x, (12,6,4,3), 'with/for list comprehension works with parens';
}

#?rakudo todo "parenless with/for doesn't work yet"
{
    my @x;
    try push @x, .abs with 12 div $_ for 0..4;
    is @x, (12,6,4,3), 'with/for list comprehension works without parens';
}

{
    my @x;
    try (push @x, .WHAT.gist without 12 div $_) for 0..4;
    is @x, '(Failure)', 'without/for list comprehension works with parens';
}

# vim: ft=perl6
