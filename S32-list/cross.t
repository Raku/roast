use v6;


use Test;

plan 2;

# most of the tests for this are done in the S03-metaops/cross.t
# will just test the interface here;

is-deeply cross(<a b>, <1 2>), (<a 1>, <a 2>, <b 1>, <b 2>), "plain cross";
is-deeply cross(<a b>, <1 2>, with => &[~]), <a1 a2 b1 b2>, "cross with operator";


# vim: expandtab shiftwidth=4 ft=perl6
