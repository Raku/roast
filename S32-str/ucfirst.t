use v6;

use Test;

plan 5;

# L<S32::Str/Str/ucfirst>

is ucfirst("hello world"), "Hello world", "simple";
is ucfirst(:string("station")), "Station", "ucfirst works with named argument";
is ucfirst(""),            "",            "empty string";
is ucfirst("üüüü"),        "Üüüü",        "umlaut";
is ucfirst("óóóó"),        "Óóóó",        "accented chars";


# vim: ft=perl6
