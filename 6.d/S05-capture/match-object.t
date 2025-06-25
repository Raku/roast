use v6.d;
use Test;
use lib $*PROGRAM.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 3;

my grammar Foo { token TOP { . } }
Foo.parse("a");
is $/, "a", 'was $/ set by Grammar.parse';

Foo.subparse("b");
is $/, "b", 'was $/ set by Grammar.subparse';

Foo.parsefile(make-temp-file content => 'c');
is $/, "c", 'was $/ set by Grammar.parsefile';

# vim: expandtab shiftwidth=4
