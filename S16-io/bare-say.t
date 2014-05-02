use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;

plan 8;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error">

#?rakudo 3 todo 'nom regression'
eval_dies_ok('say', 'bare say is a compiler error');
eval_dies_ok('print', 'bare print is a compiler error');
#?niecza todo
eval_dies_ok('say()', 'say requires an argument');

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
#?rakudo todo 'bare say'
{
    eval_dies_ok('say for 1', 'say for 1  is an error');
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
