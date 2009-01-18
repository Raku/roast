use v6;
use Test;

plan 11;

# L<S05/Grammars/"Like classes, grammars can inherit">

# tests namespace, inheritance and override

grammar Grammar::Foo {
    token foo { 'foo' };
};

is(~('foo' ~~ /^<Grammar::Foo::foo>$/), 'foo', 'got right match (foo)');

grammar Grammar::Bar is Grammar::Foo {
    token bar { 'bar' };
    token any { <foo> | <bar> };
};

is(~('bar' ~~ /^<Grammar::Bar::bar>$/), 'bar', 'got right match (bar)');
#?rakudo skip 'directly calling inherited grammar rule'
is(~('foo' ~~ /^<Grammar::Bar::foo>$/), 'foo', 'got right match (foo)');
is(~('foo' ~~ /^<Grammar::Bar::any>$/), 'foo', 'got right match (any)');
is(~('bar' ~~ /^<Grammar::Bar::any>$/), 'bar', 'got right match (any)');

grammar Grammar::Baz is Grammar::Bar {
    token baz { 'baz' };
    token any { <foo> | <bar> | <baz> };
};

is(~('baz' ~~ /^<Grammar::Baz::baz>$/), 'baz', 'got right match');
#?rakudo 2 skip 'calling inherited grammar rule'
is(~('foo' ~~ /^<Grammar::Baz::foo>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::bar>$/), 'bar', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::any>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::any>$/), 'bar', 'got right match');
is(~('baz' ~~ /^<Grammar::Baz::any>$/), 'baz', 'got right match');

