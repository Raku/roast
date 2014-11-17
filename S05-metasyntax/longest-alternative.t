use v6;
use Test;

plan 31;

#L<S05/Unchanged syntactic features/"While the syntax of | does not change">

my $str = 'a' x 7;

{
    ok $str ~~ m:c(0)/a|aa|aaaa/, 'basic sanity with |';
    is ~$/, 'aaaa', 'Longest alternative wins 1';

    ok $str ~~ m:c(4)/a|aa|aaaa/, 'Second match still works';
    is ~$/, 'aa',   'Longest alternative wins 2';

    ok $str ~~ m:c(6)/a|aa|aaaa/, 'Third match still works';
    is ~$/, 'a',    'Only one alternative left';

    ok $str !~~ m:c(7)/a|aa|aaaa/, 'No fourth match';
}

# now test with different order in the regex - it shouldn't matter at all

#?niecza skip 'Regex modifier g not yet implemented'
{
    ok $str ~~ m:c/aa|a|aaaa/, 'basic sanity with |, different order';
    is ~$/, 'aaaa', 'Longest alternative wins 1, different order';

    ok $str ~~ m:c/aa|a|aaaa/, 'Second match still works, different order';
    is ~$/, 'aa',   'Longest alternative wins 2, different order';

    ok $str ~~ m:c/aa|a|aaaa/, 'Third match still works, different order';
    is ~$/, 'a',    'Only one alternative left, different order';

    ok $str !~~ m:c/aa|a|aaaa/, 'No fourth match, different order';
}

{
    my @list = <a aa aaaa>;
    ok $str ~~ m/ @list /, 'basic sanity with interpolated arrays';
    is ~$/, 'aaaa', 'Longest alternative wins 1';

    ok $str ~~ m:c(4)/ @list /, 'Second match still works';
    is ~$/, 'aa',   'Longest alternative wins 2';

    ok $str ~~ m:c(6)/ @list /, 'Third match still works';
    is ~$/, 'a',    'Only one alternative left';

    ok $str !~~ m:c(7)/ @list /, 'No fourth match';
}

# L<S05/Longest-token matching/>

{
    my token ab { 'ab' };
    my token abb { 'abb' };
    my token a_word { a \w* };
    my token word { \w+ };
    my token indirect_abb { <ab> 'b' }

    #?niecza todo 'LTM - literals in tokens'
    ok ('abb' ~~ /<ab> | <abb> /) && ~$/ eq 'abb',
       'LTM - literals in tokens';

    #?niecza todo 'LTM - literals in nested tokens'
    ok ('abb' ~~ /<ab> | <indirect_abb> /) && $/ eq 'abb',
       'LTM - literals in nested torkens';

    ok ('abb' ~~ /'ab' | \w+ / && $/) eq 'abb',
       'LTM - longer quantified charclass wins against shorter literal';

    #?niecza todo 'LTM - longer quantified atom wins against shorter literal (subrules)'
    ok ('abb' ~~ /<ab> | <a_word> /) && $/ eq 'abb',
       'LTM - longer quantified atom wins against shorter literal (subrules)';

    #?niecza todo 'LTM - literal wins tie against \w*'
    ok ('abb' ~~ / <word> | <abb> /) && $<abb>,
       'LTM - literal wins tie against \w*';
}

#?rakudo skip '::'
{
    # with LTM stoppers
    my token foo1 { 
        a+
        :: # a LTM stopper
        .+
    }
    my token foo2 { \w+ }

    #?niecza todo 'LTM only participated up to the LTM stopper ::'
    ok ('aaab---' ~~ /<foo1> | <foo2> /) && $<foo2>,
       'LTM only participated up to the LTM stopper ::';
}

# LTM stopper by implicit <.ws>
#?niecza todo 'implicit <.ws> stops LTM'
{
    my rule  ltm_ws1 {\w+ '-'+}
    my token ltm_ws2 {\w+ '-'}
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
    ok LTM::T1.parse('aaa---', :actions($o)), 'LTM grammar - matched';
    is ~$/, 'aaa---', 'LTM grammar - matched full string';
    # TODO: find out if $.matched_a is allowed to be set
    ok $o.matched_TOP && $o.matched_b && $o.matched_c,
       'was in the appropriate action methods';
}

# vim: ft=perl6
