use v6;

use Test;

plan 11;

# L<S29/Str/capitalize>

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


# should be eval but rakudo doesn't do eval yet...
#?rakudo skip "can't parse"
{
    $_ = "puGS Is cOOl!";
    is .capitalize, "Pugs Is Cool!", 'capitalize() uses \$_ as default';
}

# Non-ASCII chars:
#?rakudo skip "unicode"
is capitalize("äöü abcä"), "Äöü Abcä", "capitalize() works on non-ASCII chars";
