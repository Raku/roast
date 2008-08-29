use v6;

use Test;

plan 5;

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl 5>

# test the ``given'' statement modifier
{
    my $a = 0;
    $a = $_ given 2 * 3;
    is($a, 6, "post given");
}

# test the ``given'' statement modifier
#?rakudo skip 'rakudo dies on assignment to uninitialized variable when modifier given used'
{
    my $a;
    $a = $_ given 2 * 3;
    is($a, 6, "post given");
}

{
    my $a = '';
    my $a = $_ given 'a';
    is($a, 'a', "post given");
}

# L<S04/The C<for> statement/"given" "use a private instance of" $_>
{
    my $i = 0;
    $_ = 10;
    $i += $_ given $_+3;
    #?rakudo todo 'outer $_ should not get updated in given modifier'
    is $_, 10, 'outer $_ did not get updated in lhs of given';
    is $i, 13, 'postfix given worked';
}
