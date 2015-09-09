use v6;
use Test;

plan 1;

# RT #125977
for ^1000 { Thread.start(-> {}).join; }
pass "Can start/join 1000 threads without running out of handles, etc.";
