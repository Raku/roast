use v6;
use Test;

plan 6;

is tclc('aBcD'),        'Abcd',         'tclc sub form on mixed-case latin string';
is 'aBcD'.tclc,         'Abcd',         'method form';
#?rakudo.jvm todo "RT 121377"
#?rakudo.moar todo "RT 121377"
is 'ßß'.tclc,           'Ssß',          'tclc and German sharp s';
is tclc('ǉenčariti'),   'ǈenčariti',    'lj => Lj (in one character)';
is 'Ångstrom'.tclc,     'Ångstrom',     'Å remains Å';
#?rakudo.parrot todo 'unknown tclc problem'
is "\x1044E TEST".tclc, "\x10426 test", 'tclc works on codepoints greater than 0xffff';

