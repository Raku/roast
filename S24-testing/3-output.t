# check output (text output and return code) of tests

use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 6;

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
ok qqx[$cmd] ~~ /^"1..1" \n "ok 1 - test passes" \s* "# TODO testing output for passing todo test" \n $ /,
    "expected output with passing todo test";

# https://irclog.perlgeek.de/perl6/2017-08-18#i_15038239
is_run ｢
        use Test;
        plan 2;
        ok 1, "foo\nbar";
        subtest "meow" => { ok 1, "mass\nbass\nmiss\nbiss" }
    ｣,
    { :err(''), :0status,  :out("1..2\nok 1 - foo\n# bar\n    ok 1 - mass\n"
        ~ "    # bass\n    # miss\n    # biss\n    1..1\nok 2 - meow\n") },
'descriptions with newlines get escaped from TAP with `#` at start of line';

# https://irclog.perlgeek.de/perl6/2017-08-18#i_15038473
is_run ｢
        use Test;
        plan 2;
        skip "meow # moo", 1;
        skip 1;
    ｣,
    { :err(''), :0status,  :out("1..2\nok 1 - # SKIP meow  \\# moo"
        ~ "\nok 2 - # SKIP 1\n") },
'skip() escapes `#` but not the `#` of SKIP marker itself';

# vim: expandtab shiftwidth=4 ft=perl6
