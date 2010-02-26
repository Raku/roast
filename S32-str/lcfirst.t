use v6;

use Test;

plan 9;

# L<S32::Str/Str/lcfirst>

is lcfirst("HELLO WORLD"), "hELLO WORLD", "simple";
is lcfirst(:string('FREW')), 'fREW', 'lcfirst works with named argument';
is lcfirst(""),            "",            "empty string";
is lcfirst("ÜÜÜÜ"),        "üÜÜÜ",        "umlaut";
is lcfirst("ÓÓÓÓŃ"),       "óÓÓÓŃ",       "accented chars";

is "HELLO WORLD".lcfirst,  "hELLO WORLD", "simple.lcfirst";

my $str = "Some String";
is $str.lcfirst,    "some String",          "simple.lcfirst on scalar variable";
is "Other String".lcfirst,  "other String", ".lcfirst on  literal string";

{
    $_ = "HELLO WORLD";
    my $x = .lcfirst;
    is $x, "hELLO WORLD", 'lcfirst uses $_ as default'
}



# vim: ft=perl6
