module Foo::Bar;
use v6;
use Test;

# L<S11/"Modules"/There are two basic declaration syntaxes>

plan 3;

is($?PACKAGE, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar;"');
is($?CLASS,   'Main',     '$?CLASS for "module Foo::Bar;"');
is($?MODULE,  'Foo::Bar', '$?MODULE for "module Foo::Bar;"');
