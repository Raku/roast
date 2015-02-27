use v6;
use Test;
plan 13;

sub my_first  ($x, $,  $ ) { $x };
sub my_second ($,  $x, $ ) { $x };
sub my_third  ($,  $,  $x) { $x };

is my_first( 4, 5, 6), 4, '($x, $, $) works as a signature';
is my_second(4, 5, 6), 5, '($, $x, $) works as a signature';
is my_third( 4, 5, 6), 6, '($, $, $x) works as a signature';

# RT #60408
{
    sub rt60408 {
        return { @_.join };
    }

    is rt60408().(1, 2, 3), '123', '@_ belongs to the inner-most block';
}

{

    sub f(@a, $i) {
        $i ~ "[{map { f($_, $i + 1) }, @a}]"
    };
    is f([[], [[]], []], 0), "0[1[] 1[2[]] 1[]]",
       'recusion and parameter binding work out fine';
}

# using "special" variables as positional parameters
{
    # RT #77054
    sub dollar-underscore($x, $y, $_, $z) { "$x $y $_ $z"; }
    is dollar-underscore(1,2,3,4), '1 2 3 4', '$_ works as parameter name';

    sub dollar-slash($x, $/, $y) { "$x $<b> $y" }
    is dollar-slash(1, { b => 2 }, 3), '1 2 3', '$/ works as parameter name';
}

eval_dies_ok 'sub foo( $a, $a ) { }', 'two sub params with the same scalar name';
eval_dies_ok 'sub foo( @a, @a ) { }', 'two sub params with the same array name';
eval_dies_ok 'sub foo( %a, %a ) { }', 'two sub params with the same hash name';
eval_dies_ok 'sub foo( &a, &a ) { }', 'two sub params with the same callable name';
eval_dies_ok 'sub foo( \a, \a ) { }', 'two sub params with the same sigilles name';
eval_dies_ok 'sub foo( ::T, ::T) { }', 'two sub params with the same type capture name';

# vim: ft=perl6
