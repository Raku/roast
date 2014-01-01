use v6;

use Test;

plan 21;

# L<S04/"Phasers"/once "runs separately for each clone">
#?pugs todo
{
    is(EVAL(q{{
        my $str;
        for 1..2 {
            my $sub = {
                once { $str ~= $_ };
            };
            $sub();
            $sub();
        }
        $str;
    }}), '12');
};

# L<S04/"Phasers"/once "puts off" initialization till
#   "last possible moment">
{
    my $var;
    my $sub = sub ($x) { once { $var += $x } };
 
    nok $var.defined, 'once {...} has not run yet';

    $sub(2);
    is $var, 2, 'once {} has executed';

    $sub(3);
    #?pugs todo
    is $var, 2, "once {} only runs once for each clone";
}

# L<S04/"Phasers"/once "on first ever execution">
{
    my $str ~= 'o';
    {
        once { $str ~= 'i' }
    }
    #?pugs todo
    is $str, 'oi', 'once {} runs when we first try to use a block';
}

# L<S04/"Phasers"/once "executes inline">

# Execute the tests twice to make sure that once binds to
# the lexical scope, not the lexical position.
for <first second> {
    my $sub = {
        my $str = 'o';
        once { $str ~= 'I' };
        once { $str ~= 'i' };
        ":$str";
    };
	
    is $sub(), ':oIi', "once block set \$str to 3     ($_ time)";
    #?pugs todo
    is $sub(), ':o', "once wasn't invoked again (1-1) ($_ time)";
    #?pugs todo
    is $sub(), ':o', "once wasn't invoked again (1-2) ($_ time)";
}

# Some behavior occurs where once does not close over the correct
# pad when closures are cloned

my $ran;
for <first second> {
    my $str = 'bana';
    $ran = 0;
    my $sub = {
        once { $ran++; $str ~= 'na' };
    };

    $sub(); $sub();
    #?pugs todo
    is $ran, 1, "once block ran exactly once ($_ time)";
    #?pugs todo
    is $str, 'banana', "once block modified the correct variable ($_ time)";
}

# L<S04/"Phasers"/once "caches its value for all subsequent calls">
{
    my $was_in_once;
    my $sub = {
      my $var = once { $was_in_once++; 23 };
      $var //= 42;
      $var;
    };

    nok $was_in_once.defined, 'once {} has not run yet';
    is $sub(), 23, 'once {} block set our variable (2)';
    #?niecza todo
    is $sub(), 23, 'the returned value of once {} still there';
    #?pugs todo
    is $was_in_once, 1, 'our once {} block was invoked exactly once';
}

# Test that once {} blocks are executed only once even if they return undefined
# (the first implementation ran them twice instead).
{
    my $was_in_once;
    my $sub = { once { $was_in_once++; Mu } };

    nok $sub().defined, 'once {} returned undefined';
    $sub();
    $sub();
    #?pugs todo
    is $was_in_once, 1,
        'our once { ...; Mu } block was invoked exactly once';
}

# vim: ft=perl6
