use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;

plan 7;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error">

eval_dies_ok('say', 'bare say is a compiler error');
eval_dies_ok('print', 'bare print is a compiler error');

is_run( 'say ()',
        {
            status => 0,
            out    => "\n",
            err    => '',
        },
        'say ()' );

is_run( 'say("")',
        {
            status => 0,
            out    => "\n",
            err    => '',
        },
        'say("")' );

# RT #61494
{
    eval_dies_ok('say for 1', 'say for 1  is an error');
    #?rakudo todo 'bare say'
    eval_dies_ok('say  for 1', 'say  for 1  is an error');
}

# RT #74822
is_run( 'my %h=<a b c> Z 1,2,3; for %h.sort(*.key) { .say }',
        {
            status => 0,
            out    => "\"a\" => 1\n\"b\" => 2\n\"c\" => 3\n",
            err    => '',
        },
        'for %h { .say } (RT 74822)' );

# vim: ft=perl6
