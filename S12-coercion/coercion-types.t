use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 31;

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


# RT #124839 / RT#123770
{
    sub f1(Str:D(Cool:D) $x) { $x }
    sub f2(Str(Cool:D)   $x) { $x; }

    throws-like { EVAL 'f1(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected\sCool\:D/;
    throws-like { EVAL 'f2(Cool)' }, X::TypeCheck::Binding::Parameter, message => /expected\sCool\:D/;
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
#?rakudo skip 'NYI RT #124840'
#?DOES 3
{
    my Int(Any) $x;
    isa-ok $x, Int, 'Coercion type on variable';
    $x = '24';
    isa-ok $x, Int, 'Coercion type on variable after assignment (type)';
    is $x, 24, 'Coercion type on variable after assignment (value)';
}

# methods exist, too
#?rakudo skip 'NYI RT #124841'
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

# RT #131611
{
    my \a = -42;
    is Int(a), -42, "Sigilless variable does not confuse coercion type parsing";
}

# RT #130479
is_run ｢
    class Foo { method Bar {die} }
    class Bar is Foo {}
    -> Bar(Foo) $foo?, Bar(Foo) :$bar {
        say $foo; say $bar;
    }()
｣, {:err(''), :out("(Bar)\n(Bar)\n"), :0status},
    'coercers do not attempt to coerce optional params that were not given';

subtest ':D DefiniteHow target (core types)' => {
    #####
    # XXX 6.d REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 8;
    is-deeply -> Int:D(Cool)   $x { $x }("42"), 42, 'type';
    is-deeply -> Int:D(Cool:D) $x { $x }("42"), 42, ':D smiley';
    is-deeply -> Int:D()       $x { $x }("42"), 42, 'implied Any';
    #?rakudo skip ':D/:U coerces NYI'
    is-deeply -> Array:D(List:U) $x { $x }(List), [List,], ':U smiley';

    is-deeply -> Int:D(Cool)   $x { $x }("42"), 42, 'type';
    is-deeply -> Int:D(Cool:D) $x { $x }("42"), 42, ':D smiley';
    is-deeply -> Int:D()       $x { $x }("42"), 42, 'implied Any';
    #?rakudo skip ':D/:U coerces NYI'
    is-deeply -> Array:D(List:U) $x { $x }(List), [List,], ':U smiley';
}

subtest ':U DefiniteHow target (core types)' => {
    plan 3;
    is-deeply -> Date:U(DateTime)   $x { $x }(DateTime), Date, 'type';
    is-deeply -> Date:U(DateTime:U) $x { $x }(DateTime), Date, ':U smiley';
    is-deeply -> Date:U()       $x { $x }(DateTime), Date, 'implied Any';
}

subtest 'DefiniteHow target, errors' => {
    #####
    # XXX 6.d REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 4;
    my \XPIC = X::Parameter::InvalidConcreteness;
    #?rakudo 4 todo 'no proper concreteness check in coerces'
    throws-like ｢-> Date:D(DateTime)   {}(DateTime)｣, XPIC, 'type, bad source';
    throws-like ｢-> Date:D(DateTime:D) {}(DateTime)｣, XPIC, ':D, bad source';
    throws-like ｢-> Date:D(DateTime:U) {}(DateTime)｣, XPIC, ':U, bad target';
    throws-like ｢-> Date:D() {}(DateTime)｣, XPIC, 'implied, bad target';
}

subtest 'DefiniteHow target, errors, source is already target' => {
    #####
    # XXX 6.d REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 4;
    my \XPIC = X::Parameter::InvalidConcreteness;
    #?rakudo 4 todo 'no proper concreteness check in coerces'
    throws-like ｢-> Date:D(DateTime)   {}(Date)｣, XPIC, 'type';
    throws-like ｢-> Date:D(DateTime:D) {}(Date)｣, XPIC, ':D';
    throws-like ｢-> Date:D(DateTime:U) {}(Date)｣, XPIC, ':U';
    throws-like ｢-> Date:D() {}(Date)｣,           XPIC, 'implied';
}

{
    #####
    # XXX 6.d REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    my class Target {...}
    my class Source  { method Target { self.DEFINITE ?? Target.new !! Target } }
    my class SourceU { method Target { self.DEFINITE ?? Target !! Target.new } }
    my class Target is Source is SourceU {}
    my class SubSource  is Source  {}
    my class SubSourceU is SourceU {}

    subtest ':D DefiniteHow target (arbitrary types; from source)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(Source.new), Target.new,
            'from type';
        is-deeply -> Target:D(Source:D) $x { $x }(Source.new), Target.new,
            'from :D smiley';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(SourceU),    Target.new,
            'from :U smiley';
        is-deeply -> Target:D(Any)      $x { $x }(Source.new), Target.new,
            'from Any';
        is-deeply -> Target:D(Any:D)    $x { $x }(Source.new), Target.new,
            'from Any:D';
        is-deeply -> Target:D()         $x { $x }(Source.new), Target.new,
            'from implied Any';
    }

    subtest ':D DefiniteHow target (arbitrary types; from source subclass)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(SubSource.new), Target.new,
            'from type';
        is-deeply -> Target:D(Source:D) $x { $x }(SubSource.new), Target.new,
            'from :D smiley';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(SubSourceU),    Target.new,
            'from :U smiley';
        is-deeply -> Target:D(Any)      $x { $x }(SubSource.new), Target.new,
            'from Any';
        is-deeply -> Target:D(Any:D)    $x { $x }(SubSource.new), Target.new,
            'from Any:D';
        is-deeply -> Target:D()         $x { $x }(SubSource.new), Target.new,
            'from implied Any';
    }

    subtest ':D DefiniteHow target (arbitrary types; already target)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(Target.new), Target.new,
            'from type';
        is-deeply -> Target:D(Source:D) $x { $x }(Target.new), Target.new,
            'from :D smiley';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(Target.new), Target.new,
            'from :U smiley';
        is-deeply -> Target:D(Any)      $x { $x }(Target.new), Target.new,
            'from Any';
        is-deeply -> Target:D(Any:D)    $x { $x }(Target.new), Target.new,
            'from Any:D';
        is-deeply -> Target:D()         $x { $x }(Target.new), Target.new,
            'from implied Any';
    }

    subtest ':U DefiniteHow target (arbitrary types; from source)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(Source),      Target,
            'from type';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(SourceU.new), Target,
            'from :D smiley';
        is-deeply -> Target:U(Source:U) $x { $x }(Source),      Target,
            'from :U smiley';
        is-deeply -> Target:U(Any)      $x { $x }(Source),      Target,
            'from Any';
        is-deeply -> Target:U(Any:U)    $x { $x }(Source),      Target,
            'from Any:U';
        is-deeply -> Target:U()         $x { $x }(Source),      Target,
            'from implied Any';
    }

    subtest ':U DefiniteHow target (arbitrary types; from source subclass)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(SubSource),      Target,
            'from type';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(SubSourceU.new), Target,
            'from :D smiley';
        is-deeply -> Target:U(Source:U) $x { $x }(SubSource),      Target,
            'from :U smiley';
        is-deeply -> Target:U(Any)      $x { $x }(SubSource),      Target,
            'from Any';
        is-deeply -> Target:U(Any:U)    $x { $x }(SubSource),      Target,
            'from Any:U';
        is-deeply -> Target:U()         $x { $x }(SubSource),      Target,
            'from implied Any';
    }

    subtest ':U DefiniteHow target (arbitrary types; already target)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(Target), Target,
            'from type';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(Target), Target,
            'from :D smiley';
        is-deeply -> Target:U(Source:U) $x { $x }(Target), Target,
            'from :U smiley';
        is-deeply -> Target:U(Any)      $x { $x }(Target), Target,
            'from Any';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Any:D)    $x { $x }(Target), Target,
            'from Any:D';
        is-deeply -> Target:U()         $x { $x }(Target), Target,
            'from implied Any';
    }
}

# vim: ft=perl6
