use v6;
use Test;
plan 3;

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

# RT #69314
{
    # NOTE: do NOT eval this code using Test.pm6's routines as then we would
    # depend on whether or not those routines are implemented as multies
    my $desc = 'callsame without dispatcher in scope dies';
    EVAL ｢sub rt69314($n) { if $n { callsame; } }(1)｣;
    flunk $desc;
    CATCH { default { isa-ok $_, X::NoDispatcher, $desc } }
}

# vim: ft=perl6
