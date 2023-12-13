use v6.e.PREVIEW;
use Test;
use nqp;

plan 1;

subtest "Nominalizable generic" => {
    plan 6;
    my \r = my role R[::T] {
        my package G {
            class A is Array[T] {}
        }
        my T $v .= new;
        has @.a is G::A;
        method t-nominalizables { T:D, T:U, T(), T:D() }
        method a-nominalizables { G::A:D, G::A:U, G::A(), G::A:D() }
        method vv { self.^name ~ ":" ~ $v.raku }
    }

    my class CInt does R[Int] { }
    my class CStr does R[Str] { }

    is-deeply CInt.t-nominalizables, (Int:D, Int:U, Int(), Int:D()), "instantiated";
    is-deeply CStr.t-nominalizables, (Str:D, Str:U, Str(), Str:D()), "instantiating over different type";

    is CInt.a-nominalizables.map(*.^name).List,
       ("R::G::A[Int]:D", "R::G::A[Int]:U", "R::G::A[Int](Any)", "R::G::A[Int]:D(Any)"),
       "generic class instantiates";
    is CStr.a-nominalizables.map(*.^name).List,
       ("R::G::A[Str]:D", "R::G::A[Str]:U", "R::G::A[Str](Any)", "R::G::A[Str]:D(Any)"),
       "generic class instantiates over different type";

    sub test-assign(Mu \type, @good-data, @bad-data) is test-assertion {
        subtest "Typecheck for " ~ type.^name, {
            plan 5;
            my $obj;
            lives-ok
                { $obj = type.new(a => @good-data) },
                "positional attribute can be initialized with correct value types";
            is-deeply $obj.a.List, @good-data.List, "initialization is successfull";
            my @good-reversed := @good-data.reverse.List;
            lives-ok { $obj.a = @good-reversed }, "can assign with correct value types";
            is-deeply $obj.a.List, @good-reversed, "assignment is successfull";
            throws-like
                { type.new(a => @bad-data); },
                X::TypeCheck::Assignment,
                "wrong value types result in exception";
        }
    }

    test-assign CInt, (1,10,20,42), <A B C>;
    test-assign CStr, <A B C D>, (13, 666);
}

# vim: expandtab shiftwidth=4 ft=raku
