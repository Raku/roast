use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/pos.t.

=end pod

plan 12;

#?pugs emit force_todo(2,4,6,8,9);

my $str = "abrAcadAbbra";

ok($str ~~ m/ a .+ A /, 'Match from start');
is($/.from , 0,        'Match.from is 0');
is($/.to   , 8,        'Match.to is 7');
is($/.chars, 8,        'Match.chars');

ok($str ~~ m/ A .+ a /, 'Match from 3');
ok($/.from == 3,        'Match.from is 3');

ok($str !~~ m/ Z .+ a /, 'No match');
#?rakudo skip 'unspecced'
#?niecza skip 'System.InvalidCastException: Cannot cast from source type to destination type.'
nok($/.from.defined,      'Match pos is undefined');

my regex Aa { A .* a }
#?rakudo 3 skip 'lexical lookup of <Aa>'
ok($str ~~ m/ .*? <Aa> /, 'Subrule match from 3');
ok($/.from == 0,          'Full match pos is 0');
ok($/<Aa>.from == 3,      'Subrule match pos is 3');


# RT #74694 - Rakudo's failed match objects had negative .chars
is ('abc' ~~ /\d+/).chars, 0, 'Failed matches 0 .chars';

# vim: ft=perl6
