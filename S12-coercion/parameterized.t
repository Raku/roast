use v6;
use Test;

# Test for coercions in parametric roles
# GH rakudo/rakudo#1285 https://github.com/rakudo/rakudo/issues/1285

plan 2;

subtest "Basics" => {
    plan 4;
    my role R[::T] {
        method foo(T $var) {
            $var
        }
    }

    my class C1 does R[Str:D(Numeric)] { }

    my $obj = C1.new;

    is $obj.foo(pi), pi.Str, "coercion successful";
    throws-like { $obj.foo([1,2]) },
                X::TypeCheck::Binding::Parameter,
                "uncoercible parameter results in X::Coerce::Impossible exception";

    my class StrContainer {
        has Str:D $.value is required;
        # Coerce from any value by stringifying it.
        method COERCE(::?CLASS:U: Any:D $v) {
            # Note the use of `self` here. This is to support coercion 'inheritance' by children. I.e. for
            #    class Bar is StrContainer { ... }
            # Bar(Any) would work nearly the same as StrContainer(Any) because COERCE method will return an instance of
            # Bar. Alternatively, use of StrContainer.new would result in "impossible coercion" error because
            #     StrContainer !~~ Bar
            self.new: :value($v.Str)
        }
    }

    my class C2 does R[StrContainer:D(Int)] { }

    $obj = C2.new;

    my $scont = $obj.foo(42);
    isa-ok $scont, StrContainer, "Coerced into the helper class";
    is $scont.value, "42", "coercion done correctly";
}

subtest "Double Parameterization" => {
    plan 2;
    my role R[::T1, ::T2] {
        method foo(T1 $var1, T2 $var2) {
            $var1, $var2
        }
    }

    my class C1 does R[Int:D(Str), Bool(Any)] { }

    my $obj = C1.new;

    is-deeply $obj.foo("42", 0), (42, False), "coercion successful";
    throws-like { $obj.foo([1,2], 1) },
                X::TypeCheck::Binding::Parameter,
                "uncoercible parameter results in X::Coerce::Impossible exception";
}

done-testing;
