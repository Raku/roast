use v6;

use Test;

plan 6;

# L<S32::Str/Str/ucfirst>

is tc("hello world"), "Hello world", "simple";
is tc(""),            "",            "empty string";
is tc("üüüü"),        "Üüüü",        "umlaut";
is tc("óóóó"),        "Óóóó",        "accented chars";
is tc('ßß'),          'Ssß',         'sharp s => Ss';
is 'abc'.tc,          'Abc',         'method form of title case';


# vim: ft=perl6
