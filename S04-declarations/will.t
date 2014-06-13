use v6;

use Test;

BEGIN plan 17;

# L<S04/Phasers>

my $begin;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    BEGIN $begin ~= "a";
    my $b will begin { $begin ~= "b" };
    BEGIN $begin ~= "c";
    CHECK $begin ~= "f";
    my $bb will check { $begin ~= "e" };
    CHECK $begin ~= "d";
    is $begin, "abcdef", 'all begin/check blocks in order';
}

my $init;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo 'will init NYI'
{
    is $init, "abc", 'all init blocks in order';
    BEGIN $init ~= "a";
    INIT  $init ~= "b";
    my $bbb will init { $init ~= "c" };
}

my $same1;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    my $x  will begin { $same1 ~= "a" if $_ === $x }
    my $xx will check { $same1 ~= "b" if $_ === $xx }
    my $xxx will init { $same1 ~= "c" if $_ === $xxx }
    is $same1, "abc", 'all blocks set $_';
}

my $block;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    my $d  will pre    { $block ~= "a" };
    my $dd will enter  { $block ~= "b" };
    is $block, "ab", 'entered block ok';
    my $e will leave   { $block ~= "c" };
    my $ee will post   { $block ~= "d" };
    my $eee will keep  { $block ~= "e" };
    my $eeee will undo { $block ~= "f" }; # should not fire
    1; # successful exit
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo "will post NYI"
is $block, "abecd", 'all block blocks set variable';

my $same2;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    my $d  will pre    { $same2 ~= "a" if $_ === $d; 1 };
    my $dd will enter  { $same2 ~= "b" if $_ === $dd };
    is $same2, "ab", 'entered block ok';
    my $e  will leave  { $same2 ~= "c" if $_ === $e };
    my $ee will post   { $same2 ~= "d" if $_ === $ee; 1 };
    my $eee will keep  { $same2 ~= "e" if $_ === $eee };
    my $eeee will undo { $same2 ~= "f" if $_ === $eeee }; # should not fire
    1; # successful exit
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet'
is $same2, "abecd", 'all block blocks get $_';

my $for;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    my @is = <a aeb aebeb>;
    for ^3 {
        my $g will first  { $for ~= "a" };
        my $h will next   { $for ~= "b" };
        my $i will last   { $for ~= "c" };
        is( $for, @is[$_], "for iteration #{$_+1}" );
        my $ii will keep  { $for ~= "d" }; # should not fire
        my $iii will undo { $for ~= "e" };
        Nil; # failure exit
    }
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo.parrot todo 'will variable not all blocks yet'
is $for, "aebebebc", 'all for blocks set variable';

my $same3;
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet'
{
    my @is = <a aeb aebeb>;
    for ^3 {
        my $j will first  { $same3 ~= "a" if $_ === $j; 1 };
        my $k will next   { $same3 ~= "b" if $_ === $k; 1 };
        my $l will last   { $same3 ~= "c" if $_ === $l; 1 };
        is( $same3, @is[$_], "same iteration #{$_+1}" );
        my $ll will keep  { $same2 ~= "d" if $_ === $ll }; # should not fire
        my $lll will undo { $same2 ~= "e" if $_ === $lll };
        Nil; # failure exit
    }
}
#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet'
is $same3, "aebebebc", 'all for blocks get $_';

#?niezca skip "will variable trait NYI"
#?pugs   skip "will variable trait NYI"
{
    my $seen = 42;
    dies_ok {EVAL 'my $a will foo { $seen = 1 }'}, 'unknown will trait';
    is $seen, 42, 'block should not have executed';
    lives_ok {my $a will compose { $seen = 1 }}, "don't know how to test yet";
    is $seen, 42, 'block should not have executed';
}

# vim: ft=perl6
