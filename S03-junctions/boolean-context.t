use v6;
use Test;
plan 38;

# L<S03/Junctive operators/>

ok ?any(1..2), 'any(1..2) in boolean context';
ok !(any(0,0)), 'any(0,0) in boolean context';
ok !(one(1..2)), 'one(1..2) in boolean context';
ok ?(1|2), '1|2 in boolean context';
ok !(1^2), '1^2 in boolean context';
ok !(undef|0), 'undef|0 in boolean context';
ok !(undef|undef), 'undef|undef in boolean context';
ok !(undef), 'undef in boolean context';
ok !(defined undef), 'defined undef in boolean context';
ok !(all(undef, undef)), 'all(undef, undef) in boolean context';
ok ?all(1,1), 'all(1,1) in boolean context';
ok !(all(1,undef)), 'all(1,undef) in boolean context';

ok ?(1 | undef), '1|undef in boolean context';
ok ?(undef | 1), 'undef|1 in boolean context';
ok !(1 & undef), '1&undef in boolean context';
ok !(undef & 1), 'undef&1 in boolean context';
ok ?(1 ^ undef), '1^undef in boolean context';
ok ?(undef ^ 1), 'undef^1 in boolean context';

ok ?(-1 | undef), '-1|undef in boolean context';
ok ?(undef | -1), 'undef|-1 in boolean context';
ok !(-1 & undef), '-1&undef in boolean context';
ok !(undef & -1), 'undef&-1 in boolean context';
ok ?(-1 ^ undef), '-1^undef in boolean context';
ok ?(undef ^ -1), 'undef^-1 in boolean context';

(1|undef && pass '1|undef in boolean context') || flunk '1|undef in boolean context';
#?rakudo skip 'Junctions and short-circituing operators'
#?DOES 1
{
(1 & undef && flunk '1&undef in boolean context') || pass '1&undef in boolean context';
}
(1^undef && pass '1^undef in boolean context') || flunk '1^undef in boolean context';

ok !(0 | undef), '0|undef in boolean context';
ok !(undef | 0), 'undef|0 in boolean context';
ok !(0 & undef), '0&undef in boolean context';
ok !(undef & 0), 'undef&0 in boolean context';
ok !(0 ^ undef), '0^undef in boolean context';
ok !(undef ^ 0), 'undef^0 in boolean context';

# this can in principle be TODOed, but fudge doesn't understand the test
# format
#?rakudo skip 'Junctions and short-circuiting operators'
#?DOES 3
{
    (0 | undef && flunk '0|undef in boolean context') || pass '0|undef in boolean context';
    (0 & undef && flunk '0&undef in boolean context') || pass '0&undef in boolean context';
    (0 ^ undef && flunk '0^undef in boolean context') || pass '0^undef in boolean context';
}

ok 0|undef == 0, '0|undef == 0 in boolean context';
