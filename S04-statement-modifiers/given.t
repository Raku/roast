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

# L<S04/The C<for> statement/for and given privately temporize>
#?pugs skip "Can't modify constant item"
{
    my $i = 0;
    $_ = 10;
    $i += $_ given $_+3;
    is $_, 10, 'outer $_ did not get updated in lhs of given';
    is $i, 13, 'postfix given worked';
}

# vim: ft=perl6
