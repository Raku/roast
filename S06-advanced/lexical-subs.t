use v6;

use Test;

plan 11;

{
    sub f() {
        my sub g(){"g"}; my sub h(){g()}; h();
    };
    is(f(), 'g', 'can indirectly call lexical sub');
    eval_dies_ok('g', 'lexical sub not visible outside current scope');
}

{
    sub foo($x) { $x + 1 }

    sub callit(&foo) {
        foo(1);
    }

    is(foo(1), 2, 'calls subs passed as &foo parameter');
    is(callit({ $^x + 2 }), 3, "lexical subs get precedence over package subs");
}

#?rakudo skip 'cannot parse operator names yet'
{
    sub infix:<@@> ($x, $y) { $x + $y }

    sub foo2(&infix:<@@>) {
        2 @@ 3;
    }

    is(2 @@ 3, 5);
    is(foo2({ $^a * $^b }), 6);
}

{
    my sub test_this {     #OK not used
        ok 1, "Could call ok from within a lexical sub";
        return 1;
    }
    EVAL 'test_this()';
    if ($!) {
        ok 0, "Could call ok from within a lexical sub";
    }
}

# RT #65498
{
    sub a { 'outer' };
    {
        my sub a { 'inner' };
        is a(), 'inner', 'inner lexical hides outer sub of same name';
    }
    is a(), 'outer', '... but only where it is visisble';
}

{
    package TestScope {
        sub f { };
    }
    dies_ok { TestScope::f }, 'subs without scoping modifiers are not entered in the namespace';
}

# RT #57788
{
    eval_dies_ok 'sub a { }; sub a { }';
}

# vim: ft=perl6 :
