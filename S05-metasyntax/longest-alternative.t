use v6;
use Test;

plan 53;

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

#?rakudo skip ':: RT #124526'
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

# RT #124333
# This exposed a dynamic optimizer bug, due to the huge number of basic blocks
# a token with a load of alternations produces.
{
    my grammar WithHugeToken {
        token TOP {
            <huge>+
        }
        token huge {
              <[\x[0041]..\x[005A]]>
            | <[\x[0061]..\x[007A]]>
            | <[\x[0388]..\x[038A]]>
            | <[\x[038E]..\x[03A1]]>
            | <[\x[03A3]..\x[03CE]]>
            | <[\x[03D0]..\x[03D7]]>
            | <[\x[03DA]..\x[03F3]]>
            | <[\x[0400]..\x[0481]]>
            | <[\x[048C]..\x[04C4]]>
            | <[\x[04C7]..\x[04C8]]>
            | <[\x[04CB]..\x[04CC]]>
            | <[\x[04D0]..\x[04F5]]>
            | <[\x[04F8]..\x[04F9]]>
            | <[\x[0531]..\x[0556]]>
            | <[\x[06E5]..\x[06E6]]>
            | <[\x[06FA]..\x[06FC]]>
            | <[\x[1312]..\x[1315]]>
            | <[\x[1318]..\x[131E]]>
            | <[\x[1320]..\x[1346]]>
            | <[\x[1348]..\x[135A]]>
            | <[\x[13A0]..\x[13B0]]>
            | <[\x[13B1]..\x[13F4]]>
            | <[\x[1401]..\x[1676]]>
            | <[\x[1681]..\x[169A]]>
            | <[\x[16A0]..\x[16EA]]>
            | <[\x[1780]..\x[17B3]]>
            | <[\x[1820]..\x[1877]]>
            | <[\x[1880]..\x[18A8]]>
            | <[\x[1E00]..\x[1E9B]]>
            | <[\x[1EA0]..\x[1EE0]]>
            | <[\x[1EE1]..\x[1EF9]]>
            | <[\x[1F00]..\x[1F15]]>
            | <[\x[1F18]..\x[1F1D]]>
            | <[\x[1F20]..\x[1F39]]>
            | <[\x[1F3A]..\x[1F45]]>
            | <[\x[1F48]..\x[1F4D]]>
            | <[\x[1F50]..\x[1F57]]>
            | <[\x[210A]..\x[2113]]>
            | <[\x[2119]..\x[211D]]>
            | <[\x[212A]..\x[212D]]>
            | <[\x[212F]..\x[2131]]>
            | <[\x[2133]..\x[2139]]>
            | <[\x[2160]..\x[2183]]>
            | <[\x[3005]..\x[3007]]>
            | <[\x[3021]..\x[3029]]>
            | <[\x[3031]..\x[3035]]>
            | <[\x[3038]..\x[303A]]>
            | <[\x[3041]..\x[3094]]>
            | <[\x[309D]..\x[309E]]>
            | <[\x[30A1]..\x[30FA]]>
            | <[\x[30FC]..\x[30FE]]>
            | <[\x[3105]..\x[312C]]>
            | <[\x[3131]..\x[318E]]>
            | <[\x[31A0]..\x[31B7]]>
            | <[\x[A000]..\x[A48C]]>
            | <[\x[F900]..\x[FA2D]]>
            | <[\x[FB00]..\x[FB06]]>
            | <[\x[FB13]..\x[FB17]]>
            | <[\x[FB1F]..\x[FB28]]>
            | <[\x[FB2A]..\x[FB36]]>
            | <[\x[FB38]..\x[FB3C]]>
            | <[\x[FB40]..\x[FB41]]>
            | <[\x[FB43]..\x[FB44]]>
            | <[\x[FB46]..\x[FBB1]]>
            | <[\x[FBD3]..\x[FD3D]]>
            | <[\x[FD50]..\x[FD8F]]>
            | <[\x[FD92]..\x[FDC7]]>
            | <[\x[FDF0]..\x[FDFB]]>
            | <[\x[FE70]..\x[FE72]]>
            | <[\x[FE76]..\x[FEFC]]>
            | <[\x[FF21]..\x[FF3A]]>
            | <[\x[FF41]..\x[FF5A]]>
            | <[\x[FF66]..\x[FFBE]]>
            | <[\x[FFC2]..\x[FFC7]]>
            | <[\x[FFCA]..\x[FFCF]]>
            | <[\x[FFD2]..\x[FFD7]]>
            | <[\x[FFDA]..\x[FFDC]]>
            | \x[038C]
            | \x[0559]
            | \x[06D5]
            | \x[0710]
            | \x[1310]
            | \x[2115]
            | \x[2124]
            | \x[2126]
            | \x[2128]
            | \x[3400]
            | \x[4DB5]
            | \x[4E00]
            | \x[9FA5]
            | \x[AC00]
            | \x[D7A3]
            | \x[FB1D]
            | \x[FB3E]
            | \x[FE74]
        }
    }

    lives-ok { WithHugeToken.parse('a' x 10000) },
        'token with huge number of alternations does not explode when used many times';
}

# LTM and ignorecase/ignoremark
{
    my $str = 'äaÄAÁbbBB';
    ok $str ~~ m:i/b+|bb/, 'alternation with :i matches';
    is ~$/, 'bbBB', 'got longest alternative with :i';

    #?rakudo.jvm 4 skip ':ignoremark needs NFG RT #124500'
    ok $str ~~ m:m/ä|bb|a+/, 'alternation with :m matches';
    is ~$/, 'äa', 'got longest alternative with :m';

    ok $str ~~ m:i:m/b+|bb|a+|äa/, 'alternation with :i:m matches';
    is ~$/, 'äaÄAÁ', 'got longest alternative with :i:m';
}

# RT #113884
{
    #?rakudo todo "RT #113884 - constant variables not counted in LTM yet"
    constant $x = 'ab'; 
    is ~('ab' ~~ / a | b | $x /), 'ab', 'got longest alternative with constant';

    my $y = 'ab';
    is ~('ab' ~~ / a | b | $y /), 'a', "non constants don't count toward LTM";
}

# RT #125608
{
    is ~('food' ~~ / 'foo' | ('food' || 'doof')/), 'food',
        'sequential alternation first branch involved in longest alternative (1)';
    dies-ok { 'food' ~~ / 'foo' | ('food' <!> || { die "Should die here" })/ },
        'sequential alternation first branch involved in longest alternative (2)';
    is ~('food' ~~ / 'foo' | ('food' <!> || 'doof')/), 'foo',
        'sequential alternation first branch failure after LTM tries next best option';
}

# vim: ft=perl6 et
