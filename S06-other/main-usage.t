use v6;
use Test;

plan  11;

BEGIN { @*INC.push: 't/spec/packages' }

use Test::Util;

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

is_run 'sub MAIN($x) { };',
    {
        out => /<< x >>/,
    },
    :args['--help'],
    '--help triggers a message to $*OUT';

is_run 'sub MAIN(Bool :$x) { say "yes" if $x }',
    {
        out => "yes\n",
        err => '',
        status => 0,
    },
    :args['--x'],
    'boolean option +';

is_run 'sub MAIN(Bool :$x) { print "yes" if $x }',
    {
        out => "",
    },
    :args['--/x'],
    'boolean option -';

is_run 'sub MAIN(:$x) { print $x }',
    {
        out => "23",
    },
    :args['--x=23'],
    'option with value';

is_run 'sub MAIN(:$x) { print $x }',
    {
        out => "23",
    },
    :args['--x', '23'],
    'option with spacey value';

is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['--xen', '23'],
    'long option with spacey value';

#?rakudo todo 'named aliases'
is_run 'sub MAIN(:xen(:$xin)) { print $x }',
    {
        out => "23",
    },
    :args['--xin', '23'],
    'named aliases';

#?rakudo todo 'short forms'
is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['-x', '23'],
    'short option with spacey value';
