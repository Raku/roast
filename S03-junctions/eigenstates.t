use v6;
use Test;
plan 9;

# L<S29/Junction/eigenstates>

sub je(Object $j) {
    return $j.eigenstates.sort.join('|');
}

is je(any(1, 3, 2)), '1|2|3', '.eigenstates on any-junction (sub form)';
is je(3|1|2),        '1|2|3', '.eigenstates on any-junction (operator form)';

is je(all(1, 3, 2)), '1|2|3', '.eigenstates on all-junction (sub form)';
is je(3&1&2),        '1|2|3', '.eigenstates on all-junction (operator form)';

is je(one(1, 3, 2)), '1|2|3', '.eigenstates on one-junction (sub form)';
is je(3^1^2),        '1|2|3', '.eigenstates on one-junction (operator form)';

is je(none(1, 3, 2)), '1|2|3', '.eigenstates on none-junction';

#?rakudo 2 skip '.eigenstates on nested junctions'
is +(1|(2|3)).eigenstates, 3, 'Nested junctions are flattened (count)';
is je(1|(2|3)), '1|2|3', 'Nested junctions are flattened (result)';

# vim: ft=perl6
