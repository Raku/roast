use v6;
use Test;

plan  3;

BEGIN { @*INC.push: 't/spec/packages' }

use Test::Util;

#?rakudo todo 'custom USAGE() routine'
is_run 'sub MAIN($x) { }; sub USAGE() { print "usage() called" }',
    {
        out => 'usage() called',
    },
    'a user-defined USAGE sub is called if MAIN-dispatch fails';

is_run 'sub MAIN() { print "main() called" }; sub USAGE() { print "usage() called" }',
    {
        out    => 'main() called',
        status => 0, 
    },
    'a user-defined USAGE sub not is called if MAIN-dispatch succeeds';

is_run 'sub MAIN($foo) { }',
    {
        err     => /<< foo >>/,
        out     => '',
    },
    'automaticly generated USAGE message contains parameter name';
