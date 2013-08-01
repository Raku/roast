use v6;

use Test;

BEGIN plan 10;

# L<S04/Phasers>

#?rakudo 1 skip "these tests will all fail except on rakudo"
BEGIN skip_rest( "can only do this on rakudo" );

my $init;
INIT { $init = 5 };
INIT { is $init, 5, 'did we run previous INIT' };

my $a;
my $b will begin { $a=42 };
BEGIN is $a, 42, "will begin executed immediately at compile time";
my $bb will check { $a = 69 };
is $a, 69, "will check executed at CHECK time";

#?rakudo todo 'will init NYI'
{
    is $init, 121, 'did we run init after INIT';
    my $bbb will init { $a = 121 };
    is $a, 121, "will init executed at INIT time";
}

my $same1;
#?rakudo skip 'declared variable not visible in block yet'
{
    my $x will begin { $same1 = ( $_ === $x ) }
    BEGIN ok $same1, 'is $_ same as variable being declared';
}

my $c=1;
{
    my $d will enter { $c=42 };
    is $c, 42, 'entering the block sets the variable';
    my $e will leave { $c =69 };
}
is $c, 69, 'leaving block sets variable';

my $same2;
#?rakudo skip 'declared variable not visible in block yet'
{
    my $d will enter { $same2 = ( $_ === $d ) };
    ok $same2, 'is $_ same as $d';
    my $e will leave { $same2 = ( $_ === $e ) };
    ok $same2, 'is $_ same as $e';
}

# vim: ft=perl6
