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

is_run $x, :args['-e', 'say @*ARGS', '-e=foo'],
    {
        out     => "-e=foo\n",
        err     => '',
        status  => 0,
    },
    '-e works correctly as a stopper';
