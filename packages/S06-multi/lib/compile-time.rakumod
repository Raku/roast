unit module compile-time;
no precompilation;
use Test;

class C1 {
    proto method foo (|) {*}
    multi method foo (Mu $c) {
        "C1::foo(Mu)"
    }
}

class C2 is C1 {
    multi method foo (Any $c) {
        "C2::foo(Any)"
    }
}

BEGIN {
    # GH 2772: Rakudo was chosing C1::foo(Mu) before the fix
    is C2.new.foo(Any), "C2::foo(Any)", "candidate choice for child class";
    is C1.new.foo(Any), "C1::foo(Mu)", "candidate choice for parent class";
}

# vim: expandtab shiftwidth=4
