use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 11;

subtest "When refinement is an expression value", {
    plan 3;

    throws-like { my subset F where 5; my F $f = 6}, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset throws when constraint is not met";

    lives-ok { my subset F where 5; my F $f = 5 },
        "Assignment to a scalar type-constrained to a subset lives";

    throws-like { my subset F where 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When refinement is a regex", {
    plan 3;

    throws-like { my subset F where /5/; my F $f = '6' }, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset lives";

    lives-ok { my subset F where /5/; my F $f = '5' },
        "Assignment to a scalar type-constrained to a subset works with bare expression";

    throws-like { my subset F where /5/; -> F $ {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When refinement is a block", {
    plan 3;

    throws-like { my subset F where { $_ ~~ 5 }; my F $f = '6' }, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset throws when constraint is not met";

    lives-ok { my subset F where { $_ ~~ 5 }; my F $f = '5' },
        "Assignment to a scalar type-constrained to a subset lives";

    throws-like { my subset F where { $_ ~~ 5 }; -> F $ {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When refinement has a Whatever", {
    plan 3;

    throws-like { my subset F where * == 5; my F $f = 6 }, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset throws when constraint is not met";

    lives-ok { my subset F where * == 5; my F $f = 5 },
        "Assignment to a scalar type-constrained to a subset lives";

    throws-like { my subset F where * == 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When refinement has a Whatever with a Smartmatch", {
    plan 3;

    throws-like { my subset F where * ~~ 5; my F $f = '6' }, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset throws when constraint is not met";

    lives-ok { my subset F where * ~~ 5; my F $f = '5' },
        "Assignment to a scalar type-constrained to a subset lives";

    throws-like { my subset F where * ~~ 5; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When refinee is specified", {
    plan 3;

    throws-like { my subset F of Int where { $_ ~~ 5 }; my F $f = '5' }, X::TypeCheck::Assignment,
        "Assignment to scalar type-constrained to a subset throws when constraint is not met";

    lives-ok { my subset F of Int where { $_ ~~ 5 }; my F $f = 5 },
        "Assignment to a scalar type-constrained to a subset lives";

    throws-like { my subset F of Int where { $_ ~~ 5 }; -> F $f {}(6)}, X::TypeCheck::Binding::Parameter,
        "Parameter type-constrained to a subset throws when constraint is not met";
};

subtest "When used with smartmatch", {
    plan 2;
    my subset F where 5;

    ok 5 ~~ F, "Smartmatch on subset that passes refinement is ok";
    nok 6 ~~ F, "Smartmatch on subset that doesn't pass refinement is not ok";
}

subtest "When a subset is created with the name of a stubbed package", {
    plan 2;

    is_run 'class F::B {}; subset F where 5',
        { :exitcode(0), },
        "Can create subset with a name that exists as a stubbed package";
    is_run 'class F::B {}; subset F where 5; die unless F::.keys.grep("B");',
        { :exitcode(0) },
        "The WHO package is stolen from the replaced stubbed package";
}

subtest "When a subset is declared within a module", {
    plan 4;

    is_run 'module M { my subset F where 5 }; my M::F $f = 5',
        { :exitcode(1), :err({ .contains: 'Malformed my' }), },
        "'my' scoped subset in a module is unavailable outside the module";

    is_run 'module M { subset F where 5 }; my M::F $f = 5',
        { :exitcode(0), },
        "'our' scoped subset in a module is available outside the module";

    is_run 'my module M { subset F where 5 }; my M::F $f = 5',
        { :exitcode(0), },
        "'our' scoped subset in a module is available outside a my-scoped module";

    is_run 'my subset P::F where 5; my P::F $f = 5',
        { :exitcode(0), },
        "Subset with a stubby package in their name resolve correctly";
}

subtest "When a subset has no where block", {
    plan 3;

    is_run 'subset MyInt of Int; my MyInt $f = 5',
        { :exitcode(0), },
        "subset with of but no where succeeds when type constraint met";

    #?rakudo todo 'in RakuAST this is a compile time error, not runtime'
    is_run 'subset MyInt of Int; my MyInt $f = 5.0',
        { :exitcode(1), :err({ .contains: 'Cannot assign a literal of type Rat' }), },
        "subset with of but no where fails when type constraint not met";

    is_run 'my Str subset MyStr; die unless Str ~~ MyStr',
        { :exitcode(0), },
        "subset form 'my Str subset MyStr' creates essentially a type alias";
}

subtest "When a subset is a subset of a subset", {
    plan 2;

    is_run 'subset F of Int where * %% 2; subset G of F where * %% 3; my G $g = 6',
        { :exitcode(0), },
        "Subset works as 'of' of a subset (assignment meets criteria)";

    is_run 'subset F of Int where * %% 2; subset G of F where * %% 3; my $n = 9; my G $g = $n',
        { :exitcode(1), :err({ .contains: 'Type check failed in assignment ' }), },
        "Subset works as 'of' of a subset (assigment fails criteria)";
}

done-testing;
