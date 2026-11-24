use Test;

plan 3;

# XXX: We depend on EVAL a lot here because errors can occur at compile-time.
# This propagates, unfortunately.

# Our tests need messages, but we're dealing with generics here.
sub accepts-ok(Mu $a is raw, Mu $b is raw) is test-assertion {
    cmp-ok($a, &[~~], $b, "$a.raku() ~~ $b.raku()")
}
sub accepts-nok(Mu $a is raw, Mu $b is raw) is test-assertion {
    cmp-ok($a, &[!~~], $b, "$a.raku() !~~ $b.raku()")
}

#|[ Tests typechecking on a collection of parametric types. ]
sub cmp-ins(
    #|[ A generic parametric type. ]
    Mu \T,
    #|[ A generic parametric subtype of T. ]
    Mu \U,
    #|[ A parameter too wide for U. ]
    Mu \A,
    #|[ A parameter valid for both T and U. ]
    Mu \B,
    #|[ A parameter narrower than U calls for, but is still valid. ]
    Mu \C,
--> Nil) is test-assertion {
    EVAL(Q:to/TESTS/);
    my constant R1 = T;
    my constant R2 = U;
    accepts-nok(R2, R1);
    accepts-ok(R2[B], R1);
    accepts-ok(R2[B], R2);
    accepts-nok(R1[A], R2[B]);
    accepts-ok(R2[B], R1[A]);
    accepts-ok(R2[B], R2[B]);
    accepts-ok(R2[C], R2[B]);
    accepts-nok(R2[B], R2[C]);
    TESTS
}

subtest 'composition', {
    plan 33;

    lives-ok({ EVAL(Q:to/ROLES/) }, 'can do subtyped generic roles');
    role R1[Any ::T] {
        method level(::?CLASS: --> 1) { }
    }
    role R2[Cool ::T] does R1[T] {
        method level(::?CLASS: --> 2) { }
    }
    ROLES
    EVAL(Q:to/COMPARE/);
    cmp-ins(R1, R2, Any, Cool, List);
    COMPARE
    lives-ok({ EVAL(Q:to/CALL/) }, 'dispatch does not die');
    ok(R2[Cool].level == 2, 'dispatch is reasonable');
    CALL

    lives-ok({ EVAL(Q:to/ROLE/) }, 'chaining generic doees is OK');
    role R3[List ::T] does R2[T] {
        method level(::?CLASS: --> 3) { }
    }
    ROLE
    EVAL(Q:to/COMPARE/);
    cmp-ins(R1, R3, Cool, List, Array);
    cmp-ins(R2, R3, Cool, List, Array);
    COMPARE
    lives-ok({ EVAL(Q:to/CALL/) }, 'dispatch still does not die');
    ok(R3[List].level == 3, 'dispatch is still reasonable');
    CALL

    lives-ok({ EVAL(Q:to/TRAIT/) }, 'can lookup roles of subtyped generic roles done by roles before they get composed');
    multi sub trait_mod:<is>(Mu:U \T, :ok($)!) { T.^roles[0].^roles }
    my role WithTrait[Int ::T] does R1[T] is ok { }
    TRAIT

    lives-ok({ EVAL(Q:to/ENUM/) }, 'an enum is fine too');
    my enum Index <A B C>;
    my role OfIndex[Index ::T] does T { }
    accepts-ok(OfIndex[Index], Index);
    ENUM
};

subtest 'inheritance', {
    plan 30;

    lives-ok({ EVAL(Q:to/ROLES/) }, 'can inherit from subtyped generic roles');
    role R4[Any ::T] {
        proto method level(::?CLASS: --> Int:D) {*}
        multi method level(::?CLASS: --> 4) { }
    }
    role R5[Iterable ::T] is R4[T] {
        multi method level(::?CLASS: --> 5) { }
    }
    ROLES
    EVAL(Q:to/COMPARE/);
    cmp-ins(R4, R5, Any, Iterable, List);
    COMPARE
    lives-ok({ EVAL(Q:to/CALL/) }, 'dispatch does not die');
    ok(R5[Iterable].level == 5, 'dispatch selects the correct candidate');
    CALL

    lives-ok({ EVAL(Q:to/ROLE/) }, 'chaining generic parents is OK');
    role R6[List ::T] is R5[T] {
        multi method level(::?CLASS: --> 6) { }
    }
    ROLE
    EVAL(Q:to/COMPARE/);
    cmp-ins(R4, R6, Iterable, List, Array);
    cmp-ins(R5, R6, Iterable, List, Array);
    COMPARE
    lives-ok({ EVAL(Q:to/CALL/) }, 'dispatch still does not die');
    ok(R6[List].level == 6, 'dispatch still selects the correct candidate');
    CALL
};

subtest 'complex', {
    plan 19;

    lives-ok({ EVAL(Q:to/ROLE/) }, 'an unholy mixin of R1-R6 is OK');
    role R7[Array ::T] does R3[T] is R6[T] { }
    ROLE
    EVAL(Q:to/COMPARE/);
    cmp-ins(R3, R7, List, Array, Array[Complex]);
    cmp-ins(R6, R7, List, Array, Array[Complex]);
    COMPARE
    lives-ok({ EVAL(Q:to/CALL/) }, 'dispatch can cope with this');
    ok(R7[Array].level == 3, 'dispatch is reasonable');
    CALL
};

# vim: expandtab shiftwidth=4
