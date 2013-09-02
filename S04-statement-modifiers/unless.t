use v6;

use Test;

plan 6;

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

{
        my $answer = 1;
        my @x = 41, (42 unless $answer), 43;
        my @y = 41, (!$answer ?? 42 !! ()), 43;
        my @z = 41, 43;
        is @y, @z, "sanity check";
        #?niecza todo "empty list as element not flattened - https://github.com/sorear/niecza/issues/180"
        is @x, @y, "unless expr on true cond";
}

{
        my $answer = 0;
        my @x = 41, (42 unless $answer), 43;
        my @y = 41, (!$answer ?? 42 !! ()), 43;
        my @z = 41, 42, 43;
        is @y, @z, "sanity check";
        is @x, @y, "unless expr on false cond";
}


# vim: ft=perl6
