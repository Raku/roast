use v6;
use Test;
plan 6;

sub my_first  ($x, $,  $ ) { $x };
sub my_second ($,  $x, $ ) { $x };
sub my_third  ($,  $,  $x) { $x };

is my_first( 4, 5, 6), 4, '($x, $, $) works as a signature';
is my_second(4, 5, 6), 5, '($, $x, $) works as a signature';
is my_third( 4, 5, 6), 6, '($, $, $x) works as a signature';

# RT #60408
#?rakudo skip 'RT 60408'
{
    sub rt60408_for {
        my @out;
        @out.push( @_[0].perl );
        for 1 { @out.push( @_[0].perl ); }
        return @out;
    }

    is rt60408_for(42), (42, 42), 'use of @_[0] in a "for" block (RT 60408)';

    sub rt60408_if {
        my @out;
        @out.push( @_[0].perl );
        if 1 { @out.push( @_[0].perl ); }
        return @out;
    }

    is rt60408_if(42), (42, 42), 'use of @_[0] in an "if" block (RT 60408)';
}

{

    sub f(@a, $i) {
        $i ~ "[{map { f($_, $i + 1) }, @a}]"
    };
    is f([[], [[]], []], 0), "0[1[] 1[2[]] 1[]]",
       'recusion and parameter binding work out fine';
}

# vim: ft=perl6
