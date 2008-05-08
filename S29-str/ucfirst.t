use v6;

use Test;

plan 4;

# L<S29/Str/ucfirst>

is ucfirst("hello world"), "Hello world", "simple";
is ucfirst(""),            "",            "empty string";
#?rakudo 2 skip "unicode"
is ucfirst("üüüü"),        "Üüüü",        "umlaut";
is ucfirst("óóóó"),        "Óóóó",        "accented chars";

