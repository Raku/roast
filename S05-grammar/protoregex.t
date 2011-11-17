use v6;
use Test;
plan 17;

grammar Alts {
    token TOP { ^ <alt> $ };

    proto token alt {*}
    token alt:sym<foo> { <sym> };
    token alt:sym<bar> { 'bar' };
    token alt:sym<baz> { 'argl' };
}

ok (my $match = Alts.parse('foo')), 'can parse with proto regexes (1)';

is $match, 'foo', 'and matched the full string';
is $match<alt>, 'foo', 'got the right name of the capture';

#?rakudo todo '$/ not populated by .parse method'
is $/, 'foo', 'also works with $/';

ok Alts.parse('bar'), 'can parse with second alternative';
ok Alts.parse('argl'), 'can parse third second alternative';

ok !Alts.parse('baz'), 'does not match sym of third alternative';
ok !Alts.parse('aldkfj'), 'does not match completely unrelated string';
ok !Alts.parse(''), 'does not match empty string';


class SomeActions {
    method alt:sym<baz>($/) {
        make 'bazbaz';
    }
}

ok ($match = Alts.parse('argl', :actions(SomeActions.new))),
    'can parse with action methods';
is $match<alt>.ast, 'bazbaz', 'action method got called, make() worked';


grammar LTM {
    proto token lit       { * }
    token lit:sym<foo>    { 'foo' }
    token lit:sym<foobar> { 'foobar' }
    token lit:sym<foob>   { 'foob' }
    
    proto token cclass1  { * }
    token cclass1:sym<a> { <[0..9]> }
    token cclass1:sym<b> { <[0..9]> '.' <[0..9]> }
    
    proto token cclass2  { * }
    token cclass2:sym<a> { <[0..9]> '.' <[0..9]> }
    token cclass2:sym<b> { <[0..9]> }
    
    proto token quant1  { * }
    token quant1:sym<a> { ab? }
    token quant1:sym<b> { a }
    
    proto token quant2  { * }
    token quant2:sym<a> { a }
    token quant2:sym<c> { ab+ }
    token quant2:sym<b> { ab? }
    
    proto token quant3  { * }
    token quant3:sym<a> { aaa }
    token quant3:sym<b> { a* }
}

is ~LTM.parse('foobar', :rule('lit')),  'foobar', 'LTM picks longest literal';
is ~LTM.parse('1.2', :rule('cclass1')), '1.2',    'LTM picks longest with char classes';
is ~LTM.parse('1.2', :rule('cclass2')), '1.2',    '...and it not just luck with ordering';
is ~LTM.parse('ab', :rule('quant1')),   'ab',     'LTM and ? quantifier';
is ~LTM.parse('abbb', :rule('quant2')), 'abbb',   'LTM, ? and + quantifiers';
is ~LTM.parse('aaaa', :rule('quant3')), 'aaaa',   'LTM and * quantifier';

# vim: ft=perl6
