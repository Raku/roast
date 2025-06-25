use v6.e.PREVIEW;
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 174;

# L<S32::Str/Str/"identical to" "C library zprintf">

is zprintf("Hi"),                 "Hi",     "zprintf() works with zero args";
is zprintf("%%"),                 "%",      "zprintf() escapes % correctly";
is zprintf("%03d",      3),       "003",    "zprintf() works with one arg";
is zprintf("%03d %02d", 3, 1),    "003 01", "zprintf() works with two args";
is zprintf("%d %d %d",  3,1,4),   "3 1 4",  "zprintf() works with three args";
is zprintf("%d%d%d%d",  3,1,4,1), "3141",   "zprintf() works with four args";

ok(EVAL('zprintf("%b",1)'), 'EVAL of zprintf() with %b');

is zprintf("%04b",3),    '0011',  '0-padded zprintf() with %b';
is zprintf("%4b",3),     '  11',  '" "-padded zprintf() with %b';
is zprintf("%b",30),     '11110', 'longer string, no padding';
is zprintf("%2b",30),    '11110', 'padding specified, not needed';
is zprintf("%03b",7),    '111',   '0 padding, longer string';
is zprintf("%b %b",3,3), '11 11', 'two args %b';

is zprintf('%c', 97), 'a', '%c test';

is zprintf('%s', 'string'),        'string', '%s test';
is zprintf('%10s', 'string'),  '    string', '%s right-justified';
is zprintf('%-10s', 'string'), 'string    ', '%s left-justified';

is zprintf('%d', 12),    '12',   'simple %d';
is zprintf('%d', -22),   '-22',  'negative %d';
is zprintf('%04d', 32),  '0032', '0-padded %d';
is zprintf('%04d', -42), '-042', '0-padded negative %d';
is zprintf('%i', -22),   '-22',  'negative %i';
is zprintf('%04i', -42), '-042', '0-padded negative %i';
is zprintf('%4d', 32),   '  32', 'space-padded %d';
is zprintf('%4d', -42),  ' -42', 'space-padded negative %d';
is zprintf('%4i', -42),  ' -42', 'space-padded negative %i';
is zprintf('%-4i', -42), '-42 ', 'left-justified negative %i';

is zprintf('%u', 12),    '12',   'simple %u';
is zprintf('%u', 22.01), '22',   'decimal %u';
is zprintf('%04u', 32),  '0032', '0-padded %u';
is zprintf('%04u', 42.6),'0042', '0-padded decimal %u';

is zprintf('%o', 12),     '14',  'simple %o';
is zprintf('%o', 22.01),  '26',  'decimal %o';
is zprintf('%03o', 32),   '040', '0-padded %o';
is zprintf('%03o', 42.6), '052', '0-padded decimal %o';

is zprintf('%x', 0),      '0',   'simple %x';
is zprintf('%x', 12),     'c',   'simple %x';
is zprintf('%x', 22.01),  '16',  'decimal %x';
is zprintf('%03x', 32),   '020', '0-padded %x';
is zprintf('%03x', 42.6), '02a', '0-padded decimal %x';
# tests for %X
is zprintf('%X', 12),     'C',   'simple %X';
is zprintf('%03X', 42.6), '02A', '0-padded decimal %X';

is zprintf('%d', 453973694165307953197296969697410619233826),
    "453973694165307953197296969697410619233826",
    '%d works for big ints';
is zprintf('%d', -453973694165307953197296969697410619233826),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big ints';
is zprintf('%b', 453973694165307953197296969697410619233826),
    "1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for big ints';
is zprintf('%b', -453973694165307953197296969697410619233826),
    "-1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for negative big ints';
is zprintf('%o', 453973694165307953197296969697410619233826),
    "12330336622373426073156312316453553176124653042",
    '%o works for big ints';
is zprintf('%o', -453973694165307953197296969697410619233826),
    "-12330336622373426073156312316453553176124653042",
    '%o works for negative big ints';
is zprintf('%x', 453973694165307953197296969697410619233826),
    "5361bd927dc58766e6533a576b3f1535622",
    '%x works for big ints';
