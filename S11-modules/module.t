use v6;
use Test;

# L<S11/"Modules"/"There are two basic declaration syntaxes:">

plan 8;

module Foo {
    is($?PACKAGE.^name, 'Foo',  '$?PACKAGE for "module Foo {}"');
    is($?MODULE.^name,  'Foo',  '$?MODULE for "module Foo {}"');
    is(::?PACKAGE.^name, 'Foo',  '::?PACKAGE for "module Foo {}"');
    is(::?MODULE.^name,  'Foo',  '::?MODULE for "module Foo {}"');

    module Bar {
        is($?PACKAGE.^name, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar {}"');
        is($?MODULE.^name,  'Foo::Bar', '$?MODULE for "module Foo::Bar {}"');
        is(::?PACKAGE.^name, 'Foo::Bar', '::?PACKAGE for "module Foo::Bar {}"');
        is(::?MODULE.^name,  'Foo::Bar', '::?MODULE for "module Foo::Bar {}"');
    }
}

# vim: ft=perl6
