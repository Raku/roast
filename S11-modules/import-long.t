use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");

plan 3;

eval-lives-ok q<use LongNames;>, "export with overlapping short names doesn't fail";
is EVAL(q<use LongNames; Foo::C2.^name>), "LongNames::Foo::C2", "exported symbol name includes it's enclosing module";
eval-lives-ok q<use LongNames; Foo::C1.new>, "export symbol is a class we can use";
