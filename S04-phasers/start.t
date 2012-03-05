use v6;

use Test;

plan 21;

# L<S04/"Phasers"/START "runs separately for each clone">
#?pugs todo
{
    is(eval(q{{
        my $str;
        for 1..2 {
            my $sub = {
                START { $str ~= $_ };
            };
            $sub();
            $sub();
        }
        $str;
    }}), '12');
};

# L<S04/"Phasers"/START "puts off" initialization till
#   "last possible moment">
{
    my $var;
    my $sub = sub ($x) { START { $var += $x } };
 
    nok $var.defined, 'START {...} has not run yet';

    $sub(2);
    is $var, 2, 'START {} has executed';

    $sub(3);
    #?pugs todo
    is $var, 2, "START {} only runs once for each clone";
}

# L<S04/"Phasers"/START "on first ever execution">
{
    my $str ~= 'o';
    {
        START { $str ~= 'i' }
    }
    #?pugs todo
    is $str, 'oi', 'START {} runs when we first try to use a block';
}

# L<S04/"Phasers"/START "executes inline">

# Execute the tests twice to make sure that START binds to
# the lexical scope, not the lexical position.
for <first second> {
    my $sub = {
        my $str = 'o';
        START { $str ~= 'I' };
        START { $str ~= 'i' };
        ":$str";
    };
	
    is $sub(), ':oIi', "START block set \$str to 3     ($_ time)";
    #?pugs todo
    is $sub(), ':o', "START wasn't invoked again (1-1) ($_ time)";
    #?pugs todo
    is $sub(), ':o', "START wasn't invoked again (1-2) ($_ time)";
}

# Some behavior occurs where START does not close over the correct
# pad when closures are cloned

my $ran;
for <first second> {
    my $str = 'bana';
    $ran = 0;
    my $sub = {
        START { $ran++; $str ~= 'na' };
    };

    $sub(); $sub();
    #?pugs todo
    is $ran, 1, "START block ran exactly once ($_ time)";
    #?pugs todo
    is $str, 'banana', "START block modified the correct variable ($_ time)";
}

# L<S04/"Phasers"/START "caches its value for all subsequent calls">
{
    my $was_in_start;
    my $sub = {
      my $var = START { $was_in_start++; 23 };
      $var //= 42;
      $var;
    };

    nok $was_in_start.defined, 'START {} has not run yet';
    is $sub(), 23, 'START {} block set our variable (2)';
    #?niecza todo
    is $sub(), 23, 'the returned value of START {} still there';
    #?pugs todo
    is $was_in_start, 1, 'our START {} block was invoked exactly once';
}

# Test that START {} blocks are executed only once even if they return undefined
# (the first implementation ran them twice instead).
#?pugs skip 'No such subroutine: "&Mu"'
{
    my $was_in_start;
    my $sub = { START { $was_in_start++; Mu } };

    nok $sub().defined, 'START {} returned undefined';
    $sub();
    $sub();
    is $was_in_start, 1,
        'our START { ...; Mu } block was invoked exactly once';
}

# vim: ft=perl6
