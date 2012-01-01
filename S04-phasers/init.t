use v6;

use Test;

plan 11;

# L<S04/"Phasers"/INIT "at run time" ASAP>
# INIT {...} blocks in "void" context
{
    my $str;
    is $str, "begin1 begin2 init ", "init blocks run after begin blocks";

    BEGIN { $str ~= "begin1 "; }
    INIT  { $str ~= "init "; }
    BEGIN { $str ~= "begin2 "; }
}

{
    my $str;
    is $str, "check2 check1 init ", "init blocks run after check blocks";

    CHECK { $str ~= "check1 "; }
    INIT  { $str ~= "init "; }
    CHECK { $str ~= "check2 "; }
}

{
    my $str;
    is $str, "begin init1 init2 ", "init blocks run in forward order";

    INIT  { $str ~= "init1 "; }
    BEGIN { $str ~= "begin "; }
    INIT  { $str ~= "init2 "; }
}

# INIT {...} blocks as rvalues
{
    my $str;
    my $handle = { my $retval = INIT { $str ~= 'I' } };

    is $str, 'I', 'our INIT {...} block already gets called';
    #?niecza todo "no value"
    is $handle(), 'I', 'our INIT {...} block returned the correct var (1)';
    #?niecza todo "no value"
    is $handle(), 'I', 'our INIT {...} block returned the correct var (2)';
    is $str, 'I', 'our rvalue INIT {...} block was executed exactly once';
}

# IRC note:
# <TimToady1> also, the INIT's settings are going to get wiped
#             out when the my is executed, so you probably just
#             end up with 'o'
{
    my $str = 'o';
    INIT { $str ~= 'i' }
    is $str, 'o', 'the value set by INIT {} wiped out by the initializer of $str';
}

# L<S04/"Phasers"/INIT "runs before" "mainline code">

my $str ~= 'o';  # Note that this is different from  "my $str = 'o';".
{
    INIT { $str ~= 'i' }
}
is $str, 'io', 'INIT {} always runs before the mainline code runs';

# L<S04/Phasers/INIT "runs once for all copies of" "cloned closure">
{
	my $var;
	for <first second> {
		my $sub = { INIT { $var++ } };
		is $var, 1, "INIT has run exactly once ($_ time)";
	}
}

# vim: ft=perl6
