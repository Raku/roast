use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/1338
{
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

# https://github.com/Raku/old-issue-tracker/issues/1621
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

# https://github.com/Raku/old-issue-tracker/issues/3987
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

# https://github.com/Raku/old-issue-tracker/issues/6647
is_run ｢
    warn <foo-1  foo-2  foo-3>.all;
    warn ('foo-4',  ('foo-5', 'foo-6').any).all
｣, {:out(''), :0status, :err{
    .contains: <foo-1  foo-2  foo-3  foo-4  foo-5  foo-6>.all
}}, 'no crashes or hangs with Junctions in warn()';

# https://github.com/rakudo/rakudo/issues/1833
{
    my int $warnings;
    {
        nok List ~~ List.new, 'did the smartmatch work out';
        CONTROL { ++$warnings if $_ ~~ CX::Warn; .resume }
    }
    is $warnings, 0, 'should not have warned';
}

# vim: expandtab shiftwidth=4
