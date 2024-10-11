use Test;
plan 13;

# tests for Match.raku

# the simplest tests are just that it lives, which isn't always the case
# for early implementations. In particular there were some Rakudo
# regressions, like;
# https://github.com/Raku/old-issue-tracker/issues/787
# https://github.com/Raku/old-issue-tracker/issues/931

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

# https://github.com/Raku/old-issue-tracker/issues/918
#?rakudo skip '<foo::bar>'
{
    my $code_str = 'say <OH HAI>';
    $code_str ~~ /<Perl6::Grammar::TOP>/;

    isa-ok $/, Match;
    is $/.ast, $code_str, 'Match.ast is the code matched';
    is $/.Str, $code_str, 'Match.Str is the code matched';
    is-deeply EVAL($/.raku), $/, 'EVAL of Match.raku recreates Match';
}

# https://irclogs.raku.org/raku-beginner/2024-10-11.html#10:10
{
    my $match := "bar\n" ~~ / r\n /;
    lives-ok { $match.say  }, 'can call .say on Match';
    lives-ok { $match.put  }, 'can call .put on Match';
    lives-ok { $match.note }, 'can call .note on Match';
}

# vim: expandtab shiftwidth=4
