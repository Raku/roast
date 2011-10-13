use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;

plan 10;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error">

#?rakudo 3 todo 'nom regression'
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
    #?rakudo todo 'nom regression'
    ok $! ~~ Exception, '"say for 1" (one space) is an error';
    my $errmsg = "$!";

    eval 'say  for 1';
    #?rakudo todo 'nom regression'
    ok $! ~~ Exception, '"say  for 1" (two spaces) is an error';
    # XXX The problem with this test is the error messages might differ
    #     for innocuous reasons (e.g., a line number)
    is "$!", $errmsg, 'error for two spaces is the same as one space';
    #?rakudo todo 'RT #61494'
    ok "$!" ~~ /« say »/, 'error message is for "say"';
}

# RT #74822
#?rakudo todo 'RT #61494'
is_run( 'my %h=<a b c> Z 1,2,3; for %h { .say }',
        {
            status => 0,
            out    => "a\t1\nb\t2\nc\t3\n",
            err    => '',
        },
        'for %h { .say } (RT 74822)' );

# vim: ft=perl6
