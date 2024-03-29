# Test phasers in EVAL strings

use Test;

plan 35;

# L<S04/Phasers/Code "generated at run time" "still fire off"
#   "can't" "travel back in time" >
{
    my $h;
    my $handle;

    EVAL '$handle = { $h ~= "1"; once { $h ~= "F" }; $h ~= "2" }';
    ok $! !~~ Exception, 'EVAL once {...} works';

    nok $h.defined, 'once {...} has not run yet';
    lives-ok { $handle() }, 'can run code with once block';
    is $h, '1F2', 'once {...} fired';
    lives-ok { $handle() }, 'can run code with once block again';
    is $h, '1F212', 'once {...} fired only once';

    # test that it runs again for a clone of $handle
    $h = '';
    my $clone = $handle.clone;
    is $h, '', 'cloning code does not run anything';
    lives-ok { $clone() }, 'can run clone of code with once block';
    is $h, '1F2', 'once {...} fired again for the clone';
    lives-ok { $clone() }, 'can run clone of once block code again';
    is $h, '1F212', 'cloned once {...} fired only once';
}

{
    my $h;
    my $handle;

    EVAL '$handle = { $h ~= "r"; INIT { $h ~= "I" }; $h ~= "R" }';
    ok $! !~~ Exception, 'EVAL INIT {...} works';
    #?rakudo todo 'not sure'
    nok $h.defined, 'INIT did not run at compile time';
    lives-ok { $handle() }, 'can run code with INIT block';
    is $h, 'IrR', 'INIT {...} fires at run-time';
    lives-ok { $handle() }, 'can run code with INIT block again';
    is $h, 'IrRrR', 'INIT runs only once';

    # test that it runs again for a clone of $handle
    $h = '';
    my $clone = $handle.clone;
    is $h, '', 'cloning code does not run anything';
    lives-ok { $clone() }, 'can run clone of code with INIT block';
    is $h, 'rR', 'INIT {...} did not fire again for the clone';
}

{
    my $h;
    my $handle;

    EVAL '$handle = { $h ~= "1"; CHECK { $h ~= "C" };'
        ~ '$h ~= "2"; BEGIN { $h ~= "B" }; $h ~= "3" }';
    ok $! !~~ Exception, 'EVAL CHECK {...} (and BEGIN {...}) works';

    is $h, 'BC', 'CHECK and BEGIN blocks ran before run time';
    lives-ok { $handle() }, 'can run code with CHECK and BEGIN blocks';
    is $h, 'BC123', 'CHECK {...} runs at compile time after BEGIN';
    lives-ok { $handle() }, 'can run code with CHECK and BEGIN again';
    is $h, 'BC123123', 'CHECK runs once';
}

{
    my $h;
    my $handle;

    EVAL '$handle = { $h ~= "1"; BEGIN { $h ~= "B" }; $h ~= "2" }';
    ok $! !~~ Exception, 'EVAL BEGIN {...} works';

    is $h, 'B', 'BEGIN ran before run time';
    lives-ok { $handle() }, 'can run code with BEGIN block';
    is $h, 'B12', 'BEGIN does not run again at run time';
}

{
    my $h = '';
    my $handle;

    END {
        is $h, '12E', 'the END {...} in EVAL has run already';
    }

    EVAL '$handle = { $h ~= "1"; END { $h ~= "E" }; $h ~= "2" }';
    ok $! !~~ Exception, 'EVAL END {...} works';

    is $h, '' , 'END {} has not run yet';
    lives-ok { $handle() }, 'can call code with END block';
    is $h, '12', 'END {} does not run at run time either';
}

# vim: expandtab shiftwidth=4
