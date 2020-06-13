use v6;
use Test;

plan 1;

# https://github.com/rakudo/rakudo/commit/dd4dfb14d3
is-deeply (quietly IO::Special.Str), '', 'IO::Special:U.Str does not crash';

# vim: expandtab shiftwidth=4
