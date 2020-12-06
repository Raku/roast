use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 28;

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
    throws-like { nasty(Parent); }, X::Coerce::Impossible,
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
    ok en(0) === A::b, 'coercion to enum';
}

# coercion types on variables
{
    my Int(Any) $x;
    isa-ok $x, Int, 'Coercion type on variable';
    $x = '24';
    isa-ok $x, Int, 'Coercion type on variable after assignment (type)';
    is $x, 24, 'Coercion type on variable after assignment (value)';
}

# coercion types on arrays
{
    my Rat(Str) @a;
    # A Str, a Rat, a RatStr
    @a = "3.141", 1.0, <2.71>;
    # Only a string gets coerced because the allomorph is a Rat anyway.
    is-deeply @a.List, (3.141, 1.0, <2.71>), "an array with coercion type";
}

# coercion types on hashes
{
    my Num(Any) %h;
    %h = :a("42.13"), :b(True), :c(pi);
    # We need to flatten the hash in first place or otherwise its type differs from plain %()
    is-deeply %(|%h), %(:a(42.13e0), :b(1.0e0), :c(pi)), "a hash with coercion type";
}

# methods exist, too
#?rakudo skip 'NYI'
#?DOES 2
{
    class SubCo {...}
    class Co {
        method SubCo() { SubCo.new }
        method erce(Array(Any) $x) {
            $x.^name;
        }
        method invocant(SubCo(Co) SELF:) {
            SELF;
        }
    }
    class SubCo is Co { }
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

{ # Coerce from a child class
    my class SStr is Str { }
    my sub foo(Int:D(Str:D) $i) {
        $i
    }
    my $s = SStr.new: :value("42");
    is foo($s), 42, "coercions from a Str subclass works";
}

{ # https://github.com/rakudo/rakudo/issues/4040
    throws-like { Int(Str).^coerce(pi) },
                X::Coerce::Impossible,
                ".^coerce throws on unacceptable value";
    throws-like { my Rat(Str) $v = 1 },
                X::TypeCheck::Assignment,
                "assigning unacceptable value to a coercive variable throws";
}

{ # https://github.com/rakudo/rakudo/issues/2427
    my Str(Int(Cool)) $x;
    $x = 42.13;
    is $x, "42", "nested coercions work";
}

{ # https://github.com/rakudo/rakudo/issues/4092
    sub with-optional(Int(Str) $foo?) {
        ok $foo === Int, "optional coercive parameter defaults to its target type";
    }
    with-optional();
}

done-testing;

# vim: expandtab shiftwidth=4
