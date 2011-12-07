use v6;
use Test;

plan 4;

BEGIN { @*INC.push('t/spec/packages') };

use Test::Util;

is_run 'use v6; warn; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => /:i Warning/,
    },
    'warn() without arguments';

#?rakudo todo 'nom regression'
is_run 'use v6; warn("OH NOEZ"); say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => rx/ 'OH NOEZ'/ & rx/:i 'line 1'>>/,
    },
    'warn() with arguments; line number';

is_run 'use v6; try {warn("OH NOEZ") }; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => rx/ 'OH NOEZ'/,
    },
    'try does not surpress warnings';

#?rakudo todo 'quietly'
is_run 'use v6; quietly {warn("OH NOEZ") }; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => '',
    },
    'quietly does not surpress warnings';

# vim: ft=perl6