is zprintf('%x', -453973694165307953197296969697410619233826),
    "-5361bd927dc58766e6533a576b3f1535622",
    '%x works for negative big ints';
is zprintf('%X', 453973694165307953197296969697410619233826),
    "5361BD927DC58766E6533A576B3F1535622",
    '%X works for big ints';
is zprintf('%X', -453973694165307953197296969697410619233826),
    "-5361BD927DC58766E6533A576B3F1535622",
    '%X works for negative big ints';

is zprintf('%d', 453973694165307953197296969697410619233826 + .1),
    "453973694165307953197296969697410619233826",
    '%d works for big Rats';
is zprintf('%d', -453973694165307953197296969697410619233826 - .1),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big Rats';
is zprintf('%d', (453973694165307953197296969697410619233826 + .1).FatRat),
    "453973694165307953197296969697410619233826",
    '%d works for big FatRats';
is zprintf('%d', (-453973694165307953197296969697410619233826 - .1).FatRat),
    "-453973694165307953197296969697410619233826",
    '%d works for negative big FatRats';
is zprintf('%b', 453973694165307953197296969697410619233826 + .1),
    "1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for big Rats';
is zprintf('%b', -453973694165307953197296969697410619233826 - .1),
    "-1010011011000011011110110010010011111011100010110000111011001101110011001010011001110100101011101101011001111110001010100110101011000100010",
    '%b works for negative big Rats';
is zprintf('%o', 453973694165307953197296969697410619233826 + .1),
    "12330336622373426073156312316453553176124653042",
    '%o works for big Rats';
is zprintf('%o', -453973694165307953197296969697410619233826 - .1),
    "-12330336622373426073156312316453553176124653042",
    '%o works for negative big Rats';
is zprintf('%x', 453973694165307953197296969697410619233826 + .1),
    "5361bd927dc58766e6533a576b3f1535622",
    '%x works for big Rats';
is zprintf('%x', -453973694165307953197296969697410619233826 - .1),
    "-5361bd927dc58766e6533a576b3f1535622",
    '%x works for negative big Rats';
is zprintf('%X', 453973694165307953197296969697410619233826 + .1),
    "5361BD927DC58766E6533A576B3F1535622",
    '%X works for big Rats';
is zprintf('%X', -453973694165307953197296969697410619233826 - .1),
    "-5361BD927DC58766E6533A576B3F1535622",
    '%X works for negative big Rats';

is zprintf('%5.2f', 3.1415),    ' 3.14',    '5.2 %f';
is zprintf('%5.2F', 3.1415),    ' 3.14',    '5.2 %F';
is zprintf('%5.2g', 3.1415),    ' 3.14',    '5.2 %g';
is zprintf('%5.2G', 3.1415),    ' 3.14',    '5.2 %G';

is zprintf('%5.2e', 3.1415),     "3.14e+00",  '5.2 %e';
is zprintf('%5.2E', 3.1415),     "3.14E+00",  '5.2 %E';
is zprintf('%5.2g', 3.1415e30),  "3.14g+30",  '5.2 %g +30';
is zprintf('%5.2G', 3.1415E30),  "3.14G+30",  '5.2 %G +30';
is zprintf('%5.2g', 3.1415e-30), "3.14g-30",  '5.2 %g -30';
is zprintf('%5.2G', 3.1415E-30), "3.14G-30",  '5.2 %G -30';

is zprintf('%20.2f', 3.1415), '                3.14', '20.2 %f';
is zprintf('%20.2F', 3.1415), '                3.14', '20.2 %F';
is zprintf('%20.2g', 3.1415), '                3.14', '20.2 %g';
is zprintf('%20.2G', 3.1415), '                3.14', '20.2 %G';

is zprintf('%20.2e', 3.1415),     '            3.14e+00', '20.2 %e';
is zprintf('%20.2E', 3.1415),     '            3.14E+00', '20.2 %E';
is zprintf('%20.2g', 3.1415e30),  '            3.14e+30', '20.2 %g +30';
is zprintf('%20.2G', 3.1415e30),  '            3.14E+30', '20.2 %G +30';
is zprintf('%20.2g', 3.1415e-30), '            3.14e-30', '20.2 %g -30';
is zprintf('%20.2G', 3.1415e-30), '            3.14E-30', '20.2 %G -30';

