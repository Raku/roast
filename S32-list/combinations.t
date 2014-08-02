use Test;

plan 6;

# L<S32::Containers/List/=item combinations>

ok [1, 2, 3].combinations(1) »eqv« ([1], [2], [3]), "single-item combinations";
ok [1, 2, 3].combinations(2) »eqv« ([1, 2], [2, 3], [1, 3]), "two item combinations";
ok [1, 2, 3].combinations(3) »eqv« ([1,2,3],), "three items of a three-item list";

ok [1, 2, 3].combinations(1..2) »eqv« ([1], [2], [3], [1, 2], [2, 3], [1, 3]), "1..2 items";
ok [1, 2, 3].combinations(1..3) »eqv« ([1], [2], [3], [1, 2], [2, 3], [1, 3], [1, 2, 3]), "1..3 items";
ok [1, 2, 3].combinations(2..3) »eqv« ([1, 2], [2, 3], [1, 3], [1, 2, 3]), "2..3 items";
