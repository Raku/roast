use Test;

plan 46;

{
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");

    {
        my $r := substr-rw($str, 0, 5);
        is($r, "gloop", '$r referent is eq to the substr-rwing');

        $r = "boing";
        is($str, "boing ding", "assignment to reference modifies original");
        is($r, "boing", '$r is consistent');

        my $o := substr-rw($str, 3, 2);
        is($o, "ng", "other ref to other lvalue");
        $r = "foo";
        is($str, "foo ding", "lvalue ref size varies but still works");
        is($o, " d", "other lvalue wiggled around");
    }

}

{ # as lvalue, should work
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");
};

{ # as lvalue, using :=, should work
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");

    my $r := substr-rw($str, 0, 5);
    is($r, "gloop", 'bound $r is eq to the substr-rwing');

    $r = "boing";
    is($str, "boing ding", "assignment to bound var modifies original");
    is($r, "boing", 'bound $r is consistent');

    my $o := substr-rw($str, 3, 2);
    is($o, "ng", "other bound var to other lvalue");
    $r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works");
    is($o, " d", "other lvalue wiggled around");
};

{
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");

    {
        my $r := substr-rw($str, 0, 5);
        ok(WHAT($r).gist, '$r is a reference (substr-rw(Int, Int)).');
        is($$r, "gloop", '$r referent is eq to the substr-rwing (substr-rw(Int, Int)).');

        $$r = "boing";
        is($str, "boing ding", "assignment to reference modifies original (substr-rw(Int, Int)).");
        is($$r, "boing", '$r is consistent (substr-rw(Int, Int)).');

        my $o := substr-rw($str, 3, 2);
        is($$o, "ng", "other ref to other lvalue (substr-rw(Int, Int)).");
        $$r = "foo";
        is($str, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, Int)).");
        is($$o, " d", "other lvalue wiggled around (substr-rw(Int, Int)).");
    }

}

{ # as lvalue, should work
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");
};

{ # as lvalue, using :=, should work
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, Int)).");

    my $r := substr-rw($str, 0, 5);
    is($r, "gloop", 'bound $r is eq to the substr-rwing (substr-rw(Int, Int)).');

    $r = "boing";
    is($str, "boing ding", "assignment to bound var modifies original (substr-rw(Int, Int)).");
    is($r, "boing", 'bound $r is consistent (substr-rw(Int, Int)).');

    my $o := substr-rw($str, 3, 2);
    is($o, "ng", "other bound var to other lvalue (substr-rw(Int, Int)).");
    $r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, Int)).");
    is($o, " d", "other lvalue wiggled around (substr-rw(Int, Int)).");
};

{
    my $str = 'foo';
    $str.substr-rw(2,1) = 'x';
    is($str, 'fox', 'method form of substr-rw works');
};

{ # ranges

    my $str = 'foo';
    substr-rw($str, 2..2) = 'x';
    is($str, 'fox', 'substr-rw with a Range should work');

    substr-rw($str, 1..2) = 'at';
    is($str, 'fat', 'Str.substr-rw with a Range should work');

    substr-rw($str, 0..^1) = 'h';
    is($str, 'hat', 'Str.substr-rw with a Range should work');

    substr-rw($str, 0^..1) = 'o';
    is($str, 'hot', 'Str.substr-rw with a Range should work');

    substr-rw($str, 0^..^1) = 'o';
    is($str, 'hoot', 'Str.substr-rw with a Range should work');

}

# https://github.com/Raku/old-issue-tracker/issues/2868
{
    my $str = 'ab';
    substr-rw($str, 0, 3) = '/';
    is "--$str--", '--/--',
        'substr-rw handles end positions that are out of range';
}

# https://github.com/Raku/old-issue-tracker/issues/4321
{
    my $s = 'foobar';
    $s.substr-rw(3, 3) = 1;
    is $s, 'foo1', 'assigning a non-string coerces';
}

# https://github.com/Raku/old-issue-tracker/issues/5198
{
    my $s = '.' x 4 ~ 'a';
    $s.substr-rw(1,1) = '';
    is $s, '...a', '.substr-rw on a string constructed with `x` operator';
}

# https://github.com/rakudo/rakudo/issues/1720
{
    my $a = "foobaz";
    $a.substr-rw(3, 3.3) = "bar";
    is $a, "foobar", 'Non-int width ok';

    $a.substr-rw(3, *) = "baz";
    is $a, "foobaz", 'Whatever as width ok';

    $a.substr-rw(3, Inf) = "bar";
    is $a, "foobar", 'Inf as width ok';

    $a.substr-rw(3, *-3) = "baz";
    is $a, "foobazbar", 'Callable as width ok';
}

# https://github.com/rakudo/rakudo/issues/5677
{
    my $s = "foobar";
    $s.substr-rw(6, 0) = "yyy";
    is $s, 'foobaryyy', 'can we append using substr-rw';
}

# https://github.com/rakudo/rakudo/issues/5726 (Format::Lisp)
{
    my $a = "foobar";
    $a.substr-rw(*-3, 3) = "zzz";
    is $a, "foozzz", "can we replace with Callable as first arg";
}

# vim: expandtab shiftwidth=4
