use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 1;

my Str $x;

#L<S19/Options and Values/These options are made available>

#?rakudo todo "delimited options NYI"
is_run $x, :args['++FOO', '--bar', '++/FOO', '-e', 'say %*OPTS<FOO>'],
    {
        out     => '--bar\n',
        err     => '',
        status  => 0,
    },
    'delimited options end up in the right place';

# vim: expandtab shiftwidth=4
