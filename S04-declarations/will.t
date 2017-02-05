use v6;

use Test;

BEGIN plan 20;

# L<S04/Phasers>

my $begin;
#?niecza skip "will variable trait NYI"
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
#?niecza skip "will variable trait NYI"
{
    #?rakudo todo 'will init NYI'
    is $init, "abc", 'all init blocks in order';
    BEGIN $init ~= "a";
    INIT  $init ~= "b";
    my $bbb will init { $init ~= "c" };
}

my $same1;
#?niecza skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet RT #125061'
{
    my $x  will begin { $same1 ~= "a" if $_ === $x }
    my $xx will check { $same1 ~= "b" if $_ === $xx }
    my $xxx will init { $same1 ~= "c" if $_ === $xxx }
    is $same1, "abc", 'all blocks set $_';
}

my $block;
#?niecza skip "will variable trait NYI"
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
#?niecza skip "will variable trait NYI"
#?rakudo todo "will post NYI RT #125062"
is $block, "abecd", 'all block blocks set variable';

my $same2;
#?niecza skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet RT #125063'
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
#?niecza skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet RT #125064'
is $same2, "abecd", 'all block blocks get $_';

my $for;
#?niecza skip "will variable trait NYI"
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
#?niecza skip "will variable trait NYI"
is $for, "aebebebc", 'all for blocks set variable';

my $same3;
#?niecza skip "will variable trait NYI"
#?rakudo skip 'declared variable not visible in block yet RT #125066'
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
#?niecza skip "will variable trait NYI"
#?rakudo todo 'declared variable not visible in block yet RT #125067'
is $same3, "aebebebc", 'all for blocks get $_';

#?niecza skip "will variable trait NYI"
{
    my $seen = 42;
    dies-ok {EVAL 'my $a will foo { $seen = 1 }'}, 'unknown will trait';
    is $seen, 42, 'block should not have executed';
    lives-ok {my $a will compose { $seen = 1 }}, "don't know how to test yet";
    is $seen, 42, 'block should not have executed';
}

# RT #125455
{
    my $did-we-leave = 0;
    class A {
        my $boo will leave { $did-we-leave = 1 };
        is $did-we-leave, 0, 'will leave trait on class-scoped my variable not run yet';
    }
    is $did-we-leave, 1, 'will leave trait on class-scoped my variable ran';
}

# RT #119109 
{
    my $what;
    my @a will begin { $what = $_.WHAT.perl; };
    is $what, 'Array', 'will begin block gets var as topic';
}

# vim: ft=perl6