is zprintf('%20.2f', -3.1415), '               -3.14', 'negative 20.2 %f';
is zprintf('%20.2F', -3.1415), '               -3.14', 'negative 20.2 %F';
is zprintf('%20.2g', -3.1415), '               -3.14', 'negative 20.2 %g';
is zprintf('%20.2G', -3.1415), '               -3.14', 'negative 20.2 %G';

is zprintf('%20.2e', -3.1415),     '           -3.14e+00', 'negative 20.2 %e';
is zprintf('%20.2E', -3.1415),     '           -3.14E+00', 'negative 20.2 %E';
is zprintf('%20.2g', -3.1415e30),  '           -3.14e+30', 'negative 20.2 %g';
is zprintf('%20.2G', -3.1415e30),  '           -3.14E+30', 'negative 20.2 %G';
is zprintf('%20.2g', -3.1415e-30), '           -3.14e-30', 'negative 20.2 %g';
is zprintf('%20.2G', -3.1415e-30), '           -3.14E-30', 'negative 20.2 %G';

is zprintf('%020.2f', 3.1415), '00000000000000003.14', '020.2 %f';
is zprintf('%020.2F', 3.1415), '00000000000000003.14', '020.2 %F';
is zprintf('%020.2g', 3.1415), '00000000000000003.14', '020.2 %g';
is zprintf('%020.2G', 3.1415), '00000000000000003.14', '020.2 %G';

is zprintf('%020.2e', 3.1415),     '0000000000003.14e+00', '020.2 %e';
is zprintf('%020.2E', 3.1415),     '0000000000003.14E+00', '020.2 %E';
is zprintf('%020.2g', 3.1415e30),  '00000000000034.1e+30', '020.2 %g';
is zprintf('%020.2G', 3.1415e30),  '00000000000034.1E+30', '020.2 %G';
is zprintf('%020.2g', 3.1415e-30), '00000000000034.1e-30', '020.2 %g';
is zprintf('%020.2G', 3.1415e-30), '00000000000034.1E-30', '020.2 %G';

is zprintf('%020.2f', -3.1415),    '-0000000000000003.14', 'negative 020.2 %f';
is zprintf('%020.2F', -3.1415),    '-0000000000000003.14', 'negative 020.2 %F';
is zprintf('%020.2g', -3.1415),    '-0000000000000003.14', 'negative 020.2 %g';
is zprintf('%020.2G', -3.1415),    '-0000000000000003.14', 'negative 020.2 %G';

is zprintf('%020.2e', -3.1415),     '-000000000003.14e+00', 'negative 020.2 %e';
is zprintf('%020.2E', -3.1415),     '-000000000003.14E+00', 'negative 020.2 %E';
is zprintf('%020.2g', -3.1415e30),  '-000000000003.14e+30', 'negative 020.2 %g';
is zprintf('%020.2G', -3.1415e30),  '-000000000003.14E+30', 'negative 020.2 %G';
is zprintf('%020.2g', -3.1415e-30), '-000000000003.14e-30', 'negative 020.2 %g';
is zprintf('%020.2G', -3.1415e-30), '-000000000003.14E-30', 'negative 020.2 %G';

is zprintf("%.5f", pi),   '3.14159',  '"%.5"';
is zprintf("%.5f", -pi),  '-3.14159', 'negative "%.5"';
is zprintf("%+.5f", -pi), '-3.14159', 'negative "%+.5"';
is zprintf("%+.5f", pi),  '+3.14159', '"%+.5"';
is zprintf("% .5f", pi),  ' 3.14159', '" %.5"';
is zprintf("% .5f", -pi), '-3.14159', 'negative "%.5"';

is zprintf('%e', 2.718281828459), zprintf('%.6e', 2.718281828459), '%e defaults to .6';
is zprintf('%E', 2.718281828459), zprintf('%.6E', 2.718281828459), '%E defaults to .6';
is zprintf('%f', 2.718281828459), zprintf('%.6f', 2.718281828459), '%f defaults to .6';
is zprintf('%g', 2.718281828459), zprintf('%.6g', 2.718281828459), '%g defaults to .6';
is zprintf('%G', 2.718281828459), zprintf('%.6G', 2.718281828459), '%G defaults to .6';

