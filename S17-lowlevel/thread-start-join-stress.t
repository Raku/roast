use v6;
use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/4506
for ^1000 { Thread.start(-> {}).join; }
pass "Can start/join 1000 threads without running out of handles, etc.";

# vim: expandtab shiftwidth=4
