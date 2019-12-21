use v6;

use Test;

plan 12;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl>

# test the ``given'' statement modifier
{
    my $a = 0;
    $a = $_ given 2 * 3;
    is($a, 6, "post given");
}

# test the ``given'' statement modifier
{
    my $a;
    $a = $_ given 2 * 3;
    is($a, 6, "post given");
}

{
    my $a = '';
    $a = $_ given 'a';
    is($a, 'a', "post given");
}

# RT #121049
{
    my $a = '';
    for ^2 { my $b = $_ given 'a'; $a ~= $b; }
    is($a, 'aa', 'post given in a loop');
}

# L<S04/The C<for> statement/for and given privately temporize>
{
    my $i = 0;
    $_ = 10;
    $i += $_ given $_+3;
    is $_, 10, 'outer $_ did not get updated in lhs of given';
    is $i, 13, 'postfix given worked';
}

# RT #100746
{
    $_ = 'bogus';
    my @r = gather { take "{$_}" given 'cool' }
    is @r[0], 'cool', 'given modifies the $_ that is visible to the {} interpolator';
}

# RT #111704
{
    my $a = 'many ';
    try { $a ~= $_ } given 'pelmeni';
    is $a, 'many pelmeni', 'Correct $_ in try block in statement-modifying given';
}

{
    my $a;
    { $a = $^x } given 69;
    is $a, 69, 'given modifier with $_-using block runs block with correct arg';
}

{
    my $a;
    { $a = $^x } given 42;
    is $a, 42, 'given modifier with placeholder block runs block with correct arg';
}

{
    # Covers a bug where the block to first got compiled in the 'given' thunk
    my @a;
    for ^2 -> \c { 1 given first { @a.push(c); 0 }, ^2; };
    is @a, (0, 0, 1, 1), 'given thunk does not mess up statement modifier closures';
}

# RT #79174
{
    is (1,2, given 3), "1 2", "given is a terminator even after comma";
}

# vim: ft=perl6