# L<S32::Str/"Str"/"The special directive, %n does not work in Raku">
dies-ok(sub {my $x = zprintf('%n', 1234)}, '%n dies (Perl compatibility)');   #OK not used
dies-ok(sub {my $x = zprintf('%p', 1234)}, '%p dies (Perl compatibility)');   #OK not used

is zprintf('%s', NaN),   NaN, 'zprintf %s handles NaN';
is zprintf('%s', -NaN),  NaN, 'zprintf %s handles NaN';
is zprintf('%s', Inf),   Inf, 'zprintf %s handles Inf';
is zprintf('%s', -Inf), -Inf, 'zprintf %s handles Inf';

is zprintf('%d %1$x %1$o', 12), '12 c 14', 'positional argument specifier $';

# https://github.com/Raku/old-issue-tracker/issues/3099
is zprintf('%10s', "☃" x 3), '       ☃☃☃',
  'multi-byte characters are counted correctly for %Ns strings';

# https://github.com/Raku/old-issue-tracker/issues/3174
is zprintf("%x %x", 301281685344656640, 301281685344656669),
  '42e5e18b84c9d00 42e5e18b84c9d1d',
  'RT #118601';

# https://github.com/Raku/old-issue-tracker/issues/3151
is zprintf("%d", 42**20), '291733167875766667063796853374976', 'RT #118253';

# https://github.com/Raku/old-issue-tracker/issues/3099
is map({chars zprintf "[%18s]\n", "ಠ" x $_ }, 0..6),
  [21, 21, 21, 21, 21, 21, 21],
  'RT #117547';

# https://github.com/Raku/old-issue-tracker/issues/3019
{
    is zprintf('%12.5f',  NaN), '         NaN', 'RT #116280';
    is zprintf('%12.5f',  Inf), '         Inf', 'RT #116280';
    is zprintf('%12.5f', -Inf), '        -Inf', 'RT #116280';

    is zprintf('% 6e', Inf), "   Inf", 'Inf properly handled %e';
    is zprintf('%+6E', Inf), "  +Inf", 'Inf properly handled %E';
    is zprintf('%6f', Inf),  "   Inf", 'Inf properly handled %f';
    is zprintf('%+6g', Inf), "  +Inf", 'Inf properly handled %g';
    is zprintf('% 6G', Inf), "   Inf", 'Inf properly handled %G';
    is zprintf('%e', -Inf),  "-Inf",   '-Inf properly handled %e';
    is zprintf('%E', -Inf),  "-Inf",   '-Inf properly handled %E';
    is zprintf('%f', -Inf),  "-Inf",   '-Inf properly handled %f';
    is zprintf('%g', -Inf),  "-Inf",   '-Inf properly handled %g';
    is zprintf('%G', -Inf),  "-Inf",   '-Inf properly handled %G';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    throws-like { zprintf 'D6.2', 'foo' }, X::Str::Sprintf::Directives::Count,
    :args-used(0),
    :args-have(1),
    'Invalid formats do not spill internal details';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    throws-like { zprintf("%d-%s", 42) }, X::Str::Sprintf::Directives::Count,
    :args-used(2),
    :args-have(1),
    "Warn of possible '\$' in format";
}

# GH #3682
{
    throws-like {
        my $k = 'foo';
        my $v = 'bar %s';
        zprintf("%s => $v", $k) }, X::Str::Sprintf::Directives::Count,
    :args-used(2),
    :args-have(1),
    "Warn of possible '\$' in format";
}
# https://github.com/Raku/old-issue-tracker/issues/3542
#
#   This test was removed since it is a duplicate of the test found in
#   "rakudo/t/05-messages/02-errors.t", line 135.
#
#   That test was added due to:
#     https://github.com/Raku/old-issue-tracker/issues/3542

# found by japhb
{
    is zprintf("%.0f", 1.969), "2",     '%.0f of 1.969 should be 2';
    is zprintf("%.1f", 1.969), "2.0",   '%.1f of 1.969 should be 2.0';
    is zprintf("%.2f", 1.969), "1.97",  '%.2f of 1.969 should be 1.97';
    is zprintf("%.3f", 1.969), "1.969", '%.3f of 1.969 should be 1.969';
}

