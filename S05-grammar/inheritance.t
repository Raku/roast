use v6;
use Test;

plan 31;

# L<S05/Grammars/"Like classes, grammars can inherit">

# tests namespace, inheritance and override

grammar Grammar::Foo {
    token TOP { <foo> };
    token foo { 'foo' };
};

#?niecza skip 'Cannot dispatch to a method on Foo because it is not inherited or done by Cursor'
is(~('foo' ~~ /^<Grammar::Foo::foo>$/), 'foo', 'got right match (foo)');
ok Grammar::Foo.parse('foo'), 'got the right match through .parse TOP';
ok Grammar::Foo.parse('foo', :rule<foo>), 'got the right match through .parse foo';

grammar Grammar::Bar is Grammar::Foo {
    token TOP { <any> };
    token bar { 'bar' };
    token any { <foo> | <bar> };
};

isa_ok Grammar::Foo, Grammar, 'grammar isa Grammar';
isa_ok Grammar::Bar, Grammar, 'inherited grammar still isa Grammar';
isa_ok Grammar::Bar, Grammar::Foo, 'child isa parent';

#?niecza 4 skip 'Cannot dispatch to a method on Bar because it is not inherited or done by Cursor'
is(~('bar' ~~ /^<Grammar::Bar::bar>$/), 'bar', 'got right match (bar)');
is(~('foo' ~~ /^<Grammar::Bar::foo>$/), 'foo', 'got right match (foo)');
is(~('foo' ~~ /^<Grammar::Bar::any>$/), 'foo', 'got right match (any)');
is(~('bar' ~~ /^<Grammar::Bar::any>$/), 'bar', 'got right match (any)');

#?rakudo skip 'RT 77350'
ok Grammar::Bar.parse('foo'), 'can parse foo through .parsed and inhertied subrule';
ok Grammar::Bar.parse('bar', :rule<bar>), 'got right match (bar)';
ok Grammar::Bar.parse('foo', :rule<foo>), 'got right match (foo)';
#?rakudo 3 skip 'error'
ok Grammar::Bar.parse('bar', :rule<any>), 'got right match (any)';
ok Grammar::Bar.parse('foo', :rule<any>), 'got right match (any)';
nok Grammar::Bar.parse('boo', :rule<any>), 'No match for bad input (any)';

grammar Grammar::Baz is Grammar::Bar {
    token baz { 'baz' };
    token any { <foo> | <bar> | <baz> };
};

#?niecza 6 skip 'Cannot dispatch to a method on Baz because it is not inherited or done by Cursor'
is(~('baz' ~~ /^<Grammar::Baz::baz>$/), 'baz', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::foo>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::bar>$/), 'bar', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::any>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::any>$/), 'bar', 'got right match');
is(~('baz' ~~ /^<Grammar::Baz::any>$/), 'baz', 'got right match');

ok Grammar::Baz.parse('baz', :rule<baz>), 'got right match (baz)';
ok Grammar::Baz.parse('foo', :rule<foo>), 'got right match (foo)';
ok Grammar::Baz.parse('bar', :rule<bar>), 'got right match (bar)';
#?rakudo 3 skip 'error'
ok Grammar::Baz.parse('baz', :rule<any>), 'got right match (any)';
ok Grammar::Baz.parse('foo', :rule<any>), 'got right match (any)';
ok Grammar::Baz.parse('bar', :rule<any>), 'got right match (any)';
nok Grammar::Baz.parse('boo', :rule<any>), 'No match for bad input (any)';

{
    class A { };
    grammar B is A { };
    #?rakudo todo 'automatic Grammar superclass'
    #?niecza todo 'automatic Grammar superclass'
    isa_ok B, Grammar, 'A grammar isa Grammar, even if inherting from a class';

}

is(Grammar.WHAT.gist,"Grammar()", "Grammar.WHAT.gist = Grammar()");

done;

# vim: ft=perl6
