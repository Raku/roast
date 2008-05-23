use v6;
use Test;

# L<S11/"MODULES"/"There are two basic declaration syntaxes:">

plan 7;

is($?MODULE, 'Main', '$?MODULE for main module');

module Foo {
	is($?PACKAGE, 'Foo',  '$?PACKAGE for "module Foo {}"');
	is($?CLASS,   'Main', '$?CLASS unchanged for "module Foo {}"');
	is($?MODULE,  'Foo',  '$?MODULE for "module Foo {}"');

	module Bar {
		is($?PACKAGE, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar {}"');
		is($?CLASS,   'Main',     '$?CLASS unchanged for "module Foo::Bar {}"');
		is($?MODULE,  'Foo::Bar', '$?MODULE for "module Foo::Bar {}"');
	}
}
