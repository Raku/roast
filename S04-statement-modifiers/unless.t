use v6;

use Test;

plan 2;

# test the unless statement modifier

# L<S04/"Conditional statements"/Conditional statement modifiers work as in Perl 5>
{
    my $a = 1;
    $a = 4 unless 'a' eq 'a';
    is($a, 1, "post unless");
}

{
    my $a = 1;
    $a = 5 unless 'a' eq 'b';
    is($a, 5, "post unless");
}
