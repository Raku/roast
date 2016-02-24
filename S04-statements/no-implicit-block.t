use v6.c;

use Test;

plan 12;

# L<S04/The Relationship of Blocks and Declarations/"no implicit blocks" around 
#   "standard control structures">
{
    my $y;
    if (my $x = 2) == 2 {
        $y = $x + 3;
    }
    is $x, 2, '$x assigned in if\'s condition';
    is $y, 5, '$y assigned in if\'s body';
}

{
    my $y;
    unless (my $x = 2) != 2 {
        $y = $x + 3;
    }
    is $x, 2, '$x assigned in unless\'s condition';
    is $y, 5, '$y assigned in unless\'s body';
}

{
    my $y;
    given my $x = 2 {
        when 2 { $y = $x + 3; }
    }
    is $x, 2, '$x assigned in given\'s condition';
    is $y, 5, '$y assigned in given\'s body';
}

{
    my $y;
    while my $x = 2 {
        $y = $x + 3;
        last;
    }
    is $x, 2, '$x assigned in while\'s condition';
    is $y, 5, '$y assigned in while\'s body';
}

{
    my $y;
    for my @a = 1..3 {
        $y = @a[1] + 3;
        last;
    }
    is ~@a, '1 2 3', '@a assigned in for\'s condition';
    is $y, 5, '$y assigned in for\'s body';
}

{
    my $y;
    loop (my $x = 2; $x < 10; $x++) {
        $y = $x + 3;
        last;
    }
    is $x, 2, '$x assigned in loop\'s condition';
    is $y, 5, '$y assigned in loop\'s body';
}

# vim: ft=perl6
