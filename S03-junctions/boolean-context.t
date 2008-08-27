use v6;
use Test;
plan 37;

# L<S03/Junctive Operators/>

ok any(1..2), 'any(1..2) in boolean context';
ok !(any(0,0)), 'any(0,0) in boolean context';
ok !(one(1..2)), 'one(1..2) in boolean context';
ok 1|2, '1|2 in boolean context';
ok !(1^2), '1^2 in boolean context';
ok !(undef|0), 'undef|0 in boolean context';
ok !(undef|undef), 'undef|undef in boolean context';
ok !(undef), 'undef in boolean context';
ok !(defined undef), 'defined undef in boolean context';
ok !(all(undef, undef)), 'all(undef, undef) in boolean context';
ok all(1,1), 'all(1,1) in boolean context';
ok !(all(1,undef)), 'all(1,undef) in boolean context';

ok 1|undef, '1|undef in boolean context';
ok undef|1, 'undef|1 in boolean context';
ok !(1&undef), '1&undef in boolean context';
ok !(undef&1), 'undef&1 in boolean context';
ok 1^undef, '1^undef in boolean context';
ok undef^1, 'undef^1 in boolean context';

ok -1|undef, '-1|undef in boolean context';
ok undef|-1, 'undef|-1 in boolean context';
ok !(-1&undef), '-1&undef in boolean context';
ok !(undef&-1), 'undef&-1 in boolean context';
ok -1^undef, '-1^undef in boolean context';
ok undef^-1, 'undef^-1 in boolean context';

(1|undef && pass '1|undef in boolean context') || fail '1|undef in boolean context';
(1 & undef && fail '1&undef in boolean context') || pass '1&undef in boolean context';
(1^undef && pass '1^undef in boolean context') || fail '1^undef in boolean context';

ok !(0|undef), '0|undef in boolean context';
ok !(undef|0), 'undef|0 in boolean context';
ok !(0&undef), '0&undef in boolean context';
ok !(undef&0), 'undef&0 in boolean context';
ok !(0^undef), '0^undef in boolean context';
ok !(undef^0), 'undef^0 in boolean context';

(0 | undef && fail '0|undef in boolean context') || pass '0|undef in boolean context';;
(0 & undef && fail '0&undef in boolean context') || pass '0&undef in boolean context';;
(0 ^ undef && fail '0^undef in boolean context') || pass '0^undef in boolean context';;

ok 0|undef == 0, '0|undef == 0 in boolean context';
