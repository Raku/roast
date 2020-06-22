use v6;
unit module Foo::Bar;
use Test;

# L<S11/"Modules"/There are two basic declaration syntaxes>

plan 4;

is($?PACKAGE.^name, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar;"');
is($?MODULE.^name,  'Foo::Bar', '$?MODULE for "module Foo::Bar;"');
is(::?PACKAGE.^name, 'Foo::Bar', '::?PACKAGE for "module Foo::Bar;"');
is(::?MODULE.^name,  'Foo::Bar', '::?MODULE for "module Foo::Bar;"');

# vim: expandtab shiftwidth=4
