use v6;
use Test;
plan *;

# RT 71754
{
    my @called;
    multi rt71754( Num $x ) {
        push @called, 'Num';
    }
    multi rt71754( Int $x ) {
        push @called, 'Int';
        callsame;
    }
    lives_ok { rt71754( 71754 ) }, 'Can call multi that uses "callsame"';
    is @called, <Int Num>, 'multi with "callsame" worked';
}

done_testing;

# vim: ft=perl6
