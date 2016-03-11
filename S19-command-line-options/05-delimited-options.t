use v6;

use lib 't/spec/packages';

use Test;

plan 1;

use Test::Util;

my Str $x;

#L<S19/Options and Values/These options are made available>

#?rakudo todo "delimited options NYI RT #125020"
is_run $x, :args['++FOO', '--bar', '++/FOO', '-e', 'say %*OPTS<FOO>'],
    {
        out     => '--bar\n',
        err     => '',
        status  => 0,
    },
    'delimited options end up in the right place';
