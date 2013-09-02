use v6;

use Test;

plan 135;

# L<S32::Str/Str/"identical to" "C library sprintf">

is sprintf("Hi"),                 "Hi",     "sprintf() works with zero args";
is sprintf("%%"),                 "%",      "sprintf() escapes % correctly";
is sprintf("%03d",      3),       "003",    "sprintf() works with one arg";
is sprintf("%03d %02d", 3, 1),    "003 01", "sprintf() works with two args";
is sprintf("%d %d %d",  3,1,4),   "3 1 4",  "sprintf() works with three args";
is sprintf("%d%d%d%d",  3,1,4,1), "3141",   "sprintf() works with four args";

ok(eval('sprintf("%b",1)'),                  'eval of sprintf() with %b');

is sprintf("%04b",3),             '0011',   '0-padded sprintf() with %b';
is sprintf("%4b",3),              '  11',   '" "-padded sprintf() with %b';
is sprintf("%b",30),              '11110',  'longer string, no padding';
is sprintf("%2b",30),             '11110',  'padding specified, not needed';
is sprintf("%03b",7),             '111',    '0 padding, longer string';
is sprintf("%b %b",3,3),          '11 11',  'two args %b';

is sprintf('%c', 97),             'a',      '%c test';

is sprintf('%s', 'string'),        'string', '%s test';
is sprintf('%10s', 'string'),  '    string', '%s right-justified';
is sprintf('%-10s', 'string'), 'string    ', '%s left-justified';

is sprintf('%d', 12),             '12',     'simple %d';
is sprintf('%d', -22),            '-22',    'negative %d';
is sprintf('%04d', 32),           '0032',   '0-padded %d';
is sprintf('%04d', -42),          '-042',   '0-padded negative %d';
is sprintf('%i', -22),            '-22',    'negative %i';
is sprintf('%04i', -42),          '-042',   '0-padded negative %i';
is sprintf('%4d', 32),            '  32',   'space-padded %d';
is sprintf('%4d', -42),           ' -42',   'space-padded negative %d';
is sprintf('%4i', -42),           ' -42',   'space-padded negative %i';
is sprintf('%-4i', -42),          '-42 ',   'left-justified negative %i';

is sprintf('%u', 12),             '12',     'simple %u';
is sprintf('%u', 22.01),          '22',     'decimal %u';
is sprintf('%04u', 32),           '0032',   '0-padded %u';
is sprintf('%04u', 42.6),         '0042',   '0-padded decimal %u';

is sprintf('%o', 12),             '14',     'simple %o';
is sprintf('%o', 22.01),          '26',     'decimal %o';
is sprintf('%03o', 32),           '040',    '0-padded %o';
is sprintf('%03o', 42.6),         '052',    '0-padded decimal %o';

is sprintf('%x', 0),              '0',      'simple %x';
is sprintf('%x', 12),             'c',      'simple %x';
is sprintf('%x', 22.01),          '16',     'decimal %x';
is sprintf('%03x', 32),           '020',    '0-padded %x';
is sprintf('%03x', 42.6),         '02a',    '0-padded decimal %x';
# tests for %X
is sprintf('%X', 12),             'C',      'simple %X';
is sprintf('%03X', 42.6),         '02A',    '0-padded decimal %X';

is sprintf('%d', 453973694165307953197296969697410619233826),
    "453973694165307953197296969697410619233826",
    '%d works for big ints';
is sprintf('%d', -453973694165307953197296969697410619233826),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big ints';
is sprintf('%b', 453973694165307953197296969697410619233826),
    "1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for big ints';
is sprintf('%b', -453973694165307953197296969697410619233826),
    "-1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for negative big ints';
is sprintf('%o', 453973694165307953197296969697410619233826),
    "12330336622373426073156312316453553176124653042",
    '%o works for big ints';
is sprintf('%o', -453973694165307953197296969697410619233826),
    "-12330336622373426073156312316453553176124653042",
    '%o works for negative big ints';
