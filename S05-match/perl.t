use v6;
use Test;
plan 12;

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

my regex f { f };
my regex o { o };
ok "foo" ~~ /<f=&f> <o=&o>+ /, 'Regex matches (2)';
lives_ok { $/.perl }, 'lives on quantified named captures';

# RT #64874
#?rakudo skip '<foo::bar>'
{
    my $code_str = 'say <OH HAI>';
    $code_str ~~ /<Perl6::Grammar::TOP>/;

    isa_ok $/, Match;
    is $/.ast, $code_str, 'Match.ast is the code matched';
    is $/.Str, $code_str, 'Match.Str is the code matched';
    #?rakudo skip 'RT #64874'
    is_deeply eval($/.perl), $/, 'eval of Match.perl recreates Match';
}

# RT #65610
{
    my $m = 'foo' ~~ /foo/;
    eval '$m<greeting> = "OH HAI"';

    ok  $!  ~~ Exception, 'die before modifying a Match';
    #?rakudo skip 'RT #65610'
    is_deeply eval($m.perl), $m, 'Match.perl works after attempt to modify';
}

# vim: ft=perl6
