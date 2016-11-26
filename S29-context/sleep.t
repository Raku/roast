use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

# L<S29/Context/"=item sleep">

plan 23;

my $seconds = 3;
my $nil is default(Nil);
my $b;

{
    diag "sleep() for $seconds seconds";
    my $start = now;
    $nil = sleep $seconds;
    my $diff = now - $start;

    #?niecza todo "NYI"
    ok $nil === Nil , 'sleep() always returns Nil';

    ok $diff >= $seconds - 1 , 'we actually slept at some seconds';
    ok $diff <= $seconds + 5 , '... but not too long';

    #?niecza 2 skip "NYI"
    $nil = 1;
    lives-ok { $nil = sleep(-1) }, "silently ignores negative times";
    ok $nil === Nil , 'sleep() always returns Nil';
} #5

#?niecza skip "NYI"
{
    diag "sleep-timer() for $seconds seconds";
    my $then = now;
    my $left = sleep-timer $seconds;
    my $now  = now;

    isa-ok $left, Duration, 'did we get a Duration back (1)';
    ok $now - $then + $seconds >= $left, 'does Duration returned make sense';

    $left = sleep-timer -1;
    isa-ok $left, Duration, 'did we get a Duration back (2)';
    is $left, 0, 'no time left to wait';

    $left = sleep-timer 0;
    isa-ok $left, Duration, 'did we get a Duration back (3)';
    is $left, 0, 'no time left to wait either';

    $left = sleep-timer "$seconds";
    isa-ok $left, Duration, 'did we get a Duration back (4)';
    is $left, 0, 'no time left to wait either';
} #6

#?niecza skip "NYI"
{
    diag "sleep-until() for $seconds seconds";
    my $then  = now;
    my $slept = sleep-until $then + $seconds;
    my $now   = now;

    isa-ok $slept, Bool, 'did we get a Bool back';
    ok $slept, 'did we actually wait';
    ok $now - $then + $seconds >= 0, 'does elapsed time make sense';

    $then  = now;
    $slept = sleep-until DateTime.now.later(:$seconds);
    $now   = now;

    isa-ok $slept, Bool, 'did we get a Bool back (DateTime)';
    ok $slept, 'did we actually wait (DateTime)';
    ok $now - $then + $seconds >= 0, 'does elapsed time make sense (DateTime)';

    nok sleep-until($then + $seconds), 'should not actually sleep again';
} #4

#?niecza todo "NYI"
{
    diag "checking infinite waiting times";
    isa-ok EVAL('$b={sleep(Inf)}'),       Block, 'sleep(Inf) compiles';
    isa-ok EVAL('$b={sleep(*)}'),         Block, 'sleep(*) compiles';
} #2


{ # RT#130170
    is_run ｢start { sleep 3; exit }; sleep 9999999999999999999; say "Fail"｣, {
        :out(''), :err(''), :0status
    }, 'huge values to sleep() work';
}

# vim: ft=perl6