is sprintf('%x', 453973694165307953197296969697410619233826),
    "5361bd927dc58766e6533a576b3f1535622",
    '%x works for big ints';
is sprintf('%x', -453973694165307953197296969697410619233826),
    "-5361bd927dc58766e6533a576b3f1535622",
    '%x works for negative big ints';
is sprintf('%X', 453973694165307953197296969697410619233826),
    "5361BD927DC58766E6533A576B3F1535622",
    '%X works for big ints';
is sprintf('%X', -453973694165307953197296969697410619233826),
    "-5361BD927DC58766E6533A576B3F1535622",
    '%X works for negative big ints';

is sprintf('%d', 453973694165307953197296969697410619233826 + .1),
    "453973694165307953197296969697410619233826",
    '%d works for big Rats';
is sprintf('%d', -453973694165307953197296969697410619233826 - .1),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big Rats';
is sprintf('%d', (453973694165307953197296969697410619233826 + .1).FatRat),
    "453973694165307953197296969697410619233826",
    '%d works for big FatRats';
is sprintf('%d', (-453973694165307953197296969697410619233826 - .1).FatRat),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big FatRats';
is sprintf('%b', 453973694165307953197296969697410619233826 + .1),
    "1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for big Rats';
is sprintf('%b', -453973694165307953197296969697410619233826 - .1),
    "-1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for negative big Rats';
is sprintf('%o', 453973694165307953197296969697410619233826 + .1),
    "12330336622373426073156312316453553176124653042",
    '%o works for big Rats';
is sprintf('%o', -453973694165307953197296969697410619233826 - .1),
    "-12330336622373426073156312316453553176124653042",
    '%o works for negative big Rats';
is sprintf('%x', 453973694165307953197296969697410619233826 + .1),
    "5361bd927dc58766e6533a576b3f1535622",
    '%x works for big Rats';
is sprintf('%x', -453973694165307953197296969697410619233826 - .1),
    "-5361bd927dc58766e6533a576b3f1535622",
    '%x works for negative big Rats';
is sprintf('%X', 453973694165307953197296969697410619233826 + .1),
    "5361BD927DC58766E6533A576B3F1535622",
    '%X works for big Rats';
is sprintf('%X', -453973694165307953197296969697410619233826 - .1),
    "-5361BD927DC58766E6533A576B3F1535622",
    '%X works for negative big Rats';

is sprintf('%5.2f', 3.1415),    ' 3.14',    '5.2 %f';
is sprintf('%5.2F', 3.1415),    ' 3.14',    '5.2 %F';
is sprintf('%5.2g', 3.1415),    '  3.1',    '5.2 %g';
is sprintf('%5.2G', 3.1415),    '  3.1',    '5.2 %G';

ok sprintf('%5.2e', 3.1415)     ~~ /^ "3.14e+" "0"? "00" $/, '5.2 %e';
ok sprintf('%5.2E', 3.1415)     ~~ /^ "3.14E+" "0"? "00" $/, '5.2 %E';
ok sprintf('%5.2g', 3.1415e30)  ~~ /^ "3.1e+" "0"? "30" $/, '5.2 %g';
ok sprintf('%5.2G', 3.1415e30)  ~~ /^ "3.1E+" "0"? "30" $/, '5.2 %G';
ok sprintf('%5.2g', 3.1415e-30) ~~ /^ "3.1e-" "0"? "30" $/, '5.2 %g';
ok sprintf('%5.2G', 3.1415e-30) ~~ /^ "3.1E-" "0"? "30" $/, '5.2 %G';

is sprintf('%20.2f', 3.1415),    '                3.14',    '20.2 %f';
is sprintf('%20.2F', 3.1415),    '                3.14',    '20.2 %F';
is sprintf('%20.2g', 3.1415),    '                 3.1',    '20.2 %g';
is sprintf('%20.2G', 3.1415),    '                 3.1',    '20.2 %G';

