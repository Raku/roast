use v6;

use Test;

plan 8;

# L<S32::Str/Str/ucfirst>

is tc("hello world"), "Hello world", "simple";
is tc(""),            "",            "empty string";
is tc("üüüü"),        "Üüüü",        "umlaut";
is tc("óóóó"),        "Óóóó",        "accented chars";
is tc('ßß'),          'Ssß',         'sharp s => Ss';
is tc('ǉ'),           'ǈ',           'lj => Lj (in one character)';
is 'abc'.tc,          'Abc',         'method form of title case';
#?rakudo todo 'leaving the rest alone'
is 'aBcD'.tc,         'ABcD',        'tc only modifies first character';


# vim: ft=perl6
