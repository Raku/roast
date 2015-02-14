use v6;

use Test;

plan 17;

# L<S32::Str/Str/wordcase>

is wordcase(""),             "",               "wordcase('') works";
is wordcase("puGS Is cOOl!"), "Pugs Is Cool!", "wordcase('...') works";
is "puGS Is cOOl!".wordcase,  "Pugs Is Cool!", "'...'.wordcase works";
#?niecza 2 todo "wordcase somewhat stupid right now"
is "don't sit under the apple tree".wordcase, "Don't Sit Under The Apple Tree", "wordcase works properly with apostrophes";
is "tir-na nog'th".wordcase, "Tir-na Nog'th", "wordcase works properly with apostrophes and dashes";

my $a = "";
is wordcase($a),             "",               "wordcase empty string";
$a = "puGS Is cOOl!";
is wordcase($a),             "Pugs Is Cool!",  "wordcase string works";
is $a,                         "puGS Is cOOl!",  "original string not touched";
is $a.wordcase,              "Pugs Is Cool!",  "wordcase string works";
is $a,                         "puGS Is cOOl!",  "original string not touched";
is "ab cD Ef".wordcase,      "Ab Cd Ef",       "works on ordinary string";


{
    $_ = "puGS Is cOOl!";
    is .wordcase, "Pugs Is Cool!", 'wordcase() uses \$_ as default';
}

# Non-ASCII chars:
is wordcase("äöü abcä"), "Äöü Abcä", "wordcase() works on non-ASCII chars";#

#?rakudo 2 todo 'graphemes results wrong'
#?niecza 2 todo 'charspec'
is wordcase("a\c[COMBINING DIAERESIS]üö abcä"), "Äöü Abcä", 'wordcase on string with grapheme precomposed';
is wordcase("a\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] bc"),
    "A\c[COMBINING DOT BELOW, COMBINING DOT ABOVE] Bc",
    "wordcase on string with grapheme without precomposed";

# rest of the tests are moved from uc.t
is ~(0.wordcase), ~0, '.wordcase on Int';

{
    role A {
        has $.thing = 3;
    }
    my $str = "('Nothing much' but A).wordcase eq 'Nothing much'.wordcase";
    ok EVAL($str), $str;
}

# TODO: add tests for wordcase arguments

# vim: ft=perl6
