use Test;

plan 6;

sub canon($t) {
    $t.tree.map(*.sort).tree
}

# L<S32::Containers/List/=item combinations>

ok(((1,), (2,), (3,)).list     eqv     [1, 2, 3].combinations(1).&canon, "single-item combinations");
ok(all([1, 2], [2, 3], [1, 3]) eqv one([1, 2, 3].combinations(2).&canon), "two item combinations");
ok(([1, 2, 3],).list           eqv     [1, 2, 3].combinations(3).&canon, "three items of a three-item list");

ok(all(1, 2, 3, [1, 2], [2, 3], [1, 3])            eqv one([1, 2, 3].combinations(1..2).&canon), "1..2 items");
ok(all(1, 2, 3, [1, 2], [2, 3], [1, 3], [1, 2, 3]) eqv one([1, 2, 3].combinations(1..3).&canon), "1..3 items");
ok(all([1, 2], [2, 3], [1, 3], [1, 2, 3])          eqv one([1, 2, 3].combinations(2..3).&canon), "2..3 items");
