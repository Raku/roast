use v6.c;
use Test;
plan 2;

# RT #71754
{
    my @called;
    multi rt71754( Numeric $x ) {    #OK not used
        push @called, 'Numeric';
    }
    multi rt71754( Int $x ) {    #OK not used
        push @called, 'Int';
        callsame;
    }
    lives-ok { rt71754( 71754 ) }, 'Can call multi that uses "callsame"';
    is @called, <Int Numeric>, 'multi with "callsame" worked';
}

# vim: ft=perl6
