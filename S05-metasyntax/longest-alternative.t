use v6;
use Test;

plan 41;

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

# various discovered longlit failure modes

{
    my $m = 'abc' ~~ / abc | 'def' 'ine' /;
    ok $m, "longer non-matcher parses";
    is $m.Str, "abc", "longer non-matching literal doesn't falsify shorter";
}

{
    grammar Galt {
        token TOP { <foo> | <bar> }
        token foo { \w\w }
        token bar { aa | <foo> }
    }
    my $m = Galt.subparse('bb');
    ok $m, "Galt parses";
    is $m<foo>.Str, 'bb', "literal from non-matching alternating subrule doesn't interfere";
}

{
    grammar Gproto {
        proto token TOP {*}
        multi token TOP:sym<foo> { <foo> }
        multi token TOP:sym<bar> { <bar> }

        token foo { \w\w }

        proto token bar {*}
        multi token bar:sym<foo> { <foo> }
        multi token bar:sym<aa>  { aa }
    }

    my $m = Gproto.subparse('bb');
    ok $m, "Gproto parses";
    is $m<foo>.Str, 'bb', "literal from non-matching proto subrule doesn't interfere";
}

{
    my $m = 'abcbarxyz' ~~ / abcbarx | abc [ foo | bar ] xyz /;
    ok $m, "subrule alternation with recombo matches";
    is $m.Str, 'abcbarxyz', "subrule alternation recombination doesn't confuse fates";
}

{
    grammar IETF::RFC_Grammar::IPv6 {
        token IPv6address       {
                                                    [ <.h16> ':' ] ** 6 <.ls32> |
                                               '::' [ <.h16> ':' ] ** 5 <.ls32> |
            [                        <.h16> ]? '::' [ <.h16> ':' ] ** 4 <.ls32> |
            [ [ <.sep_h16> ]?        <.h16> ]? '::' [ <.h16> ':' ] ** 3 <.ls32> |
            [ [ <.sep_h16> ] ** 0..2 <.h16> ]? '::' [ <.h16> ':' ] ** 2 <.ls32> |        
            [ [ <.sep_h16> ] ** 0..3 <.h16> ]? '::' <.h16> ':'          <.ls32> |
            [ [ <.sep_h16> ] ** 0..4 <.h16> ]? '::'                     <.ls32> |
            [ [ <.sep_h16> ] ** 0..5 <.h16> ]? '::'                     <.h16>  |
            [ [ <.sep_h16> ] ** 0..6 <.h16> ]? '::'                                      
        };

        # token avoiding backtracking happiness    
        token sep_h16           { [ <.h16> ':' <!before ':'>] }

        token ls32              { [<.h16> ':' <.h16>] | <.IPv4address> };
        token h16               { <.xdigit> ** 1..4 };
        
        token IPv4address       {
            <.dec_octet> '.' <.dec_octet> '.' <.dec_octet> '.' <.dec_octet>
        };
        
        token dec_octet         {
            '25' <[0..5]>           |   # 250 - 255
            '2' <[0..4]> <.digit>   |   # 200 - 249
            '1' <.digit> ** 2       |   # 100 - 199
            <[1..9]> <.digit>       |   # 10 - 99
            <.digit>                    # 0 - 9
        }
    }

    grammar IETF::RFC_Grammar::URI is IETF::RFC_Grammar::IPv6 {
        token TOP               { <URI_reference> };
        token TOP_non_empty     { <URI> | <relative_ref_non_empty> };
        token TOP_validating    { ^ <URI_reference> $ };
        token URI_reference     { <URI> | <relative_ref> };

        token absolute_URI      { <scheme> ':' <.hier_part> [ '?' query ]? };

        token relative_ref      {
            <relative_part> [ '?' <query> ]? [ '#' <fragment> ]?
        };
        token relative_part     {
            '//' <authority> <path_abempty>     |
            <path_absolute>                     |
            <path_noscheme>                     |
            <path_empty>
        };

        token relative_ref_non_empty      {
            <relative_part_non_empty> [ '?' <query> ]? [ '#' <fragment> ]?
        };
        token relative_part_non_empty     {
            '//' <authority> <path_abempty>     |
            <path_absolute>                     |
            <path_noscheme>                     
        };

        token URI               {
            <scheme> ':' <hier_part> ['?' <query> ]?  [ '#' <fragment> ]?
        };

        token hier_part     {
            '//' <authority> <path_abempty>     |
            <path_absolute>                     |
            <path_rootless>                     |
            <path_empty>
        };

        token scheme            { <.uri_alpha> <[\-+.] +uri_alpha +digit>* };
        
        token authority         { [ <userinfo> '@' ]? <host> [ ':' <port> ]? };
        token userinfo          {
            [ ':' | <likely_userinfo_component> ]*
        };
        # the rfc refers to username:password as deprecated
        token likely_userinfo_component {
            <+unreserved +sub_delims>+ | <.pct_encoded>+
        };
        token host              { <IPv4address> | <IP_literal> | <reg_name> };
        token port              { <.digit>* };

        token IP_literal        { '[' [ <IPv6address> | <IPvFuture> ] ']' };
        token IPvFuture         {
            'v' <.xdigit>+ '.' <[:] +unreserved +sub_delims>+
        };
        token reg_name          { [ <+unreserved +sub_delims> | <.pct_encoded> ]* };

        token path_abempty      { [ '/' <segment> ]* };
        token path_absolute     { '/' [ <segment_nz> [ '/' <segment> ]* ]? };
        token path_noscheme     { <segment_nz_nc> [ '/' <segment> ]* };
        token path_rootless     { <segment_nz> [ '/' <segment> ]* };
        token path_empty        { <.pchar> ** 0 }; # yes - zero characters

        token   segment         { <.pchar>* };
        token   segment_nz      { <.pchar>+ };
        token   segment_nz_nc   { [ <+unenc_pchar - [:]> | <.pct_encoded> ] + };

        token query             { <.fragment> };
        token fragment          { [ <[/?] +unenc_pchar> | <.pct_encoded> ]* };

        token pchar             { <.unenc_pchar> | <.pct_encoded> };
        token unenc_pchar       { <[:@] +unreserved +sub_delims> };

        token pct_encoded       { '%' <.xdigit> <.xdigit> };

        token unreserved        { <[\-._~] +uri_alphanum> };

        token reserved          { <+gen_delims +sub_delims> };

        token gen_delims        { <[:/?\#\[\]@]> };
        token sub_delims        { <[;!$&'()*+,=]> };

        token uri_alphanum      { <+uri_alpha +digit> };   
        token uri_alpha         { <[A..Za..z]> };
    }

    my $m = IETF::RFC_Grammar::URI.subparse('http://example.com:80/about/us?foo#bar');
    ok $m, "IETF::RFC_Grammar::URI matches";
    is $m.gist, q:to/END/.subst("\r", "", :g).chop, "IETF::RFC_Grammar::URI gets ltm and longlit right";
        ｢http://example.com:80/about/us?foo#bar｣
         URI_reference => ｢http://example.com:80/about/us?foo#bar｣
          URI => ｢http://example.com:80/about/us?foo#bar｣
           scheme => ｢http｣
           hier_part => ｢//example.com:80/about/us｣
            authority => ｢example.com:80｣
             host => ｢example.com｣
              reg_name => ｢example.com｣
             port => ｢80｣
            path_abempty => ｢/about/us｣
             segment => ｢about｣
             segment => ｢us｣
           query => ｢foo｣
           fragment => ｢bar｣
        END
    }
# vim: ft=perl6 et
