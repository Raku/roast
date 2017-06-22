use v6;


use Test;

plan 3;

# most of the tests for this are done in the S03-metaops/cross.t
# will just test the interface here;

is-deeply cross(<a b>, <1 2>), (<a 1>, <a 2>, <b 1>, <b 2>), "plain cross";
is-deeply cross(<a b>, <1 2>, with => &[~]), <a1 a2 b1 b2>, "cross with operator";

# RT 126508
eval-lives-ok 'multi sub cross() { }', "multi sub cross shouldn't SEGV";

# vim: expandtab shiftwidth=4 ft=perl6
