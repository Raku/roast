use v6;
use Test;

# L<S12/Classes/You can predeclare a stub class>

plan 10;

eval-lives-ok q[ class StubA { ... }; class StubA { method foo { } }; ],
              'Can stub a class, and later on declare it';
eval-lives-ok q[ role StubB { ... }; role StubB { method foo { } }; ],
              'Can stub a role, and later on declare it';
eval-lives-ok q[ module StubC { ... }; module StubC { sub foo { } }; ],
              'Can stub a module, and later on declare it';

#?niecza todo 'broken in nom-derived stub model'
#?rakudo todo 'nom regression RT #125044'
eval-lives-ok q[ package StubD { ... }; class StubD { method foo { } }; ],
              'Can stub a package, and later on implement it as a class';

# not quite class stubs, but I don't know where else to put the tests...

lives-ok { sub {...} }, 'not execued stub code is fine';
dies-ok { (sub {...}).() ~ '' }, 'execued stub code goes BOOM when used';
dies-ok { use fatal; (sub { ... }).() }, 'exeucted stub code goes BOOM under fatal';

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

# vim: ft=perl6
