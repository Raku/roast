use v6;

# Test closure traits in eval strings

use Test;

plan 27;

# L<S04/Closure traits/Code "generated at run time" "still fire off"
#   "can't" "travel back in time" >

my ($handle);

our $h;

{
    my $h;

    eval '$handle = { $h ~= "1"; START { $h ~= "F" }; $h ~= "2" }';
    ok $! !~~ Exception, 'eval START {...} works';

    is $h, undef, 'START {...} has not run yet';
    lives_ok { $handle() }, 'can run code with START block';
    is $h, '1F2', 'START {...} fired';
    lives_ok { $handle() }, 'can run code with START block again';
    is $h, '1F212', 'START {...} fired only once';

    # TODO: test that it runs again for a clone of $handle
}

{
    my $h;

    eval '$handle = { $h =~ "r"; INIT { $h ~= "I" }; $h ~= "R" }';
    ok $! !~~ Exception, 'eval INIT {...} works';
    is $h, undef, 'INIT did not run at compile time';
    #?rakudo 4 todo 'Could not find non-existent sub INIT'
    lives_ok { $handle() }, 'can run code with INIT block';
    is $h, 'IrR', 'INIT {...} fires at run-time';
    lives_ok { $handle() }, 'can run code with INIT block again';
    is $h, 'IrRrR', 'INIT runs only once';

    # TODO: test that it does not run again for a clone of $handle (?)
}

{
    our $h = undef;

    eval '$handle = { our $h ~= "1"; CHECK { our $h ~= "C" }; our $h ~= "2"; BEGIN { our $h ~= "B" }; our $h ~= "3" }';
    ok $! !~~ Exception, 'eval CHECK {...} (and BEGIN {...}) works';

    #?rakudo 5 todo 'Could not find non-existent sub CHECK'
    is $h, 'BC', 'CHECK and BEGIN blocks ran before run time';
    lives_ok { $handle() }, 'can run code with CHECK and BEGIN blocks';
    is $h, 'BC123', 'CHECK {...} runs at compile time after BEGIN';
    lives_ok { $handle() }, 'can run code with CHECK and BEGIN again';
    is $h, 'BC123123', 'CHECK runs once';
}

{
    our $h = undef;

    eval '$handle = { our $h ~= "1"; BEGIN { our $h ~= "B" }; our $h ~= "2" }';
    ok $! !~~ Exception, 'eval BEGIN {...} works';

    is $h, 'B', 'BEGIN ran before run time';
    lives_ok { $handle() }, 'can run code with BEGIN block';
    is $h, 'B12', 'BEGIN does not run again at run time';
}

my ($code, $hist);

#?rakudo skip 'test harness does not see test result in END'
{
    END {
        is our $end, '12E', 'the END {...} in eval has run already';
    }
}

{
    our $end = undef;

    eval '$handle = { our $end ~= "1"; END { our $end ~= "E" }; our $end ~= "2" }';
    ok $! !~~ Exception, 'eval END {...} works';

    is $end, undef, 'END {} has not run yet';
    lives_ok { $handle() }, 'can call code with END block';
    is $end, '12', 'END {} does not run at run time either';
}
