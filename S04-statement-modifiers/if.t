use v6;

use Test;

plan 2;

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
