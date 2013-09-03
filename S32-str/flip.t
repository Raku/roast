use v6;
use Test;

# L<S32::Str/Str/=item flip>

plan 13;

# As a function :
is( flip('Pugs'), 'sguP', "as a function");

# As a method :
is( "".flip, "", "empty string" );
is( 'Hello World !'.flip, '! dlroW olleH', "literal" );

# On a variable ?
my Str $a = 'Hello World !';
is( $a.flip, '! dlroW olleH', "with a Str variable" );
is( $a, 'Hello World !', "flip should not be in-place" );
is( $a .= flip, '! dlroW olleH', "after a .=flip" );

# Multiple iterations (don't work in 6.2.12) :
is( 'Hello World !'.flip.flip, 'Hello World !',
        "two flip in a row." );

# flip with unicode :
is( 'ä€»«'.flip,   '«»€ä', "some unicode characters" );

#?niecza 2 todo 'graphemes not implemented'
#?rakudo 2 todo 'graphemes not implemented'
#?pugs   2 skip 'graphemes not implemented'
is( "a\c[COMBINING DIAERESIS]b".flip, 'bä', "grapheme precomposed" );
is( "a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]b".flip,
    "ba\c[COMBINING DOT ABOVE, COMBINING DOT BELOW]",
    "grapheme without precomposed");

is 234.flip, '432', '.flip on non-string';
is flip(123), '321', 'flip() on non-strings';
{
    my $x = 'abc';
    $x.=flip;
    is $x, 'cba', 'in-place flip';
}


# vim: ft=perl6
