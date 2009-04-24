use v6;
use Test;
plan 6;

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
lives_ok { $m.perl }, '$/.perl lives (with named captures';
#?rakudo 2 skip 'eval()ing Match.perl'
is_deeply eval($m.perl), $m, '... and it reproduces the right thing (1)'; 
is ~eval($m.perl).<operator>, '+', ' right result (2)';

regex f { f };
regex o { o };
ok "foo" ~~ /<f> <o>+ /, 'Regex matches (2)';
lives_ok { $/.perl }, 'lives on quantified named captures';


# vim: ft=perl6
