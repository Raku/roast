use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

my Str $x;

is_run $x,  :args['-e', 'q[Moin].print'],
    {
        out     => 'Moin',
        err     => '',
        status  => 0,
    },
    '-e print $something works';

is_run $x,  :args['-e', "q[\c[LATIN SMALL LETTER A WITH DOT ABOVE]].print"],
    {
        out     => "\c[LATIN SMALL LETTER A WITH DOT ABOVE]",
        err     => '',
        status  => 0,
    },
    '-e print $something works with non-ASCII string literals';

is_run $x,  :args['-e', '[6,6,6]».print'],
    {
        out     => "666",
        err     => '',
        status  => 0,
    },
        '-e works with non-ASCII program texts';

is_run $x, :args['-e', '@*ARGS.say', '-e=foo'],
    {
        out     => "[-e=foo]\n",
        err     => '',
        status  => 0,
    },
    '-e works correctly as a stopper';

# vim: expandtab shiftwidth=4
