use v6.c;
use Test;
plan 10;

# tests for Match.perl

# the simplest tests are just that it lives, which isn't always the case
# for early implementations. In particular there were some Rakudo 
# regressions, like RT #63904 and RT #64944	

grammar ExprT1 {
    rule TOP { ^ \d+ [ <operator> \d+ ]* }
    token operator { '/' | '*' | '+' | '-' };
};

my $m = ExprT1.parse('2 + 4');
ok $m, 'Regex matches (1)';
lives-ok { $m.perl }, '$/.perl lives (with named captures';
#?niecza skip 'No value for parameter $a in is-deeply'
is-deeply EVAL($m.perl), $m, '... and it reproduces the right thing (1)'; 
#?niecza todo 'empty result'
#?rakudo skip 'RT #125293 - .perl does not roundtrip as expected - operator is null'
is ~EVAL($m.perl).<operator>, '+', ' right result (2)';

my regex f { f };
my regex o { o };
ok "foo" ~~ /<f=&f> <o=&o>+ /, 'Regex matches (2)';
lives-ok { $/.perl }, 'lives on quantified named captures';

# RT #64874
#?rakudo skip '<foo::bar> RT #124745'
#?niecza skip 'Cannot dispatch to a method on GLOBAL::Perl6::Grammar'
{
    my $code_str = 'say <OH HAI>';
    $code_str ~~ /<Perl6::Grammar::TOP>/;

    isa-ok $/, Match;
    is $/.ast, $code_str, 'Match.ast is the code matched';
    is $/.Str, $code_str, 'Match.Str is the code matched';
    is-deeply EVAL($/.perl), $/, 'EVAL of Match.perl recreates Match';
}

# vim: ft=perl6
