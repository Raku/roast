use v6;

use Test;

plan 5;

# L<S29/Str/ucfirst>

is ucfirst("hello world"), "Hello world", "simple";
is ucfirst(:string("station")), "Station", "ucfirst works with named argument";
is ucfirst(""),            "",            "empty string";
#?rakudo 2 skip 'unicode'
is ucfirst("üüüü"),        "Üüüü",        "umlaut";
is ucfirst("óóóó"),        "Óóóó",        "accented chars";

