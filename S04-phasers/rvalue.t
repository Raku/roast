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
    my $y = BEGIN { ucfirst 'moin' };
    is $y, 'Moin', 'can access built-in functions in BEGIN blocks';

    my $z = BEGIN { 'moin'.ucfirst };
    is $z, 'Moin', 'can access built-in methods in BEGIN blocks';
}

{
    my $x = BEGIN 8;
    is $x, 8, 'BEGIN statement prefix as expression';

    # test that built-ins are available within a BEGIN block:
    my $y = BEGIN ucfirst 'moin';
    is $y, 'Moin', 'can access built-in functions in BEGIN statement prefix';

    my $z = BEGIN 'moin'.ucfirst;
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

    is $init(), 'BCI', 'INIT {} runs only once';
    is $init_val, 'BCI', 'INIT {} as rval is its ret val';
    is $init(), 'BCI', 'INIT {} runs only once';

    # Test CHECK {} as rval:

    my $check_val;
    my $check = {
        $check_val = CHECK { $hist ~= 'C' };
    }

    is $check(), 'BC', 'CHECK {} runs only once';
    is $check_val, 'BC', 'CHECK {} as rval is its ret val';
    is $check(), 'BC', 'CHECK {} runs only once';

    # Test BEGIN {} as rval:

    my $begin_val;
    my $begin = {
        $begin_val = BEGIN { $hist ~= 'B' };
    }

    is $begin(), 'B', 'BEGIN {} runs only once';
    is $begin_val, 'B', 'BEGIN {} as rval is its ret val';
    is $begin(), 'B', 'BEGIN {} runs only once';

    # Test END {} as rval:

    ok !eval 'my $end_val = END { 3 }', "END {} can't be used as a rvalue";
}

# vim: ft=perl6
