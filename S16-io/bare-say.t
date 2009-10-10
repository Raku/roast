use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;

plan 5;

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

is_run( 'say()',
        {
            status => sub { $^a != 0 },
            out    => '',
            err    => rx/'say requires an argument'/,
        },
        'say()' );

is_run( 'say("")',
        {
            status => 0,
            out    => "\n",
            err    => '',
        },
        'say("")' );

# vim: ft=perl6
