use v6;
use Test;
plan 1;

BEGIN { @*INC.push: 't/spec/packages' }
use Test::Util;

is_run Str,  :args['--help'],
    {
        out     => { .chars > 20 },
        err     => '',
        status  => 0,
    },
    '--help tells us something, and returns 0';

