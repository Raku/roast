use v6;

use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");

use Test;

plan 10;

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

# RT #73768
{
    my $caught = 0;
    {
        CONTROL { default { $caught = 1 } };
        ~Any
    }
    ok $caught, 'Stringifying Any warns';
}

is_run 'use v6; warn; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => /:i Warning/,
    },
    'warn() without arguments';

# RT #124767
is_run 'use v6; warn("OH NOEZ"); say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => rx/ 'OH NOEZ'/ & rx/:i \W '1'>>/,
    },
    'warn() with arguments; line number';

is_run 'use v6; try {warn("OH NOEZ") }; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => rx/ 'OH NOEZ'/,
    },
    'try does not suppress warnings';

is_run 'use v6; quietly {warn("OH NOEZ") }; say "alive"',
    {
        status => 0,
        out => rx/alive/,
        err => '',
    },
    'quietly suppresses warnings';

# RT #132549
is_run ｢
    warn <foo-1  foo-2  foo-3>.all;
    warn ('foo-4',  ('foo-5', 'foo-6').any).all
｣, {:out(''), :0status, :err{
    .contains: <foo-1  foo-2  foo-3  foo-4  foo-5  foo-6>.all
}}, 'no crashes or hangs with Junctions in warn()';

# R#1833
{
    my int $warnings;
    {
        ok List ~~ List.new, 'did the smartmatch work out';
        CONTROL { ++$warnings; .resume }
    }
    is $warnings, 0, 'should not have warned';
}

# vim: ft=perl6
