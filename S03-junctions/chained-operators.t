use v6;

use Test;

# Tests that (1|2|3) is the same as any(1,2,3).
# (Test primarily aimed at all backends which use PIL1 --
# (1|2|3) was treated as (1|(2|3)).)

plan 7;

is +any(1,2,3).eigenstates, 3;
is +(1 | 2 | 3).eigenstates, 3;

is +all(1,2,3).eigenstates, 3;
is +(1 & 2 & 3).eigenstates, 3;

is +one(1,2,3).eigenstates, 3;
is +(1 ^ 2 ^ 3).eigenstates, 3;

is +none(1,2,3).eigenstates, 3;
