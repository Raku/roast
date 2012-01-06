use v6;

use Test;

plan 15;

# L<S32::Str/Str/capitalize>

is capitalize(""),             "",               "capitalize('') works";
is capitalize("puGS Is cOOl!"), "Pugs Is Cool!", "capitalize('...') works";
is "puGS Is cOOl!".capitalize,  "Pugs Is Cool!", "'...'.capitalize works";

my $a = "";
is capitalize($a),             "",               "capitalize empty string";
$a = "puGS Is cOOl!";
is capitalize($a),             "Pugs Is Cool!",  "capitalize string works";
is $a,                         "puGS Is cOOl!",  "original string not touched";
is $a.capitalize,              "Pugs Is Cool!",  "capitalize string works";
is $a,                         "puGS Is cOOl!",  "original string not touched";
is "ab cD Ef".capitalize,      "Ab Cd Ef",       "works on ordinary string";


{
    $_ = "puGS Is cOOl!";
    is .capitalize, "Pugs Is Cool!", 'capitalize() uses \$_ as default';
}

# Non-ASCII chars:
is capitalize("äöü abcä"), "Äöü Abcä", "capitalize() works on non-ASCII chars";#

#?rakudo 2 todo 'graphemes results wrong'
#?niecza 2 todo 'charspec'
is capitalize("a\c[COMBINING DIAERESIS]üö abcä"), "Äöü Abcä", 'capitalize on string with grapheme precomposed';
is capitalize("a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] bc"),
    "A\c[COMBINING DOT BELOW, COMBINING DOT ABOVE] Bc",
    "capitalize on string with grapheme without precomposed";
    
# rest of the tests are moved from uc.t
is ~(0.capitalize), ~0, '.capitalize on Int';

{
    role A {
        has $.thing = 3;
    }
    my $str = "('Nothing much' but A).capitalize eq 'Nothing much'.capitalize";
    ok eval($str), $str;
}

# vim: ft=perl6
