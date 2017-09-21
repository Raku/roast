use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/pos.t.

=end pod

plan 13;

my $str = "abrAcadAbbra";

ok($str ~~ m/ a .+ A /, 'Match from start');
is($/.from , 0,        'Match.from is 0');
is($/.to   , 8,        'Match.to is 7');
is($/.chars, 8,        'Match.chars');

ok($str ~~ m/ A .+ a /, 'Match from 3');
ok($/.from == 3,        'Match.from is 3');

my regex Aa { A .* a }
ok($str ~~ m/ .*? <Aa> /, 'Subrule match from 3');
ok($/.from == 0,          'Full match pos is 0');
ok($/<Aa>.from == 3,      'Subrule match pos is 3');

is ('abc' ~~ /\d+/), Nil, 'Failed match returns Nil';

{ # coverage; 2016-10-11
    'abc123def' ~~ m:g/\d/;
    is-deeply $/.from, 3, 'List.from';
    is-deeply $/.to,   6, 'List.to';
}

# RT #126249
subtest '$/ is constructed in all blocks inside regexes' => {
    plan 2;
    my @res;
    my token foo {
            { @res.push: $/.to }
        abc { @res.push: $/.to }
        123 { @res.push: $/.to }
    };
    ok "abc123" ~~ /<foo>/, 'regex matched';
    is-deeply @res, [0, 3, 6], 'blocks returned correct $/.to values';
}

# vim: ft=perl6
