use v6;

use Test;

plan 1;

use lib 't/spec/packages';
use Test::Util;

my Str $x;

#L<S19/Backward (In)compatibility/Execute a line of code, with all features>

#?rakudo todo "deprecation message NYI"
is_run $x, :args['-E', 'say q[hi]'],
    {
        out     => rx/'SORRY' .+ 'use -e'/,
        err     => '',
    },
    'deprecation message works';
