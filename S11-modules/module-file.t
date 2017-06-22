unit module Foo::Bar;
use v6;
use Test;

# L<S11/"Modules"/There are two basic declaration syntaxes>

plan 4;

is($?PACKAGE.^name, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar;"');
is($?MODULE.^name,  'Foo::Bar', '$?MODULE for "module Foo::Bar;"');
is(::?PACKAGE.^name, 'Foo::Bar', '::?PACKAGE for "module Foo::Bar;"');
is(::?MODULE.^name,  'Foo::Bar', '::?MODULE for "module Foo::Bar;"');

# vim: ft=perl6
