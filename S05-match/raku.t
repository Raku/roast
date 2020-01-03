use v6;
use Test;
plan 10;

# tests for Match.raku

# the simplest tests are just that it lives, which isn't always the case
# for early implementations. In particular there were some Rakudo
# regressions, like RT #63904 and RT #64944

grammar ExprT1 {
    rule TOP { ^ \d+ [ <operator> \d+ ]* }
    token operator { '/' | '*' | '+' | '-' };
};

my $m = ExprT1.parse('2 + 4');
ok $m, 'Regex matches (1)';
lives-ok { $m.raku }, '$/.raku lives (with named captures';
is-deeply EVAL($m.raku), $m, '... and it reproduces the right thing (1)';
is ~EVAL($m.raku).<operator>, '+', ' right result (2)';

my regex f { f };
my regex o { o };
ok "foo" ~~ /<f=&f> <o=&o>+ /, 'Regex matches (2)';
lives-ok { $/.raku }, 'lives on quantified named captures';

# RT #64874
#?rakudo skip '<foo::bar>'
{
    my $code_str = 'say <OH HAI>';
    $code_str ~~ /<Perl6::Grammar::TOP>/;

    isa-ok $/, Match;
    is $/.ast, $code_str, 'Match.ast is the code matched';
    is $/.Str, $code_str, 'Match.Str is the code matched';
    is-deeply EVAL($/.raku), $/, 'EVAL of Match.raku recreates Match';
}

# vim: ft=perl6
