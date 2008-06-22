use v6;

use Test;

plan 8;

# L<S29/Str/lcfirst>

is lcfirst("HELLO WORLD"), "hELLO WORLD", "simple";
is lcfirst(""),            "",            "empty string";
#?rakudo 2 skip 'unicode'
is lcfirst("ÜÜÜÜ"),        "üÜÜÜ",        "umlaut";
is lcfirst("ÓÓÓÓŃ"),       "óÓÓÓŃ",       "accented chars";

is "HELLO WORLD".lcfirst,  "hELLO WORLD", "simple.lcfirst";

my $str = "Some String";
is $str.lcfirst,    "some String",          "simple.lcfirst on scalar variable";
is "Other String".lcfirst,  "other String", ".lcfirst on  literal string";

#?rakudo skip "can't parse"
{
    $_ = "HELLO WORLD";
    my $x = .lcfirst;
    is $x, "hELLO WORLD", 'lcfirst uses $_ as default'
}