# https://github.com/Raku/old-issue-tracker/issues/3248
{
    is zprintf('%.50f', 1.115),
        '1.11500000000000000000000000000000000000000000000000',
        '%.50f of 1.115 is correct';
}

{
    throws-like { zprintf "%d", 0^1 }, X::Str::Sprintf::Directives::BadType, :type('Junction'),
        "zprintf complains about types that can't be displayed as the directive specifies";
}

{
    throws-like { zprintf "%q", 0 }, X::Str::Sprintf::Directives::Unsupported,
        'zprintf complains about unsupported directives';
}

# https://irclog.perlgeek.de/perl6/2016-11-28#i_13640361
{
    is_run ｢print zprintf 'pass'｣, {
        :out<pass>, :err(''), :0status
    }, 'zprintf($format) does not issue spurious warnings';
}

# https://irclog.perlgeek.de/perl6-dev/2017-01-22#i_13966753
{
    is zprintf( '%.3d', [42]),   '042', '%.3d';
    is zprintf('%2.4d', [42]),  '0042', '%2.4d';
    is zprintf('%5.3d', [42]), '  042', '%5.3d';
    is zprintf( '%.0d', [42]),    '42', '%.0d (non-zero number)';
    is zprintf( '%.0d', [ 0]),      '', '%.0d (number is zero)' ;

    is zprintf( '%.*d', [3, 42]),   '042', '%.*d';
    is zprintf('%2.*d', [4, 42]),  '0042', '%2.*d';
    is zprintf('%5.*d', [3, 42]), '  042', '%5.*d';
    is zprintf( '%.*d', [0, 42]),    '42', '%.*d (non-zero number)';
    is zprintf( '%.*d', [0,  0]),      '', '%.*d (number is zero)';
}

# https://github.com/Raku/old-issue-tracker/issues/3716
{
    is zprintf('%064b', -100), '-' ~ ('0' x 56) ~ '1100100',
      '%064b format works with negatives';
}

# https://github.com/Raku/old-issue-tracker/issues/6672
subtest 'zprintf with Numeric/Str type objects' => {
    plan 18*my @types := Num, Int, Rat, Complex, Str;
    sub qs (|c) { quietly zprintf |c }

    for @types -> \T {
        my $p := "with {T.raku}";
        is-deeply qs('%c',   T), "\0",           "%c   $p";
        is-deeply qs('%02c', T), "0\0",          "%02c $p";
        is-deeply qs('%u',   T), '0',            "%u   $p";
        is-deeply qs('%02u', T), '00',           "%02u $p";
        is-deeply qs('%x',   T), '0',            "%x   $p";
        is-deeply qs('%02x', T), '00',           "%02x $p";

        is-deeply qs('%d',   T), '0',            "%d   $p";
        is-deeply qs('%02d', T), '00',           "%02d $p";
        is-deeply qs('%b',   T), '0',            "%b   $p";
        is-deeply qs('%02b', T), '00',           "%02b $p";
        is-deeply qs('%o',   T), '0',            "%o   $p";
        is-deeply qs('%02o', T), '00',           "%02o $p";

        is-deeply qs('%f',   T), '0.000000',     "%f   $p";
        is-deeply qs('%.2f', T), '0.00',         "%.2f $p";
        is-deeply qs('%e',   T), '0.000000e+00', "%e   $p";
        is-deeply qs('%.2e', T), '0.00e+00',     "%.2e $p";
        is-deeply qs('%g',   T), '0',            "%g   $p";
        is-deeply qs('%.2g', T), '0',            "%.2g $p";
    }
}

is zprintf("%.16e", sqrt 3.0e0), '1.7320508075688772e+00',
    'zprintf maintains sane precision when stringifying nums';

# https://github.com/rakudo/rakudo/issues/4321
{
    enum Str ( :Free<f>, :Inuse<n> );
    lives-ok { "ok %s".zprintf: Free };
}

# vim: expandtab shiftwidth=4
