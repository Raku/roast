use v6.c;
use Test;

plan 4;

# Shadow various code-object related types, and make sure we don't break
# everything. This test file will not compile if code object types and
# Parameter/Signature are not resolved by the compiler directly in the
# setting, instead of the usual lexical lookup.

my class Parameter { }
my class Signature { }
my class Code { }
my class Block { }
my class Routine { }
my class Sub { }
my class Method { }
my class Regex { }

is (-> $x { $x })(42), 42, 'Can use pointy block even with code types shadowed';
is (sub ($x) { $x })(42), 42, 'Can declare sub even with code types shadowed';
is class C { method m($x) { $x } }.m(42), 42, 'Can declare method even with code types shadowed';
# RT #126728
is 'abc' ~~ /\w/, 'a', 'Can use regex even with code types shadowed';
