use v6;

use Test;

plan 5;

{
    is-deeply Any.pairup(), (), 'pairup on an undefined invocant returns an empty list';
    my @nums = 1..6;
    my %h = @nums.pairup;
    is(@nums.pairup.elems, 3, 'pairup returns correct list size');
    is-deeply(%h.keys.sort, ('1', '3', '5'), 'hash constructed from pairup has correct keys');
    is-deeply(%h.values.sort, (2, 4, 6), 'hash constructed from pairup has correct values');
    @nums.push(7);
    throws-like ｢my @ = @nums.pairup｣, X::Pairup::OddNumber,
        'pairup on odd numbered list size throws';
}

# vim: ft=perl6
