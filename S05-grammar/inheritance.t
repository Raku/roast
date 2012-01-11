use v6;
use Test;

plan 18;

# L<S05/Grammars/"Like classes, grammars can inherit">

# tests namespace, inheritance and override

grammar Grammar::Foo {
    token TOP { <foo> };
    token foo { 'foo' };
};

#?rakudo skip '<a::b>'
#?niecza skip 'Cannot dispatch to a method on Foo because it is not inherited or done by Cursor'
is(~('foo' ~~ /^<Grammar::Foo::foo>$/), 'foo', 'got right match (foo)');
is ~Grammar::Foo.parse('foo'), 'foo', 'got the right match through .parse';

grammar Grammar::Bar is Grammar::Foo {
    token TOP { <any> };
    token bar { 'bar' };
    token any { <foo> | <bar> };
};

isa_ok Grammar::Foo, Grammar, 'grammar isa Grammar';
isa_ok Grammar::Bar, Grammar, 'inherited grammar still isa Grammar';
isa_ok Grammar::Bar, Grammar::Foo, 'child isa parent';

#?rakudo skip '<a::b>'
#?niecza 5 skip 'Cannot dispatch to a method on Bar because it is not inherited or done by Cursor'
is(~('bar' ~~ /^<Grammar::Bar::bar>$/), 'bar', 'got right match (bar)');
#?rakudo skip 'directly calling inherited grammar rule (RT 65474)'
is(~('foo' ~~ /^<Grammar::Bar::foo>$/), 'foo', 'got right match (foo)');
#?rakudo skip 'RT 77350'
ok Grammar::Bar.parse('foo'), 'can parse foo through .parsed and inhertied subrule';
#?rakudo 2 skip '<a::b>'
is(~('foo' ~~ /^<Grammar::Bar::any>$/), 'foo', 'got right match (any)');
is(~('bar' ~~ /^<Grammar::Bar::any>$/), 'bar', 'got right match (any)');

grammar Grammar::Baz is Grammar::Bar {
    token baz { 'baz' };
    token any { <foo> | <bar> | <baz> };
};

#?rakudo skip '<a::b>'
#?niecza 6 skip 'Cannot dispatch to a method on Baz because it is not inherited or done by Cursor'
is(~('baz' ~~ /^<Grammar::Baz::baz>$/), 'baz', 'got right match');
#?rakudo 2 skip 'calling inherited grammar rule'
is(~('foo' ~~ /^<Grammar::Baz::foo>$/), 'foo', 'got right match');
#?rakudo 4 skip '<a::b>'
is(~('bar' ~~ /^<Grammar::Baz::bar>$/), 'bar', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::any>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::any>$/), 'bar', 'got right match');
is(~('baz' ~~ /^<Grammar::Baz::any>$/), 'baz', 'got right match');

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
