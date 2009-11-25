use v6;
use Test;
plan 14;

# L<S32::Containers/junction/!eigenstates>

dies_ok { (1|2).eigenstates }, 'junction doesn\'t have a public .eigenstates';

sub je(Mu $j) {
    return $j!eigenstates.sort.join('|');
}

is je(any(1, 3, 2)), '1|2|3', '!eigenstates on any-junction (sub form)';
is je(3|1|2),        '1|2|3', '!eigenstates on any-junction (operator form)';

is je(all(1, 3, 2)), '1|2|3', '!eigenstates on all-junction (sub form)';
is je(3&1&2),        '1|2|3', '!eigenstates on all-junction (operator form)';

is je(one(1, 3, 2)), '1|2|3', '!eigenstates on one-junction (sub form)';
is je(3^1^2),        '1|2|3', '!eigenstates on one-junction (operator form)';

is je(none(1, 3, 2)), '1|2|3', '!eigenstates on none-junction';

#?rakudo 2 skip '!eigenstates on nested junctions'
is +(1|(2|3))!eigenstates, 3, 'Nested junctions are flattened (count)';
is je(1|(2|3)), '1|2|3', 'Nested junctions are flattened (result)';

# !eigenstates on any non-junction just gives a list of the thing itself
is 42!eigenstates.elems, 1,      'eigenstates on value is list of one item';
is 42!eigenstates[0],    42,     'eigenstates on value is list containing the thingy';
my $x = "pivo";
is $x!eigenstates.elems, 1,      'eigenstates on non-Junction variable is list of one item';
is $x!eigenstates[0],    'pivo', 'eigenstates on non-Junction variable is list containing the thingy';

# vim: ft=perl6
