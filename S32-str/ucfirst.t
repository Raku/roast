use v6;

use Test;

plan 4;

# L<S32::Str/Str/ucfirst>

is ucfirst("hello world"), "Hello world", "simple";
is ucfirst(""),            "",            "empty string";
is ucfirst("üüüü"),        "Üüüü",        "umlaut";
is ucfirst("óóóó"),        "Óóóó",        "accented chars";


# vim: ft=perl6
