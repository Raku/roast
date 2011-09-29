use v6;
use Test;

# RT 71754
{
    my @called;
    multi rt71754( Numeric $x ) {    #OK not used
        push @called, 'Numeric';
    }
    multi rt71754( Int $x ) {    #OK not used
        push @called, 'Int';
        callsame;
    }
    lives_ok { rt71754( 71754 ) }, 'Can call multi that uses "callsame"';
    is @called, <Int Numeric>, 'multi with "callsame" worked';
}

# RT 69314

{
    sub rt69314($n) { 
        if $n { 
            callsame;
        }
    }; 
    
    lives_ok {rt69314(1)}, 'Calling callsame directly from a sub works';

}

done;

# vim: ft=perl6
