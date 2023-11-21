use v6.d;
use Test;

plan 32;

# L<S05/Grammars/"Like classes, grammars can inherit">

# tests namespace, inheritance and override

grammar Grammar::Foo {
    token TOP { <foo> };
    token foo { 'foo' };
    token so { 'so' };
};

is( try { Grammar::Foo.parse( 'so', :rule<so> ) }, 'so',
  "don't let a Mu based action method fail the parse" );

is(~('foo' ~~ /^<Grammar::Foo::foo>$/), 'foo', 'got right match (foo)');
ok Grammar::Foo.parse('foo'), 'got the right match through .parse TOP';
ok Grammar::Foo.parse('foo', :rule<foo>), 'got the right match through .parse foo';

grammar Grammar::Bar is Grammar::Foo {
    token TOP { <any> };
    token bar { 'bar' };
    token any { <foo> | <bar> };
};

isa-ok Grammar::Foo, Grammar, 'grammar isa Grammar';
isa-ok Grammar::Bar, Grammar, 'inherited grammar still isa Grammar';
isa-ok Grammar::Bar, Grammar::Foo, 'child isa parent';

is(~('bar' ~~ /^<Grammar::Bar::bar>$/), 'bar', 'got right match (bar)');
is(~('foo' ~~ /^<Grammar::Bar::foo>$/), 'foo', 'got right match (foo)');
is(~('foo' ~~ /^<Grammar::Bar::any>$/), 'foo', 'got right match (any)');
is(~('bar' ~~ /^<Grammar::Bar::any>$/), 'bar', 'got right match (any)');

ok Grammar::Bar.parse('foo'), 'can parse foo through .parsed and inherited subrule';
ok Grammar::Bar.parse('bar', :rule<bar>), 'got right match (bar)';
ok Grammar::Bar.parse('foo', :rule<foo>), 'got right match (foo)';
ok Grammar::Bar.parse('bar', :rule<any>), 'got right match (any)';
ok Grammar::Bar.parse('foo', :rule<any>), 'got right match (any)';
nok Grammar::Bar.parse('boo', :rule<any>), 'No match for bad input (any)';

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

ok Grammar::Baz.parse('baz', :rule<baz>), 'got right match (baz)';
ok Grammar::Baz.parse('foo', :rule<foo>), 'got right match (foo)';
ok Grammar::Baz.parse('bar', :rule<bar>), 'got right match (bar)';
ok Grammar::Baz.parse('baz', :rule<any>), 'got right match (any)';
ok Grammar::Baz.parse('foo', :rule<any>), 'got right match (any)';
ok Grammar::Baz.parse('bar', :rule<any>), 'got right match (any)';
nok Grammar::Baz.parse('boo', :rule<any>), 'No match for bad input (any)';

{
    class A { };
    grammar B is A { };
    #?rakudo todo 'automatic Grammar superclass'
    isa-ok B, Grammar, 'A grammar isa Grammar, even if inherting from a class';

}

is(Grammar.WHAT.gist,"(Grammar)", "Grammar.WHAT.gist = Grammar()");

# vim: ft=perl6
