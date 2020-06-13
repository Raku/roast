use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 4;

is-eqv ^10 .batch(3),  ((0, 1, 2), (3, 4, 5), (6, 7, 8), (9,)).Seq, '.batch(3)';
is-eqv ^10 .batch(20), ((0, 1, 2, 3, 4, 5, 6, 7, 8, 9,),).Seq, '.batch(20)';
is-eqv ^10 .batch(1),
  ((0,), (1,), (2,), (3,), (4,), (5,), (6,), (7,), (8,), (9,)).Seq, '.batch(1)';

throws-like { ^10 .batch(0) }, X::OutOfRange, got => 0,
    'does 0 as batch-size throw';

# vim: expandtab shiftwidth=4
