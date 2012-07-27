use v6;
use Test;

plan 5;

is tclc('aBcD'),    'Abcd',     'tclc sub form on mixed-case latin string';
is 'aBcD'.tclc,     'Abcd',     'method form';
is 'ßß'.tclc,       'Ssß',      'tclc and German sharp s';
is tclc('ǉ'),       'ǈ',        'lj => Lj (in one character)';
#?rakudo todo 'unknown tclc problem'
is "\x1044E TEST".tclc, "\x10426 test", 'tclc works on codepoints greater than 0xffff';