ok sprintf('%20.2e', 3.1415)      eq '           3.14e+000' | '            3.14e+00', '20.2 %e';
ok sprintf('%20.2E', 3.1415)      eq '           3.14E+000' | '            3.14E+00', '20.2 %E';
ok sprintf('%20.2g', 3.1415e30)   eq '            3.1e+030' | '             3.1e+30', '20.2 %g';
ok sprintf('%20.2G', 3.1415e30)   eq '            3.1E+030' | '             3.1E+30', '20.2 %G';
ok sprintf('%20.2g', 3.1415e-30)  eq '            3.1e-030' | '             3.1e-30', '20.2 %g';
ok sprintf('%20.2G', 3.1415e-30)  eq '            3.1E-030' | '             3.1E-30', '20.2 %G';

is sprintf('%20.2f', -3.1415),    '               -3.14',    'negative 20.2 %f';
is sprintf('%20.2F', -3.1415),    '               -3.14',    'negative 20.2 %F';
is sprintf('%20.2g', -3.1415),    '                -3.1',    'negative 20.2 %g';
is sprintf('%20.2G', -3.1415),    '                -3.1',    'negative 20.2 %G';

ok sprintf('%20.2e', -3.1415)     eq '          -3.14e+000' | '           -3.14e+00', 'negative 20.2 %e';
ok sprintf('%20.2E', -3.1415)     eq '          -3.14E+000' | '           -3.14E+00', 'negative 20.2 %E';
ok sprintf('%20.2g', -3.1415e30)  eq '           -3.1e+030' | '            -3.1e+30', 'negative 20.2 %g';
ok sprintf('%20.2G', -3.1415e30)  eq '           -3.1E+030' | '            -3.1E+30', 'negative 20.2 %G';
ok sprintf('%20.2g', -3.1415e-30) eq '           -3.1e-030' | '            -3.1e-30', 'negative 20.2 %g';
ok sprintf('%20.2G', -3.1415e-30) eq '           -3.1E-030' | '            -3.1E-30', 'negative 20.2 %G';

is sprintf('%020.2f', 3.1415),    '00000000000000003.14',    '020.2 %f';
is sprintf('%020.2F', 3.1415),    '00000000000000003.14',    '020.2 %F';
is sprintf('%020.2g', 3.1415),    '000000000000000003.1',    '020.2 %g';
is sprintf('%020.2G', 3.1415),    '000000000000000003.1',    '020.2 %G';

ok sprintf('%020.2e', 3.1415)     eq '000000000003.14e+000' | '0000000000003.14e+00', '020.2 %e';
ok sprintf('%020.2E', 3.1415)     eq '000000000003.14E+000' | '0000000000003.14E+00', '020.2 %E';
ok sprintf('%020.2g', 3.1415e30)  eq '0000000000003.1e+030' | '00000000000003.1e+30', '020.2 %g';
ok sprintf('%020.2G', 3.1415e30)  eq '0000000000003.1E+030' | '00000000000003.1E+30', '020.2 %G';
ok sprintf('%020.2g', 3.1415e-30) eq '0000000000003.1e-030' | '00000000000003.1e-30', '020.2 %g';
ok sprintf('%020.2G', 3.1415e-30) eq '0000000000003.1E-030' | '00000000000003.1E-30', '020.2 %G';

is sprintf('%020.2f', -3.1415),    '-0000000000000003.14',    'negative 020.2 %f';
is sprintf('%020.2F', -3.1415),    '-0000000000000003.14',    'negative 020.2 %F';
is sprintf('%020.2g', -3.1415),    '-00000000000000003.1',    'negative 020.2 %g';
is sprintf('%020.2G', -3.1415),    '-00000000000000003.1',    'negative 020.2 %G';

