# this test tests that the output (text output and return code) of
# test scripts are correct.

use v6;
use Test;

plan 3;

# RT #115024
{
    use lib 't/spec/packages';
    use Test::Util;
    my $code = 'use Test; my Str $str; is_deeply {b=>2}, {a=>$str, b=>2}, "should not work"';
    is_run $code,
        {
            out    => /^"not ok " \d+ " - should not work"/,
            err    => /"Failed test 'should not work'"/,
            status => { $_ != 0 },
        },
        'expected output with failing test "is_deeply"';
    $code = 'use Test; my Str $str; is_deeply {a=>$str, b=>2}, {a=>$str, b=>2}, "should work"';
    is_run $code,
        {
            out    => /^"ok " \d+ " - should work"/,
            err    => "",
            status => 0,
        },
        'expected output with passing test "is_deeply"';
}

skip_rest("skipping because redirection is not portable"); exit;

# this test tests that various failure conditions (that we don't want
# to show up as failures) happen, and test the the output of the test
# suite is correct.

# ... copied from t/run/05-unknown-option.t, but it looks wrong :)
sub nonce () { return (".{$*PID}." ~ (1..1000).pick) }
my $out_fn = "temp-ex-output" ~ nonce;
my $redir_pre = "2>&1 >";
my $redir_post = "2>&1";
if $*OS eq any <MSWin32 mingw msys cygwin> {
    $redir_pre = ">";
    $redir_post = "";
};

my $file = $?FILE;
$file ~~ s:P5/output.t/script.pl/;
my $cmd = "$*EXECUTABLE_NAME $file $redir_pre $out_fn $redir_post";
%*ENV<TEST_ALWAYS_CALLER> = 0;

diag($cmd);
run($cmd);

my $output = slurp $out_fn;
unlink($out_fn);

is($output, "1..1
ok 1 - TODO that passes # TODO
# Looks like 1 tests of 1 passed unexpectedly
", "got correct output");

# vim: expandtab shiftwidth=4 ft=perl6
