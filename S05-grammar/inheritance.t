use v6;
use Test;

plan 11;

# tests namespace, inheritance and override

grammar Grammar::Foo {
    token foo { 'foo' };
};

is('foo' ~~ /^<Grammar::Foo::foo>$/, 'foo', 'got right match');

grammar Grammar::Bar is Grammar::Foo {
    token bar { 'bar' };
    token any { <foo> | <bar> };
};

is(~('foo' ~~ /^<Grammar::Bar::foo>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Bar::bar>$/), 'bar', 'got right match');
is(~('foo' ~~ /^<Grammar::Bar::any>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Bar::any>$/), 'bar', 'got right match');

grammar Grammar::Baz is Grammar::Bar {
    token baz { 'baz' };
    token any { <foo> | <bar> | <baz> };
};

is(~('baz' ~~ /^<Grammar::Baz::baz>$/), 'baz', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::foo>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::bar>$/), 'bar', 'got right match');
is(~('foo' ~~ /^<Grammar::Baz::any>$/), 'foo', 'got right match');
is(~('bar' ~~ /^<Grammar::Baz::any>$/), 'bar', 'got right match');
is(~('baz' ~~ /^<Grammar::Baz::any>$/), 'baz', 'got right match');

