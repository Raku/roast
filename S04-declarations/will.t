use v6;

use Test;

BEGIN plan 23;

# L<S04/Phasers>

my $begin;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    BEGIN ok !defined($begin), 'did we not run "will begin" yet';
    my $b will begin { $begin = 42 };
    BEGIN is $begin, 42, "will begin executed immediately at compile time";
    CHECK is $begin, 69, "third check executed";
    my $bb will check { $begin = 69 };  # second CHECK executed
    CHECK is $begin, 42, "first check executed";
}

my $init;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    BEGIN ok !defined($init), 'did we not run INIT yet';
    INIT $init = 5;
    INIT is $init, 5, 'did we run previous INIT';
    #?rakudo todo 'will init NYI'
    is $init, 121, 'did we run will init after INIT';
    my $bbb will init { $init = 121 };
}

my $same1;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    my $x will begin { $same1 = ( $_ === $x ) }
    BEGIN ok $same1, 'is $_ same as variable being declared';
}

my $c = 1;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    my $d will enter { $c = 42 };
    is $c, 42, 'entering the block sets the variable';
    my $e will leave { $c = 69 };
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
is $c, 69, 'leaving block sets variable';

my $same2;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    my $d will enter { $same2 = ( $_ === $d ) };
    ok $same2, 'is $_ same as $d';
    my $e will leave { $same2 = ( $_ === $e ) };
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet'
ok $same2, 'is $_ same as $e';

my $first =  42;
my $next  =  69;
my $last  = 121;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    for 1..3 -> $try {
        my $g will first { $first = $try };
        is $first, 1, 'only entering loop for first time sets variable';
        NEXT is $next, $try, 'did we call will next';
        my $h will next { $next = $try };
        my $i will last { $last = $try };
        is $last, 121, 'did not call last yet';
    }
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
is $last, 3, 'leaving loop sets variable';

my $same3;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    for 1 {
        my $j will first { $same3 = ( $_ === $j ) };
        ok $same3, 'is $_ same as $j';
        NEXT ok $same3, 'is $_ same as $k';
        my $k will next { $same3 = ( $_ === $k ) };
        my $l will last { $same3 = ( $_ === $l ) };
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet'
ok $same3, 'is $_ same as $l';

# vim: ft=perl6
