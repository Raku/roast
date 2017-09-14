use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

# L<S12/Classes/You can predeclare a stub class>

plan 9;

eval-lives-ok q[ class StubA { ... }; class StubA { method foo { } }; ],
              'Can stub a class, and later on declare it';
eval-lives-ok q[ role StubB { ... }; role StubB { method foo { } }; ],
              'Can stub a role, and later on declare it';
eval-lives-ok q[ module StubC { ... }; module StubC { sub foo { } }; ],
              'Can stub a module, and later on declare it';

#?rakudo todo 'nom regression RT #125044'
eval-lives-ok q[ package StubD { ... }; class StubD { method foo { } }; ],
              'Can stub a package, and later on implement it as a class';

throws-like q[my class StubbedButNotDeclared { ... }], X::Package::Stubbed,
    'stubbing a class but not providing a definition dies';

# RT #81060
{
    throws-like { EVAL 'class A { ... }; say A.WHAT' },
        X::Package::Stubbed,
        message => "The following packages were stubbed but not defined:\n    A";
    throws-like { EVAL 'class A { ... }; class B is A {}' },
        X::Inheritance::NotComposed,
        child-name  => 'B',
        parent-name => 'A';
}

# RT #129270
subtest "all forms of yadas work to stub classes" => {
    plan 2;
    subtest "lives when stubbed, then defined" => {
        plan 4;
        eval-lives-ok ｢my class Foo { …   }; my class Foo {}｣, '…';
        eval-lives-ok ｢my class Foo { ... }; my class Foo {}｣, '...';
        eval-lives-ok ｢my class Foo { !!! }; my class Foo {}｣, '!!!';
        eval-lives-ok ｢my class Foo { ??? }; my class Foo {}｣, '???';
    }

    subtest "throws when stubbed, and never defined" => {
        plan 4;
        throws-like ｢my class Foo { …   }｣, X::Package::Stubbed, '…';
        throws-like ｢my class Foo { ... }｣, X::Package::Stubbed, '...';
        throws-like ｢my class Foo { !!! }｣, X::Package::Stubbed, '!!!';
        throws-like ｢my class Foo { ??? }｣, X::Package::Stubbed, '???';
    }
}

# RT #126426
{
    is_run ｢class X::B { ... }; X::B.new.a.print; class X::B { has $.a = 42}｣, 
        { :out<42>, :err('') }, 'Can stub a class in a core namespace';
}

# vim: ft=perl6
