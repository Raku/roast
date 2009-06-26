use v6;
use Test;

plan 31;

#L<S05/Unchanged syntactic features/"While the syntax of | does not change">

my $str = 'a' x 7;

#?rakudo skip ':g'
{
    ok $str ~~ m:g/a|aa|aaaa/, 'basic sanity with |';
    is ~$/, 'aaaa', 'Longest alternative wins 1';

    ok $str ~~ m:g/a|aa|aaaa/, 'Second match still works';
    is ~$/, 'aa',   'Longest alternative wins 2';

    ok $str ~~ m:g/a|aa|aaaa/, 'Third match still works';
    is ~$/, 'a',    'Only one alternative left';

    ok $str !~~ m:g/a|aa|aaaa/, 'No fourth match';
}

# now test with different order in the regex - it shouldn't matter at all

#?rakudo skip ':g'
{
    ok $str ~~ m:g/aa|a|aaaa/, 'basic sanity with |, different order';
    is ~$/, 'aaaa', 'Longest alternative wins 1, different order';

    ok $str ~~ m:g/aa|a|aaaa/, 'Second match still works, different order';
    is ~$/, 'aa',   'Longest alternative wins 2, different order';

    ok $str ~~ m:g/aa|a|aaaa/, 'Third match still works, different order';
    is ~$/, 'a',    'Only one alternative left, different order';

    ok $str !~~ m:g/aa|a|aaaa/, 'No fourth match, different order';
}

#?rakudo skip 'interpolation in regexes'
{
    my @list = <a aa aaaa>;
    ok $str ~~ m:g/ @list /, 'basic sanity with interpolated arrays';
    is ~$/, 'aaaa', 'Longest alternative wins 1';

    ok $str ~~ m:g/ @list /, 'Second match still works';
    is ~$/, 'aa',   'Longest alternative wins 2';

    ok $str ~~ m:g/ @list /, 'Third match still works';
    is ~$/, 'a',    'Only one alternative left';

    ok $str !~~ m:g/ @list /, 'No fourth match';
}

# L<S05/Longest-token matching/>

{
    token ab { 'ab' };
    token abb { 'abb' };
    token a_word { a \w* };
    token word { \w+ };
    token a_star { a* };
    token indirect_abb { <ab> 'b' }

    ok ('abb' ~~ /<ab> | <abb> /) && ~$/ eq 'abb',
       'LTM - literals in tokens';

    ok ('abb' ~~ /<ab> | <indirect_abb> /) && $/ eq 'abb',
       'LTM - literals in nested torkens';

    ok ('abb' ~~ /'ab' | \w+ / && $/) eq 'abb',
       'LTM - longer quantified charclass wins against shorter literal';

    ok ('abb' ~~ /<ab> | <a_word> /) && $/ eq 'abb',
       'LTM - longer quantified atom wins against shorter literal (subrules)';

    ok ('abb' ~~ / <abb> | <word> /) && $<abb>,
       'LTM - literal wins tie against \w*';

    # with LTM stoppers
    token foo1 { 
        a+
        ::: # a LTM stopper
        .+
    }
    token foo2 { \w+ }

    ok ('aaab---' ~~ /<foo1> | <foo2> /) && $<foo2>,
       'LTM only participated up to the LTM stopper :::';
}

# LTM stopper by implicit <.ws>
{
    rule  ltm_ws1 {\w+ '-'+}
    token ltm_ws2 {\w+ '-'}
    ok ('abc---' ~~ /<ltm_ws1> | <ltm_ws2>/) && $<ltm_ws2>,
       'implicit <.ws> stops LTM';
}

{
    # check that the execution of action methods doesn't stop LTM
    grammar LTM::T1 {
        token TOP { <a> | <b> }
        token a { \w+ '-' }
        token b { a+ <c>+ }
        token c { '-' }
    }

    class LTM::T1::Action {
        has $.matched_TOP;
        has $.matched_a;
        has $.matched_b;
        has $.matched_c;
        method TOP($/) { $!matched_TOP = 1 };
        method a($/)   { $!matched_a   = 1 };
        method b($/)   { $!matched_b   = 1 };
        method c($/)   { $!matched_c   = 1 };
    }
    my $o = LTM::T1::Action.new();
    ok LTM::T1.parse('aaa---', :action($o)), 'LTM grammar - matched';
    is ~$/, 'aaa---', 'LTM grammar - matched full string';
    # TODO: find out if $.matched_a is allowed to be set
    ok $o.matched_TOP && $o.matched_b && $o.matched_c,
       'was in the appropriate action methods';
}

# vim: ft=perl6
