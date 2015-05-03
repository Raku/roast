use v6;
use Test;
plan 31;

grammar Alts {
    token TOP { ^ <alt> $ };

    proto token alt {*}
    token alt:sym<foo> { <sym> };
    token alt:sym<bar> { 'bar' };
    token alt:sym«baz» { 'argl' };    # RT #113590
    token alt:sym«=>»  { <sym> };     # RT #113590
}

ok (my $match = Alts.subparse('foo')), 'can parse with proto regexes (1)';

is $match, 'foo', 'and matched the full string';
is $match<alt>, 'foo', 'got the right name of the capture';

is $/, 'foo', 'also works with $/';

ok Alts.subparse('bar'), 'can parse with second alternative';
ok Alts.subparse('argl'), 'can parse third second alternative';

ok !Alts.subparse('baz'), 'does not match sym of third alternative';
ok !Alts.subparse('aldkfj'), 'does not match completely unrelated string';
ok !Alts.subparse(''), 'does not match empty string';

# RT #113590
ok Alts.subparse('=>'), 'can parse symbol inside double-angles';


class SomeActions {
    method alt:sym<baz>($/) {
        make 'bazbaz';
    }
}

ok ($match = Alts.subparse('argl', :actions(SomeActions.new))),
    'can parse with action methods';
is $match<alt>.ast, 'bazbaz', 'action method got called, make() worked';


grammar LTM {
    proto token lit       {*}
    token lit:sym<foo>    { 'foo' }
    token lit:sym<foobar> { 'foobar' }
    token lit:sym<foob>   { 'foob' }
    
    proto token cclass1  {*}
    token cclass1:sym<a> { <[0..9]> }
    token cclass1:sym<b> { <[0..9]> '.' <[0..9]> }
    
    proto token cclass2  {*}
    token cclass2:sym<a> { <[0..9]> '.' <[0..9]> }
    token cclass2:sym<b> { <[0..9]> }
    
    proto token cclass3 {*}
    token cclass3:sym<a> { \d\d }
    token cclass3:sym<b> { 1 }
    
    proto token cclass4 {*}
    token cclass4:sym<a> { '.' }
    token cclass4:sym<b> { \W\W }
    
    proto token quant1  {*}
    token quant1:sym<a> { ab? }
    token quant1:sym<b> { a }
    
    proto token quant2  {*}
    token quant2:sym<a> { a }
    token quant2:sym<c> { ab+ }
    token quant2:sym<b> { ab? }
    
    proto token quant3  {*}
    token quant3:sym<a> { aaa }
    token quant3:sym<b> { a* }
    
    proto token declok {*}
    token declok:sym<a> {
        :my $x := 42;           #OK not used
        .+
    }
    token declok:sym<b> { aa }

    proto token cap1 {*}
    token cap1:sym<a> { (.+) }
    token cap1:sym<b> { aa }

    proto token cap2 {*}
    token cap2:sym<a> { $<x>=[.+] }
    token cap2:sym<b> { aa }

    proto token ass1 {*}
    token ass1:sym<a> { a <?{ 1 }> .+ }
    token ass1:sym<b> { aa }

    proto token ass2 {*}
    token ass2:sym<a> { a <!{ 0 }> .+ }
    token ass2:sym<b> { aa }
    
    proto token block {*}
    token block:sym<a> { a {} .+ }
    token block:sym<b> { aa }
}

is ~LTM.subparse('foobar', :rule('lit')),  'foobar', 'LTM picks longest literal';
is ~LTM.subparse('1.2', :rule('cclass1')), '1.2',    'LTM picks longest with char classes';
is ~LTM.subparse('1.2', :rule('cclass2')), '1.2',    '...and it not just luck with ordering';
is ~LTM.subparse('11', :rule('cclass3')),  '11',     'LTM works with things like \d';
is ~LTM.subparse('..', :rule('cclass4')),  '..',     '...and negated ones like \W';
is ~LTM.subparse('ab', :rule('quant1')),   'ab',     'LTM and ? quantifier';
is ~LTM.subparse('abbb', :rule('quant2')), 'abbb',   'LTM, ? and + quantifiers';
is ~LTM.subparse('aaaa', :rule('quant3')), 'aaaa',   'LTM and * quantifier';
is ~LTM.subparse('aaa', :rule('declok')),  'aaa',    ':my declarations do not terminate LTM';
is ~LTM.subparse('aaa', :rule('cap1')),    'aaa',    'Positional captures do not terminate LTM';
is ~LTM.subparse('aaa', :rule('cap2')),    'aaa',    'Named captures do not terminate LTM';
is ~LTM.subparse('aaa', :rule('ass1')),    'aaa',    '<?{...}> does not terminate LTM';
is ~LTM.subparse('aaa', :rule('ass2')),    'aaa',    '<!{...}> does not terminate LTM';
#?niecza todo '#89'
is ~LTM.subparse('aaa', :rule('block')),   'aa',     'However, code blocks do terminate LTM';

# RT #120146
#?niecza skip "Action method assertion:sym<...> not yet implemented"
{
    grammar G {

        token nmstrt   {<[_ a..z ]>}
        token nmreg    {<[_ \- a..z 0..9]>+}
        token ident    {'-'?<nmstrt><nmreg>*}
        token id2      {'-'?<nmstrt><nmreg>*}
        token num      {< + - >?\d+}

        proto token term {*}
        token term:sym<ident> {<ident>}
        token term:sym<num>   {<num>}

        proto token term2 {*}
        token term2:sym<ident> {<ident=.id2>}
        token term2:sym<num>   {<num>}
    }

    is ~G.subparse("-42", :rule<num>), '-42', 'num parse';
    is ~G.subparse("-my_id", :rule<ident>), '-my_id', 'id parse';
    is ~G.subparse("my_id", :rule<term>), 'my_id', 'term parse';
    #?rakudo 2 todo 'RT #120146'
    is ~G.subparse("-my_id", :rule<term>), '-my_id', '<ident> override';
    is ~G.subparse("-my_id", :rule<term2>), '-my_id', '<ident> alias';
}

# vim: ft=perl6