ok sprintf('%020.2e', -3.1415)     eq '-00000000003.14e+000' | '-000000000003.14e+00', 'negative 020.2 %e';
ok sprintf('%020.2E', -3.1415)     eq '-00000000003.14E+000' | '-000000000003.14E+00', 'negative 020.2 %E';
ok sprintf('%020.2g', -3.1415e30)  eq '-000000000003.1e+030' | '-0000000000003.1e+30', 'negative 020.2 %g';
ok sprintf('%020.2G', -3.1415e30)  eq '-000000000003.1E+030' | '-0000000000003.1E+30', 'negative 020.2 %G';
ok sprintf('%020.2g', -3.1415e-30) eq '-000000000003.1e-030' | '-0000000000003.1e-30', 'negative 020.2 %g';
ok sprintf('%020.2G', -3.1415e-30) eq '-000000000003.1E-030' | '-0000000000003.1E-30', 'negative 020.2 %G';

is sprintf('%e', 2.718281828459), sprintf('%.6e', 2.718281828459), '%e defaults to .6';
is sprintf('%E', 2.718281828459), sprintf('%.6E', 2.718281828459), '%E defaults to .6';
is sprintf('%f', 2.718281828459), sprintf('%.6f', 2.718281828459), '%f defaults to .6';
is sprintf('%g', 2.718281828459), sprintf('%.6g', 2.718281828459), '%g defaults to .6';
is sprintf('%G', 2.718281828459), sprintf('%.6G', 2.718281828459), '%G defaults to .6';

# L<S32::Str/"Str"/"The special directive, %n does not work in Perl 6">
dies_ok(sub {my $x = sprintf('%n', 1234)}, '%n dies (Perl 5 compatibility)');   #OK not used
#?rakudo skip "%p doesn't yet throw exception - but should it, or just Failure?"
dies_ok(sub {my $x = sprintf('%p', 1234)}, '%p dies (Perl 5 compatibility)');   #OK not used

is sprintf('%s', NaN),              NaN,    'sprintf %s handles NaN';
is sprintf('%s', -NaN),             NaN,    'sprintf %s handles NaN';
is sprintf('%s', Inf),              Inf,    'sprintf %s handles Inf';
is sprintf('%s', -Inf),            -Inf,    'sprintf %s handles Inf';

is sprintf('%d %1$x %1$o', 12),    '12 c 14',  'positional argument specifier $';

# RT 117547
is sprintf('%10s', "☃" x 3), '       ☃☃☃', 'multi-byte characters are counted correctly for %Ns strings';

is sprintf("%x %x", 301281685344656640, 301281685344656669), '42e5e18b84c9d00 42e5e18b84c9d1d',   'RT #118601';
is sprintf("%d", 42**20),                                    '291733167875766667063796853374976', 'RT #118253';
is map({chars sprintf "[%18s]\n", "ಠ" x $_ }, 0..6),         [21, 21, 21, 21, 21, 21, 21],        'RT #117547';
#?niecza skip 'Date NYI'
is Date.new(-13_000_000_000, 1, 1),                          '-13000000000-01-01',                'RT #114760';

# RT #116280
#?rakudo.jvm skip "java.lang.NumberFormatException"
{
    #?rakudo.parrot todo 'sprintf prints numbers before NaN'
    is sprintf('%12.5f',  NaN), '         NaN', 'RT 116280';
    #?rakudo.parrot 2 skip "sprintf hangs when printing Inf/-Inf"
    #?niecza 2 todo "https://github.com/sorear/niecza/issues/181"
    is sprintf('%12.5f',  Inf), '         Inf', 'RT 116280';
    is sprintf('%12.5f', -Inf), '        -Inf', 'RT 116280';
}

# RT #106594, #62316, #74610
#?niecza skip 'dubious test - should be testing exception type, not string. Niecza does respond with an appropriate, but differently worded string'
{
    try sprintf("%d-%s", 42);
    is $!, 'Too many directives: found 2, but only 1 arguments after the format string', 'RT #106594, #62316, #74610';
}

# vim: ft=perl6
