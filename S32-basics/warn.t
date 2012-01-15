use v6;
use Test;

plan 6;

BEGIN { @*INC.push('t/spec/packages') };

use Test::Util;

{
    # RT #69520
    my $alive = 0;
    try {
        warn "# It's OK to see this warning during a test run";
        $alive = 1;
    }
    ok $alive, 'try blocks do not catch exceptions'
}

{
    my $caught = 0;
    {
        CONTROL { default { $caught = 1 } };
        warn "# You shouldn't see this warning";
    }
    ok $caught, 'CONTROL catches exceptions'
}

#?niecza todo
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
#?niecza todo 'quietly NYI'
is_run 'use v6; quietly {warn("OH NOEZ") }; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => '',
    },
    'quietly does not surpress warnings';

# vim: ft=perl6
