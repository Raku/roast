use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;
plan 60;

# RT #117841
for 1..12 -> $x {
    for map { 2**$x - 1 }, ^5 {
        ok( get_out("say 1 x $_,q|—|", '')<out> ~~ /^1+\—\s*$/, "Test for $_ bytes + utf8 char");
    }
}
