use v6;
use Test;

# L<S29/Context/"=item sleep">

plan 17;

my $seconds = 3;
my $nil is default(Nil);
my $b;

{
    diag "sleep() for $seconds seconds";
    my $start = now;
    $nil = sleep $seconds;
    my $diff = now - $start;

    #?pugs   todo "NYI"
    #?niecza todo "NYI"
    ok $nil === Nil , 'sleep() always returns Nil';

    ok $diff >= $seconds - 1 , 'we actually slept at some seconds';
    ok $diff <= $seconds + 5 , '... but not too long';

    #?pugs   2 skip "NYI"
    #?niecza 2 skip "NYI"
    $nil = 1;
    lives_ok { $nil = sleep(-1) }, "silently ignores negative times";
    ok $nil === Nil , 'sleep() always returns Nil';
} #5

#?pugs   skip "NYI"
#?niecza skip "NYI"
{
    diag "sleep-timer() for $seconds seconds";
    my $then = now;
    my $left = sleep-timer $seconds;
    my $now  = now;

    isa_ok $left, Duration, 'did we get a Duration back (1)';
    ok $now - $then + $seconds >= $left, 'does Duration returned make sense';

    $left = sleep-timer -1;
    isa_ok $left, Duration, 'did we get a Duration back (2)';
    is $left, 0, 'no time left to wait';

    $left = sleep-timer 0;
    isa_ok $left, Duration, 'did we get a Duration back (3)';
    is $left, 0, 'no time left to wait either';
} #6

#?pugs   skip "NYI"
#?niecza skip "NYI"
{
    diag "sleep-till() for $seconds seconds";
    my $then  = now;
    my $slept = sleep-till $then + $seconds;
    my $now   = now;

    isa_ok $slept, Bool, 'did we get a Bool back';
    ok $slept, 'did we actually wait';
    ok $now - $then + $seconds >= 0, 'does elapsed time make sense';

    nok sleep-till($then + $seconds), 'should not actually sleep again';
} #4

#?pugs   todo "NYI"
#?niecza todo "NYI"
{
    diag "checking infinite waiting times";
    isa_ok EVAL('$b={sleep(Inf)}'),       Block, 'sleep(Inf) compiles';
    isa_ok EVAL('$b={sleep(*)}'),         Block, 'sleep(*) compiles';
} #2

# vim: ft=perl6
