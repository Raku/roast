use v6;
use Test;

plan  14;

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

#?rakudo todo 'nom regression'
is_run 'sub MAIN(:$x) { print $x }',
    {
        out => "23",
    },
    :args['--x', '23'],
    'option with spacey value';

#?rakudo todo 'nom regression'
is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['--xen', '23'],
    'long option with spacey value';

#?rakudo todo 'nom regression'
is_run 'sub MAIN(:xen(:$xin)) { print $xin }',
    {
        out => "23",
    },
    :args['--xin', '23'],
    'named aliases';

#?rakudo todo 'nom regression'
is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['-x', '23'],
    'short option with spacey value';

# RT #71366
is_run 'sub MAIN($a, :$var) { say "a: $a, optional: $var"; }',
    {
        err     => /\-\-var/,
        out     => '',
    },
    :args['param', '--var'],
    'Non Bool option last with no value';

#?rakudo todo 'nom regression'
is_run 'sub MAIN($a, Bool :$var) { say "a: $a, optional: $var"; }',
    {
        out     => "a: param, optional: Bool::True\n",
    },
    :args['param', '--var'],
    'Bool option last with no value';

is_run 'sub MAIN( $a = nosuchsub()) { }; sub USAGE { say 42 }',
    {
        out => '',
        err => /nosuchsub/,
    },
    'if the MAIN dispatch results in an error, that error should be printed, not USAGE';
