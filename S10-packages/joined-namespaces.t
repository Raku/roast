use v6;

use lib 't/spec/packages';

use Test;

plan 3;

use Fancy::Utilities;
ok EVAL('class Fancy { }; 1'), 'can define a class A when module A::B has been used';

eval-lives-ok 'my class A::B { ... }; A::B.new(); class A::B { };',
    'can stub lexical classes with joined namespaces';

# RT #71260
class Outer::Inner { };
dies-ok { EVAL 'Outer.foo' },
    'can sensibly die when calling method on package';
