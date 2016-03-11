# check output (text output and return code) of tests

use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 4;

# RT #115024
{
    my $code = 'use Test; my Str $str; is-deeply {b=>2}, {a=>$str, b=>2}, "should not work"';
    is_run $code,
        {
            out    => /^"not ok " \d+ " - should not work"/,
            err    => /"Failed test 'should not work'"/,
            status => { $_ != 0 },
        },
        'expected output with failing test "is-deeply"';
    $code = 'use Test; my Str $str; is-deeply {a=>$str, b=>2}, {a=>$str, b=>2}, "should work"';
    is_run $code,
        {
            out    => /^"ok " \d+ " - should work"/,
            err    => "",
            status => 0,
        },
        'expected output with passing test "is-deeply"';
}

# RT #77650
{
    is_run
        'use Test; eval-lives-ok q[foo<bar], "expected eval fail"',
        {
            out    => /'not ok ' \d+ ' - expected eval fail'/,
            err    => /'# Error: Unable to parse'/,
            status => { $_ != 0 },
        },
        'eval error via diag';
}

my $test-file = 't/spec/S24-testing/test-data/todo-passed.txt';
my $cmd = "$*EXECUTABLE $test-file 2>&1";
ok qqx[$cmd] ~~ /^"1..1" \n "ok 1 - test passes# TODO testing output for passing todo test" \n $ /,
    "expected output with passing todo test";

# vim: expandtab shiftwidth=4 ft=perl6
