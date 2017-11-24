use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 16;

# L<S04/Phasers/KEEP "at every successful block exit">
# L<S04/Phasers/UNDO "at every unsuccessful block exit">

{
    my $str;
    my sub is_pos ($n) {
        return (($n > 0) ?? 1 !! Mu);
        KEEP { $str ~= "$n > 0 " }
        UNDO { $str ~= "$n <= 0 " }
    }

    ok is_pos(1), 'is_pos worked for 1';
    is $str, '1 > 0 ', 'KEEP ran as expected';

    ok !is_pos(0), 'is_pos worked for 0';
    is $str, '1 > 0 0 <= 0 ', 'UNDO worked as expected';

    ok !is_pos(-1), 'is_pos worked for 0';
    is $str, '1 > 0 0 <= 0 -1 <= 0 ', 'UNDO worked as expected';
}

# L<S04/Phasers/This includes the LEAVE variants, KEEP and UNDO.>
{
    my $str;
    my sub is_pos($n) {
        return (($n > 0) ?? 1 !! Mu);
        LEAVE { $str ~= ")" }
        KEEP { $str ~= "$n > 0" }
        UNDO { $str ~= "$n <= 0" }
        LEAVE { $str ~= "(" }
    }

    is_pos(1);
    is $str, '(1 > 0)', 'KEEP triggered as part of LEAVE blocks';

    is_pos(-5);
    is $str, '(1 > 0)(-5 <= 0)', 'UNDO triggered as part of LEAVE blocks';
}

# L<S04/Phasers/"can occur multiple times">

# multiple KEEP/UNDO
{
    my $str;
    {
        KEEP { $str ~= 'K1 ' }
        KEEP { $str ~= 'K2 ' }
        UNDO { $str ~= 'U1 ' }
        UNDO { $str ~= 'U2 ' }
        1;
    }
    is $str, 'K2 K1 ', '2 KEEP blocks triggered';
}

{
    my $str;
    {
        KEEP { $str ~= 'K1 ' }
        KEEP { $str ~= 'K2 ' }
        UNDO { $str ~= 'U1 ' }
        UNDO { $str ~= 'U2 ' }
    }
    is $str, 'U2 U1 ', '2 UNDO blocks triggered';
}

{
    my $kept   = 0;
    my $undone = 0;
    sub f() {
        KEEP $kept   = 1;
        UNDO $undone = 1;
        fail 'foo';
    }
    my $sink = f; #OK
    nok $kept,   'fail() does not trigger KEEP';
    ok  $undone, 'fail() triggers UNDO';
}

# RT #111866
{
    is_run( q[UNDO { say 'undone' }; die 'foobar'],
        {
            out    => "undone\n",
            err    => /foobar/,
        },
        'UNDO fires after die' );

    #?rakudo.jvm todo "RT #111866"
    is_run( q[do { UNDO { say 'undone' }; die 'foobar' }],
        {
            out    => "undone\n",
            err    => /foobar/,
        },
        'UNDO fires after die' );

    my $undone = 0;
    try { UNDO $undone = 1; die 'foobar' };
    #?rakudo.jvm todo "RT #111866"
    ok $undone, 'UNDO fires after die if block is a "try" block';

    my $undone_sub = 0;
    sub foo { UNDO $undone_sub = 1; fail };
    foo();
    ok $undone_sub, 'UNDO in sub fires after "fail"';
}


# vim: ft=perl6
