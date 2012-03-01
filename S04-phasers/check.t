use v6;

use Test;

plan 5;

# L<S04/"Phasers"/CHECK "at compile time" ALAP>
# CHECK {...} block in "void" context
#?pugs todo
{
    my $str;
    BEGIN { $str ~= "begin1 "; }
    CHECK { $str ~= "check "; }
    BEGIN { $str ~= "begin2 "; }

    is $str, "begin1 begin2 check ", "check blocks run after begin blocks";
}

#?pugs todo
{
    my $str;
    CHECK { $str ~= "check1 "; }
    BEGIN { $str ~= "begin "; }
    CHECK { $str ~= "check2 "; }

    is $str, "begin check2 check1 ", "check blocks run in reverse order";
}

# CHECK {...} blocks as rvalues
{
    my $str;
    my $handle = { my $retval = CHECK { $str ~= 'C' } };

    is $handle(), 'C', 'our CHECK {...} block returned the correct var (1)';
    is $handle(), 'C', 'our CHECK {...} block returned the correct var (2)';
    #?pugs todo
    is $str, 'C', 'our rvalue CHECK {...} block was executed exactly once';
}

# vim: ft=perl6
