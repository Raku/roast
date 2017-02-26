use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;
plan 61;

# RT #117841
for 1..12 -> $x {
    for map { 2**$x - 1 }, ^5 {
        ok( get_out("say 1 x $_,q|—|", '')<out> ~~ /^1+\—\s*$/, "Test for $_ bytes + utf8 char");
    }
}

# https://github.com/rakudo/rakudo/commit/dd4dfb14d3
lives-ok { quietly IO::Special.Str }, 'IO::Special:U.Str does not crash';
