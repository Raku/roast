use v6;
use Test;

# L<S12/Classes/You can predeclare a stub class>

plan 10;

eval_lives_ok q[ class StubA { ... }; class StubA { method foo { } }; ],
              'Can stub a class, and later on declare it';
eval_lives_ok q[ role StubB { ... }; role StubB { method foo { } }; ],
              'Can stub a role, and later on declare it';
eval_lives_ok q[ module StubC { ... }; module StubC { sub foo { } }; ],
              'Can stub a module, and later on declare it';

#?niecza todo 'broken in nom-derived stub model'
#?rakudo todo 'nom regression'
eval_lives_ok q[ package StubD { ... }; class StubD { method foo { } }; ],
              'Can stub a package, and later on implement it as a method';

# not quite class stubs, but I don't know where else to put the tests...

lives_ok { sub {...} }, 'not execued stub code is fine';
dies_ok { (sub {...}).() ~ '' }, 'execued stub code goes BOOM when used';
dies_ok { use fatal; (sub { ... }).() }, 'exeucted stub code goes BOOM under fatal';

eval_dies_ok q[my class StubbedButNotDeclared { ... }], 'stubbing a class but not providing a definition dies';

# RT #81060
{
    throws_like { EVAL 'class A { ... }; say A.WHAT' },
        X::Package::Stubbed,
        message => "The following packages were stubbed but not defined:\n    A";
    throws_like { EVAL 'class A { ... }; class B is A {}' },
        X::Inheritance::NotComposed,
        message => "'B' cannot inherit from 'A' because 'A' isn't compose yet (maybe it is stubbed)";
}

# vim: ft=perl6
