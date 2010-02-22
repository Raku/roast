use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;

plan 9;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error">

eval_dies_ok('say', 'bare say is a compiler error');
eval_dies_ok('print', 'bare print is a compiler error');
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
{
    eval 'say for 1';
    ok $! ~~ Exception, '"say for 1" (one space) is an error';
    my $errmsg = "$!";

    eval 'say  for 1';
    ok $! ~~ Exception, '"say  for 1" (two spaces) is an error';
    # XXX The problem with this test is the error messages might differ
    #     for innocuous reasons (e.g., a line number)
    #?rakudo 2 todo 'RT #61494'
    is "$!", $errmsg, 'error for two spaces is the same as one space';
    ok "$!" ~~ /« say »/, 'error message is for "say"';
}


# vim: ft=perl6
