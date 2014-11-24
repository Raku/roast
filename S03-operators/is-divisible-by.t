use v6;

use Test;

plan 15;

# L<S03/"is divisible by">
{
    ok 6 %% 3, '6 %% 3';
    isa_ok 6 %% 3, Bool, '6 %% 3 isa Bool';
    nok 6 %% 4, '6 %% 4';
    isa_ok 6 %% 4, Bool, '6 %% 4 isa Bool';

    is (1..10).grep({ $_ %% 3 }), <3 6 9>, '%% works with explicit closure';
    is (1..10).grep( * %% 3 ), <3 6 9>, '%% works with whatever *';
} #6

{
    nok 6 !%% 3, '6 !%% 3';
    isa_ok 6 !%% 3, Bool, '6 !%% 3 isa Bool';
    ok 6 !%% 4, '6 !%% 4';
    isa_ok 6 %% 4, Bool, '6 !%% 4 isa Bool';

    is (1..10).grep({ $_ !%% 3 }), <1 2 4 5 7 8 10>, '%% works with explicit closure';
    is (1..10).grep( * !%% 3 ), <1 2 4 5 7 8 10>, '%% works with whatever *';
} #6

# RT #76170
{
    # TODO: implement typed exception and adapt test
    throws_like { EVAL q[ 9 !% 0 ] }, Exception,
        message => 'Cannot negate % because it is not iffy enough',
        'infix<!%> is not iffy enough; RT #76170';
} #1

{
    throws_like { 9 %% 0 }, X::Numeric::DivideByZero,
        message => 'Divide by zero using infix:<%%>',
        'cannot divide by zero using infix:<%%>';
    #?rakudo todo "not sure why this doesn't fire"
    throws_like { EVAL "9 !%% 0" }, X::Numeric::DivideByZero,
        message => 'Divide by zero using infix:<%%>',
        'cannot divide by zero using infix:<%%>';
} #2
