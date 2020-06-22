use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 6;

{
    my @nums = 1..6;
    is-eqv Any.pairup, ().Seq, 'pairup on a :U invocant returns an empty Seq';
    is-eqv @nums.pairup, (1 => 2, 3 => 4, 5 => 6).Seq,
        'pairup on a :D invocant';
    my %h = @nums.pairup;
    is(@nums.pairup.elems, 3, 'pairup returns correct list size');
    is-deeply(%h.keys.sort, ('1', '3', '5'), 'hash constructed from pairup has correct keys');
    is-deeply(%h.values.sort, (2, 4, 6), 'hash constructed from pairup has correct values');
    @nums.push(7);
    throws-like ｢my @ = @nums.pairup｣, X::Pairup::OddNumber,
        'pairup on odd numbered list size throws';
}

# vim: expandtab shiftwidth=4
