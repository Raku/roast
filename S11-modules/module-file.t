module Foo::Bar;
use v6;
use Test;

# L<S11/"Modules"/"The first form is allowed only as the first statement in the file.">

plan 3;

is($?PACKAGE, 'Foo::Bar', '$?PACKAGE for "module Foo::Bar;"');
is($?CLASS,   'Main',     '$?CLASS for "module Foo::Bar;"');
is($?MODULE,  'Foo::Bar', '$?MODULE for "module Foo::Bar;"');
