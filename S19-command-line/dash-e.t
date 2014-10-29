use v6;
use Test;
plan 4;

use lib 't/spec/packages';
use Test::Util;

my Str $x;

is_run $x,  :args['-e', 'print q[Moin]'],
    {
        out     => 'Moin',
        err     => '',
        status  => 0,
    },
    '-e print $something works';

# RT #111572
# this is a hack to avoid test failures for rakudo.parrot on Mac OS X
# there is no easy way to fudge for a specific platform
# the if/else doesn't work well with fudging (test count goes wrong)
if $*DISTRO.name eq 'macosx' and $*VM.name eq 'parrot' {
    todo('RT #111572'); is_run $x,  :args['-e', "print q[\c[LATIN SMALL LETTER A WITH DOT ABOVE]]"],
        {
            out     => "\c[LATIN SMALL LETTER A WITH DOT ABOVE]",
            err     => '',
            status  => 0,
        },
        '-e print $something works with non-ASCII string literals';
    todo('RT #111572'); is_run $x,  :args['-e', 'print <1 2> »+« <1 1>'],
        {
            out     => "23",
            err     => '',
            status  => 0,
        },
        '-e works with non-ASCII program texts';
}
else {
    is_run $x,  :args['-e', "print q[\c[LATIN SMALL LETTER A WITH DOT ABOVE]]"],
        {
            out     => "\c[LATIN SMALL LETTER A WITH DOT ABOVE]",
            err     => '',
            status  => 0,
        },
        '-e print $something works with non-ASCII string literals';

    is_run $x,  :args['-e', 'print <1 2> »+« <1 1>'],
        {
            out     => "23",
            err     => '',
            status  => 0,
        },
        '-e works with non-ASCII program texts';
}

is_run $x, :args['-e', 'say @*ARGS', '-e=foo'],
    {
        out     => "-e=foo\n",
        err     => '',
        status  => 0,
    },
    '-e works correctly as a stopper';
