use v6;

use Test;

plan 63;

# L<S32::Str/Str/"identical to" "C library sprintf">

is sprintf("Hi"),                 "Hi",     "sprintf() works with zero args";
is sprintf("%%"),                 "%",      "sprintf() escapes % correctly";
is sprintf("%03d",      3),       "003",    "sprintf() works with one arg";
is sprintf("%03d %02d", 3, 1),    "003 01", "sprintf() works with two args";
is sprintf("%d %d %d",  3,1,4),   "3 1 4",  "sprintf() works with three args";
is sprintf("%d%d%d%d",  3,1,4,1), "3141",   "sprintf() works with four args";
is sprintf('%2$d %1$d', 42, 24),  '24 42',  'numbered parameters';

ok(eval('sprintf("%b",1)'),                 'eval of sprintf() with %b');

is sprintf("%04b", 3),            '0011',   '0-padded sprintf() with %b';
is sprintf("%4b", 3),             '  11',   '" "-padded sprintf() with %b';
is sprintf('%-4b', 3),            '11  ',   'left padding';
is sprintf("%b", 30),             '11110',  'longer string, no padding';
is sprintf("%2b", 30),            '11110',  'padding specified, not needed';
is sprintf("%03b", 7),            '111',    '0 padding, longer string';
is sprintf("%b %b", 3, 3),        '11 11',  'two args %b';

is sprintf('%c', 97),             'a',      '%c test';
is sprintf('%s', 'string'),       'string', '%s test';
is sprintf('%2s', 's'),           ' s',     '%s length';
is sprintf('%1$s', '%1$s'),       '%1$s',   "%s shouldn't be recursive";
is sprintf('%3.2s', 'string'),    ' st',    '%s precission';
is sprintf('%s', [1, 3]),         '1 3',    'array to string';
is sprintf('%d', [1, 3]),         '2',      'array to digit';

is sprintf('%d', 12),             '12',     'simple %d';
is sprintf('%d', -22),            '-22',    'negative %d';
is sprintf('%04d', 32),           '0032',   '0-padded %d';
is sprintf('%04d', -42),          '-042',   '0-padded negative %d';
is sprintf('% d', 1),             ' 1',     'space-padded digit';
is sprintf('% d', -1),            '-1',     'space-padding negative digits';
is sprintf('%i', -22),            '-22',    'negative %i';
is sprintf('%04i', -42),          '-042',   '0-padded negative %i';
is sprintf('%d', 123.789),        '123',    "%d format shouldn't round up";

is sprintf('%.0f', 0),            '0',      '%f modifier';
is sprintf('%*.*f', 4, 1, 3),     ' 3.0',   '* operator';

is sprintf('%e', 0.1234567E-101), '1.234567e-102', 'very small numbers';

is sprintf('%u', 12),             '12',     'simple %u';
is sprintf('%u', 22.01),          '22',     'decimal %u';
is sprintf('%04u', 32),           '0032',   '0-padded %u';
is sprintf('%04u', 42.6),         '0042',   '0-padded decimal %u';

is sprintf('%o', 12),             '14',     'simple %o';
is sprintf('%o', 22.01),          '26',     'decimal %o';
is sprintf('%03o', 32),           '040',    '0-padded %o';
is sprintf('%03o', 42.6),         '052',    '0-padded decimal %o';

is sprintf('%x', 12),             'c',      'simple %x';
is sprintf('%x', 22.01),          '16',     'decimal %x';
is sprintf('%03x', 32),           '020',    '0-padded %x';
is sprintf('%03x', 42.6),         '02a',    '0-padded decimal %x';
# tests for %X
is sprintf('%X', 12),             'C',      'simple %X';
is sprintf('%03X', 42.6),         '02A',    '0-padded decimal %X';

is sprintf('%hd', 2 ** 16 + 1),   '1',      'type argument';

is sprintf('%vd', "A\x100"),      '65.256', 'vector flag';
is sprintf('%vc', 'Str'),         'S.t.r',  'vector characters';
is sprintf('%#v.0o', "\0\x1"),    '0.01',   'octal prefixes';
is sprintf('%*vc!', ' ', 'STR'),  'S T R!', 'custom vector separators';

# L<S32::Str/"Str"/"The special directive, %n does not work in Perl 6">
dies_ok(sub {my $x = sprintf('%n', 1234)}, '%n dies (Perl 5 compatibility)');   #OK not used
#?rakudo todo "%p doesn't yet throw exception - but should it, or just Failure?"
dies_ok(sub {my $x = sprintf('%p', 1234)}, '%p dies (Perl 5 compatibility)');   #OK not used
# Abstract parameter number
dies_ok(sub {my $x = sprintf('%*2147483647$v2d', 0)}, 'Wrong parameter number');#OK not used

is sprintf('%s', NaN),              NaN,    'sprintf %s handles NaN';
is sprintf('%s', -NaN),             NaN,    'sprintf %s handles NaN';
is sprintf('%s', Inf),              Inf,    'sprintf %s handles Inf';
is sprintf('%s', -Inf),            -Inf,    'sprintf %s handles Inf';

#?rakudo skip "doesn't work in master (as of 2010-07)"
{
is sprintf('%d %1$x %1$o', 12),    '12 c 14',  'positional argument specifier $';
}

dies_ok {sprintf}, 'missing sprintf value';

# RT #74610
dies_ok {sprintf "%s"}, 'missing sprintf string argument';

# vim: ft=perl6
