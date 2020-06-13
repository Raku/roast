use v6;
use Test;

use lib $?FILE.IO.parent(2).add("packages/Fancy/lib");

plan 3;

use Fancy::Utilities;
ok EVAL('class Fancy { }; 1'), 'can define a class A when module A::B has been used';

eval-lives-ok 'my class A::B { ... }; A::B.new(); class A::B { };',
    'can stub lexical classes with joined namespaces';

# https://github.com/Raku/old-issue-tracker/issues/1436
class Outer::Inner { };
dies-ok { EVAL 'Outer.foo' },
    'can sensibly die when calling method on package';

# vim: expandtab shiftwidth=4
