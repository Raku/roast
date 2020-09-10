use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 21;

# coercion types in parameter lists
{
    sub inside(Str(Cool) $x) {
        isa-ok $x, Str, 'coercion type on the inside';
    }
    inside(23);
    sub f(Str(Cool) $x) {
        $x
    }
    isa-ok f(42), Str, 'Coercion type coerces';
    is f(42), '42',   'Coercion type coerces to correct value';
    throws-like q[ sub g(Str(Cool) $x) { $x }; g(Any) ], X::TypeCheck::Binding,
        'coercion type still type-checks';
}

class Child { ... };
class Parent {
    method Child() { Child }
    # returns an object not conforming to NastyChild
    method NastyChild() { Child }
}
class Child is Parent { };
class NastyChild is Parent { };

# with custom classes
{
    sub c(Child(Parent) $x) { $x }
    isa-ok c(Parent), Child, 'Coercion with user-defined types';

    sub nasty(NastyChild(Parent) $x) { $x }
    #?rakudo todo 'missing checks'
    dies-ok { EVAL 'nasty(Parent)' },
        'coercion that does not produce the target type dies';
}

# with definedness checks


# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub f1(Str:D(Cool:D) $x) { $x }
    sub f2(Str(Cool:D)   $x) { $x; }

    throws-like { EVAL 'f1(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected \s \S* Cool\:D/;
    throws-like { EVAL 'f2(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected \s \S* Cool\:D/;
    isa-ok f1(23), Str, 'Definedness check + coercion (1)';
    isa-ok f2(23), Str, 'Definedness check + coercion (2)';

    sub f3(Child:D(Parent) $x) { $x }
    dies-ok { EVAL 'f3(Parent)' },
        'Coercion dies if it doees not satisfy definedness constraint of target';
}

# enums!
{
    enum A <b c d>;
    ok A(0) === A::b, 'basic enum sanity';
    sub en(A(Any) $x ) { $x }
    #?rakudo skip 'dies'
    ok en(0) === A::b, 'coercion to enum';
}

# coercion types on variables
#?rakudo skip 'NYI'
#?DOES 3
{
    my Int(Any) $x;
    isa-ok $x, Int, 'Coercion type on variable';
    $x = '24';
    isa-ok $x, Int, 'Coercion type on variable after assignment (type)';
    is $x, 24, 'Coercion type on variable after assignment (value)';
}

# methods exist, too
#?rakudo skip 'NYI'
#?DOES 2
{
    class Co {
        class SubCo is Co { }
        method SubCo() { SubCo.new }
        method erce(Array(Any) $x) {
            $x.^name;
        }
        method invocant(SubCo(Co) SELF:) {
            SELF;
        }
    }
    is Co.erce((1, 2)), 'Array', 'coercion on method param';
    isa-ok Co.invocant, SubCo, 'Can coerce invocant to subclass';
}

is Str(Any).gist, '(Str(Any))', 'Can gist a coercion type';

# https://github.com/Raku/old-issue-tracker/issues/6353
{
    my \a = -42;
    is Int(a), -42, "Sigilless variable does not confuse coercion type parsing";
}

{ # https://github.com/rakudo/rakudo/issues/1753
    my subset ZInt of Cool where *.elems;
    sub foo(ZInt(Cool) $Z) {};
    pass 'coercer with subset target did not crash';
}

# vim: expandtab shiftwidth=4
