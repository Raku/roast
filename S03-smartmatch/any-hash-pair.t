use v6;
use Test;
plan 7;

#L<S03/Smart matching/Hash Pair test hash mapping>
{
    my %a = (a => 1, b => 'foo', c => Mu);
    ok  (%a ~~ b => 'foo'),         '%hash ~~ Pair (Str, +)';
    ok !(%a ~~ b => 'ugh'),         '%hash ~~ Pair (Str, -)';
    ok  (%a ~~ a => 1.0),           '%hash ~~ Pair (Num, +)';
    ok  (%a ~~ :b<foo>),            '%hash ~~ Colonpair';
    #?rakudo 2 todo 'nom regression'
    ok  (%a ~~ c => !*.defined),    '%hash ~~ Pair (!*.defined, Mu)';
    ok  (%a ~~ d => !*.defined),    '%hash ~~ Pair (!*.defined, Nil)';
    ok !(%a ~~ a => 'foo'),         '%hash ~~ Pair (key and val not paired)';
}

done;

# vim: ft=perl6
