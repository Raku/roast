use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

subtest "Basic Coercive Return", {
    plan 9;
    my sub return-as-str($x --> Str(Numeric:D)) { $x }

    is return-as-str(42), "42", "return coerces an Int";
    is return-as-str(42.12), "42.12", "return coerces a Rat";
    is return-as-str(1e0), 1e0.Str, "return coerces a Num";
    is return-as-str("The Answer"), "The Answer", "as string is bypassed as-is";
    is return-as-str(Nil), Nil, "Nil is returned as-is";
    isa-ok return-as-str(my $f = Failure.new), Failure, "a Failure is returned as-is";
    $f.so; # Defuse the Failure

    throws-like { return-as-str(Int) }, X::TypeCheck::Return, "can't return a type object";
    throws-like { return-as-str([1,2]) }, X::TypeCheck::Return, "can't return a non-Numeric";

    my class ANumeric does Numeric {
        method Str { 13 }
    }
    #?rakudo.jvm todo "code doesn't die"
    throws-like
        { return-as-str(ANumeric.new) },
        X::Coerce::Impossible,
        "incorrect coercion throws too";
}

subtest "COERCE-based coercion for returns", {
    plan 5;
    my class Foo {
        has $.val;
        multi method COERCE(Num) { Foo }
        multi method COERCE($val) { self.new(:$val) }
    }

    my sub return-as-Foo($x --> Foo:D()) { $x }

    #?rakudo.jvm todo 'got 42'
    is-deeply return-as-Foo(42), Foo.new(:val(42)), "COERCE works with a concrete value";
    #?rakudo.jvm todo 'got Str'
    is-deeply return-as-Foo(Str), Foo.new(:val(Str)), "COERCE works with a type object";
    is return-as-Foo(Nil), Nil, "Nil is returned as-is";
    isa-ok return-as-Foo(my $f = Failure.new), Failure, "a Failure is returned as-is";
    $f.so; # Defuse the Failure

    #?rakudo.jvm todo "code doesn't die"
    throws-like
        { return-as-Foo(pi) },
        X::Coerce::Impossible,
        "coercion into a typeobject fails for a definite target";
}

subtest "Coercive subset", {
    plan 5;
    # Make some definitely coercive subset!
    # my subset Bar of Str:D(Numeric) where *.chars > 3;
    my subset Bar of Str:D(Numeric) where *.chars > 3;

    my sub return-as-subset($x --> Bar) { $x }

    is return-as-subset(12345), "12345", "basic coercion works";
    is return-as-subset(Nil), Nil, "Nil is returned as-is";
    isa-ok return-as-subset(my $f = Failure.new), Failure, "a Failure is returned as-is";
    $f.so; # Defuse the Failure

    throws-like
        { return-as-subset(13) },
        X::TypeCheck::Return,
        "can't return a coercion of value not passing subset constraint";

    throws-like
        { quietly return-as-subset(Int) },
        X::TypeCheck::Return,
        "can't return a coercion of a typeobject for a definite subset";
}

subtest "Coerce into a subset", {
    plan 5;
    my subset SmallVal of Rat where { .abs < 0.5 };

    my sub return-as-subset($x --> SmallVal:D()) { $x }

    is return-as-subset("0.2"), 0.2, "basic coercion works";
    is return-as-subset(Nil), Nil, "Nil is returned as-is";
    isa-ok return-as-subset(my $f = Failure.new), Failure, "a Failure is returned as-is";
    $f.so; # Defuse the Failure

    #?rakudo.jvm 2 todo "code doesn't die"
    throws-like
        { return-as-subset("1.3") },
        X::Coerce::Impossible,
        "can't return a coercion of value not passing subset constraint";

    throws-like
        { return-as-subset(1.3) },
        X::Coerce::Impossible,
        "can't return a value not passing subset constraint";
}

subtest "Errors", {
    plan 2;

    my class NastyCoercer {
        multi method COERCE(Str) { ::?CLASS }
    }

    my sub return-as-definite($x --> NastyCoercer:D()) { $x }

    #?rakudo.jvm 2 todo "code doesn't die"
    throws-like
        { return-as-definite("foo"); },
        X::Coerce::Impossible,
        "class coercer doesn't give us a definite";

    throws-like
        { return-as-definite(13); },
        X::Coerce::Impossible,
        "class coercer doesn't provide a coercion method";
}

done-testing;
