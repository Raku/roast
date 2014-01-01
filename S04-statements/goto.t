use v6;
use Test;
plan 13;

# L<S04/"The goto statement">

=begin description

Tests for the goto() builtin

We have "phases" to make sure the gotos didn't run wild.

=end description


our $phase;

sub test1_ok { return 1 }
sub test1 {
    &test1_ok.nextwith();
    return 0;
}
ok(test1(), "&sub.nextwith does");
is(++$phase, 1, "phase completed");

# the same, but with subs declared after the call.

sub test2 {
    &test2_ok.nextwith();
    return 0;
}
sub test2_ok { return 1 }
ok(test2(), "&sub.nextwith does (forward reference)");
is(++$phase, 2, "phase completed");

ok(test3(), "&sub.nextwith does (real forward reference)");
sub test3 {
    &test3_ok.nextwith();
    return 0;
}
sub test3_ok { 1 }
is(++$phase, 3, "phase completed");

is(moose(), $?LINE, "regular call to moose() is consistent");
is(foo(), $?LINE, "goto eliminates call stack frames");

sub foo {
    &moose.nextwith();
}

sub moose {
    $?CALLER::LINE;
}

is(++$phase, 4, "phase completed");

# Simple test case to get support for goto LABEL in pugs
# Source for the syntax: S06 "The leave function"
# > last COUNT;

our $test5 = 1;
EVAL q{ goto SKIP5; };
$test5 = 0;
SKIP5:
#?pugs todo 'feature'
is($test5, 1, "goto label");

is(++$phase, 5, "phase completed");

# this one tests "goto EXPR" syntax. pugs treats "last EXPR" as "last;" in r14915.

our $test6 = 1;
EVAL q{ goto 'SK' ~ 'IP6'; };
$test6 = 0;
SKIP6:
#?pugs todo 'feature'
is($test6, 1, "goto expr");

is(++$phase, 6, "phase completed");

# vim: ft=perl6
