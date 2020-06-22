use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

is_run Str,  :args['--help'],
    {
        out     => { .chars > 20 },
        err     => '',
        status  => 0,
    },
    '--help tells us something, and returns 0';


# vim: expandtab shiftwidth=4
