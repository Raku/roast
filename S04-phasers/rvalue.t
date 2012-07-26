use v6;

# Test control blocks (BEGIN/CHECK/INIT/END) used as rvalues
# [TODO] add tests for other control blocks

use Test;

plan 16;

# L<S04/Phasers/"marked with a *" "used within" expression>

{
    my $x = BEGIN { 8 };
    is $x, 8, 'BEGIN block as expression';

    # test that built-ins are available within a BEGIN block:
    my $y = BEGIN { tc 'moin' };
    is $y, 'Moin', 'can access built-in functions in BEGIN blocks';

    my $z = BEGIN { 'moin'.tc };
    is $z, 'Moin', 'can access built-in methods in BEGIN blocks';
}

#?pugs skip 'No such subroutine: "&BEGIN"'
{
    my $x = BEGIN 8;
    is $x, 8, 'BEGIN statement prefix as expression';

    # test that built-ins are available within a BEGIN block:
    my $y = BEGIN tc 'moin';
    is $y, 'Moin', 'can access built-in functions in BEGIN statement prefix';

    my $z = BEGIN 'moin'.tc;
    is $z, 'Moin', 'can access built-in methods in BEGIN statement prefix';
}

#?rakudo skip 'lexicals in phasers'
{
    my $hist = '';

    # Test INIT {} as rval:

    my $init_val;
    my $init = {
        $init_val = INIT { $hist ~= 'I' };
    }

    #?niecza todo 'block returns no value'
    is $init(), 'BCI', 'INIT {} runs only once';
    #?niecza todo 'block returns no value'
    is $init_val, 'BCI', 'INIT {} as rval is its ret val';
    #?niecza todo 'block returns no value'
    is $init(), 'BCI', 'INIT {} runs only once';

    # Test CHECK {} as rval:

    my $check_val;
    my $check = {
        $check_val = CHECK { $hist ~= 'C' };
    }

    #?niecza todo 'block returns no value'
    is $check(), 'BC', 'CHECK {} runs only once';
    #?niecza todo 'block returns no value'
    is $check_val, 'BC', 'CHECK {} as rval is its ret val';
    #?niecza todo 'block returns no value'
    is $check(), 'BC', 'CHECK {} runs only once';

    # Test BEGIN {} as rval:

    my $begin_val;
    my $begin = {
        $begin_val = BEGIN { $hist ~= 'B' };
    }

    #?niecza todo 'block returns no value'
    is $begin(), 'B', 'BEGIN {} runs only once';
    #?niecza todo 'block returns no value'
    is $begin_val, 'B', 'BEGIN {} as rval is its ret val';
    #?niecza todo 'block returns no value'
    is $begin(), 'B', 'BEGIN {} runs only once';

    # Test END {} as rval:
    #?niecza skip 'Excess arguments to eval, used 1 of 2 positionals'
    ok !eval 'my $end_val = END { 3 }', "END {} can't be used as a rvalue";
}

# vim: ft=perl6
