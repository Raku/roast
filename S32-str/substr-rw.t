use v6;

use Test;

sub l (Int $a) {  my $l = $a; return $l }

{
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");

    {
        my $r = substr-rw($str, 0, 5);
        is($r, "gloop", '$r referent is eq to the substr-rwing');

        #?pugs todo 'scalarrefs are not handled correctly'
        $r = "boing";
        is($str, "boing ding", "assignment to reference modifies original");
        is($r, "boing", '$r is consistent');

        #?pugs todo 'scalarrefs are not handled correctly'
        my $o = substr-rw($str, 3, 2);
        is($o, "ng", "other ref to other lvalue");
        $r = "foo";
        #?pugs todo
        is($str, "foo ding", "lvalue ref size varies but still works");
        #?pugs todo
        is($o, " d", "other lvalue wiggled around");
    }

}

#?rakudo skip 'substr-rw as lvalue NYI'
{ # as lvalue, should work
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");
};

#?rakudo skip "substr-rw as lvalue NYI"
{ # as lvalue, using :=, should work
    #?rakudo 3 todo 'exception'
    my $str = "gorch ding";

    substr-rw($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");

    my $r := substr-rw($str, 0, 5);
    is($r, "gloop", 'bound $r is eq to the substr-rwing');

    $r = "boing";
    is($str, "boing ding", "assignment to bound var modifies original");
    #?pugs todo 'bug'
    is($r, "boing", 'bound $r is consistent');

    my $o := substr-rw($str, 3, 2);
    #?rakudo 3 todo ' substr-rw lvalue binding'
    is($o, "ng", "other bound var to other lvalue");
    $r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works");
    #?pugs todo 'bug'
    is($o, " d", "other lvalue wiggled around");
};

#?rakudo skip "substr-rw as lvalue NYI"
{
    my $str = "gorch ding";

    substr-rw($str, 0, l(5)) = "gloop";
#?rakudo todo "substr-rw as lvalue"
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, StrLen)).");

    {
        my $r = \substr-rw($str, 0, l(5));
        ok(WHAT($r).gist, '$r is a reference (substr-rw(Int, StrLen)).');
        is($$r, "gloop", '$r referent is eq to the substr-rwing (substr-rw(Int, StrLen)).');

    #?pugs todo 'scalarrefs are not handled correctly'
        $$r = "boing";
        is($str, "boing ding", "assignment to reference modifies original (substr-rw(Int, StrLen)).");
        is($$r, "boing", '$r is consistent (substr-rw(Int, StrLen)).');

    #?pugs todo 'scalarrefs are not handled correctly'
        my $o = \substr-rw($str, 3, l(2));
        is($$o, "ng", "other ref to other lvalue (substr-rw(Int, StrLen)).");
        $$r = "foo";
        #?pugs todo
        is($str, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, StrLen)).");
        #?pugs todo
        is($$o, " d", "other lvalue wiggled around (substr-rw(Int, StrLen)).");
    }

}

#?rakudo skip 'substr-rw as lvalue NYI'
{ # as lvalue, should work
    my $str = "gorch ding";

    substr-rw($str, 0, l(5)) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, StrLen)).");
};

#?rakudo skip 'substr-rw as lvalue NYI'
{ # as lvalue, using :=, should work
    #?rakudo 3 todo 'substr-rw as lvalue NYI'
    my $str = "gorch ding";

    substr-rw($str, 0, l(5)) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string (substr-rw(Int, StrLen)).");

    my $r := substr-rw($str, 0, l(5));
    is($r, "gloop", 'bound $r is eq to the substr-rwing (substr-rw(Int, StrLen)).');

    $r = "boing";
    is($str, "boing ding", "assignment to bound var modifies original (substr-rw(Int, StrLen)).");
    #?pugs todo 'bug'
    is($r, "boing", 'bound $r is consistent (substr-rw(Int, StrLen)).');

    my $o := substr-rw($str, 3, l(2));
    #?rakudo 3 todo ' substr-rw lvalue binding'
    is($o, "ng", "other bound var to other lvalue (substr-rw(Int, StrLen)).");
    $r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works (substr-rw(Int, StrLen)).");
    #?pugs todo 'bug'
    is($o, " d", "other lvalue wiggled around (substr-rw(Int, StrLen)).");
};

done;
