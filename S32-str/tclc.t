use v6;
use Test;

plan 6;

is tclc('aBcD'),        'Abcd',         'tclc sub form on mixed-case latin string';
is 'aBcD'.tclc,         'Abcd',         'method form';
# https://github.com/Raku/old-issue-tracker/issues/3352
#?rakudo.jvm todo ""
is 'ßß'.tclc,           'Ssß',          'tclc and German sharp s';
is tclc('ǉenčariti'),   'ǈenčariti',    'lj => Lj (in one character)';
is 'Ångstrom'.tclc,     'Ångstrom',     'Å remains Å';
is "\x1044E TEST".tclc, "\x10426 test", 'tclc works on codepoints greater than 0xffff';


# vim: expandtab shiftwidth=4
