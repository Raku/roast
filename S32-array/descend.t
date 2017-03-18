use v6;
use Test;

plan 2;

{
    my @a = [1,[2,[3]]];
    ok descend(@a) eqv (1, 2, 3).Seq, 'descend returns flat Seq';
    ok @a.descend  eqv (1, 2, 3).Seq, 'method descend returns flat Seq';
}

# vim: ft=perl6
