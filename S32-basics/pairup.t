use v6;

use Test;

plan 4;

{
    is-deeply Any.pairup(), (), 'pairup on an undefined invocant returns an empty list';
    my @nums = 1..6;
    my %h = @nums.pairup;
    is(@nums.pairup.elems, 3, 'pairup returns correct list size');
    is-deeply(%h.keys.sort, ('1', '3', '5'), 'pairup returns correct keys');
    is-deeply(%h.values.sort, (2, 4, 6), 'pairup returns correct values');
}

# vim: ft=perl6
