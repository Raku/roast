use v6;
use Test;
plan *;

# RT 71754
{
    my @called;
    multi rt71754( Num $x ) {    #OK not used
        push @called, 'Num';
    }
    multi rt71754( Int $x ) {    #OK not used
        push @called, 'Int';
        callsame;
    }
    lives_ok { rt71754( 71754 ) }, 'Can call multi that uses "callsame"';
    is @called, <Int Num>, 'multi with "callsame" worked';
}

# RT 69314

{
    sub rt69314($n) { 
        if $n { 
            callsame($n-1);
        }
    }; 
    
    #?rakudo todo 'Calling callsame directly from a sub'
    lives_ok {rt69314(1)}, 'Calling callsame directly from a sub works';

}

done_testing;

# vim: ft=perl6
