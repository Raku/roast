use v6.c;
use Test;

plan  27;

use lib 't/spec/packages';

use Test::Util;


# Basic functionality

is_run 'sub MAIN($x) { }; sub USAGE() { print "USAGE() called" }',
    {
        out => 'USAGE() called',
        status => 2,
    },
    'a user-defined USAGE sub is called if MAIN dispatch fails';

is_run 'sub MAIN() { print "MAIN() called" }; sub USAGE() { print "USAGE() called" }',
    {
        out    => 'MAIN() called',
        status => 0,
    },
    'a user-defined USAGE sub is not called if MAIN dispatch succeeds';

is_run 'sub MAIN( $a = nosuchsub()) { }; sub USAGE { say 42 }',
    {
        out => '',
        err => /nosuchsub/,
    },
    'if the MAIN dispatch results in an error, that error should be printed, not USAGE';

is_run 'sub MAIN($foo) { }',
    {
        err     => /<< foo >>/,
        out     => '',
    },
    'auto-generated USAGE message goes to $*ERR and contains parameter name';

is_run 'sub MAIN($bar) { }',
    {
        out => /<< bar >>/,
    },
    :args['--help'],
    '--help option sends auto-generated USAGE message to $*OUT';

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

is_run 'sub MAIN(:xen(:$xin)) { print $xin }',
    {
        out => "23",
    },
    :args['--xin=23'],
    'named alias (inner name)';

is_run 'sub MAIN(:xen(:$xin)) { print $xin }',
    {
        out => "23",
    },
    :args['--xen=23'],
    'named alias (outer name)';

# RT #71366
is_run 'sub MAIN($a, :$var) { say "a: $a, optional: $var"; }',
    {
        err     => /\-\-var/,
        out     => '',
    },
    :args['param', '--var'],
    'Non Bool option last with no value';

is_run 'sub MAIN($a, Bool :$var) { say "a: $a, optional: $var"; }',
    {
        out     => "a: param, optional: True\n",
    },
    :args['--var', 'param'],
    'Bool option followed by positional value';


# Spacey options may be removed from core spec; for now, moving to end of tests
# (discussion starts at http://irclog.perlgeek.de/perl6/2011-10-17#i_4578353 )

#?rakudo todo 'nom regression RT #124664'
#?niecza todo 'copied nom regression'
is_run 'sub MAIN(:$x) { print $x }',
    {
        out => "23",
    },
    :args['--x', '23'],
    'option with spacey value';

#?rakudo todo 'nom regression RT #124665'
#?niecza todo 'copied nom regression'
is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['--xen', '23'],
    'long option with spacey value';

#?rakudo todo 'nom regression RT #124666'
#?niecza todo 'copied nom regression'
is_run 'sub MAIN(:xen(:$xin)) { print $xin }',
    {
        out => "23",
    },
    :args['--xin', '23'],
    'named alias (inner name) with spacey value';

#?rakudo todo 'nom regression RT #124667'
#?niecza todo 'copied nom regression'
is_run 'sub MAIN(:xen(:$xin)) { print $xin }',
    {
        out => "23",
    },
    :args['--xen', '23'],
    'named alias (outer name) with spacey value';

#?rakudo todo 'nom regression RT #124668'
#?niecza todo 'copied nom regression'
is_run 'sub MAIN(:xen(:$x)) { print $x }',
    {
        out => "23",
    },
    :args['-x', '23'],
    'short option with spacey value';

is_run 'subset Command of Str where "run";
multi MAIN(Command $c) { print 1 },
multi MAIN()           { print 2 }',
{ out => "2" };


# RT #92986
is_run 'multi MAIN($) { print q[Any] }; multi MAIN(Str) { print q[Str] }',
    {
        out => 'Str',
    },
    :args['foo'],
    'best multi matches (not just first one)';

is_run 'sub MAIN() { print 42 }',
    {
        out => '',
        err => rx:i/usage/,
    },
    :args['--foo'],
    'superfluous options trigger usage message';

# RT #115744
#?niecza todo
is_run 'sub MAIN($arg) { print $arg }',
    {
        out => "--23"
    },
    :args['--', '--23'],
    'Stopping option processing';

#?niecza todo
is_run 'sub MAIN($arg, Bool :$bool) { print $bool, $arg }',
    {
        out => 'True-option'
    },
    :args['--bool', '--', '-option'],
    'Boolean argument with --';

#?niecza todo
is_run 'sub MAIN(:@foo) { print @foo }',
    {
        out => "bar"
    },
    :args['--foo=bar'],
    'single occurence for named array param';

#?niecza todo
is_run 'sub MAIN(:@foo) { print @foo }',
    {
        out => "bar baz"
    },
    :args['--foo=bar', '--foo=baz'],
    'multiple occurence for named array param';

#?niecza todo
is_run 'multi MAIN(:$foo) { print "Scalar" }; multi MAIN(:@foo) { print "Array" }',
    {
        out => "Scalar"
    },
    :args['--foo=bar'],
    'correctly select Scalar candidate from Scalar and Array candidates.';

#?rakudo todo 'NYI RT #124670'
#?niecza todo
is_run 'multi MAIN(:$foo) { print "Scalar" }; multi MAIN(:@foo) { print "Array" }',
    {
        out => "Array"
    },
    :args['--foo=bar', '--foo=baz'],
    'correct select Array candidate from Scalar and Array candidates.';

# RT #119001
is_run 'sub MAIN (Str $value) { print "String $value" }',
    {
        out => 'String 10',
        err => '',
    },
    :args[10],
    'passing an integer matches MAIN(Str)';
