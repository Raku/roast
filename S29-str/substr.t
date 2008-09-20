use v6;

use Test;

plan 42;

# L<S29/Str/=item substr>

{ # read only
    my $str = "foobar";

    is(substr($str, 0, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($str, 3, 0), '', 'Empty string with 0 as thrid arg');
    is(substr($str, 0, 1), "f", "first char");
    is(substr($str, -1), "r", "last char");
    is(substr($str, -4, 2), "ob", "counted from the end");
    is(substr($str, 1, 2), "oo", "arbitrary middle");
    is(substr($str, 3), "bar", "length omitted");
    is(substr($str, 3, 10), "bar", "length goes past end");
#?rakudo 2 skip 'exception'
    ok(!defined(substr($str, 20, 5)), "substr outside of string");
    ok(!defined(substr($str, -100, 10)), "... on the negative side");

    is(substr($str, 0, -2), "foob", "from beginning, with negative length");
    is(substr($str, 2, -2), "ob", "in middle, with negative length");
    is(substr($str, 3, -3), "", "negative length - gives empty string");

    is($str, "foobar", "original string still not changed");
};

#?pugs skip 'more discussion needed'
#?rakudo skip 'too many args'
{ # replacement
    my $str = "foobar";

    substr($str, 2, 1, "i");
    is($str, "foibar", "fourth arg to substr replaced part");

    substr($str, -1, 1, "blah");
    is($str, "foibablah", "longer replacement expands string");

    substr($str, 1, 3, "");
    is($str, "fablah", "shorter replacement shrunk it");

    substr($str, 1, -1, "aye");
    is($str, "fayeh", "replacement with negative length");
};

# as lvalue, XXX: not sure this should work, as that'd be action at distance:
#   my $substr = \substr($str, ...);
#   ...;
#   some_func $substr; # manipulates $substr
#   # $str altered!
# But one could think that's the wanted behaviour, so I leave the test in.
{
    my $str = "gorch ding";

    substr($str, 0, 5) = "gloop";
#?rakudo todo "substr as lvalue"
    is($str, "gloop ding", "lvalue assignment modified original string");

#?rakudo skip "can't parse"
{
    my $r = \substr($str, 0, 5);
    ok(~WHAT($r), '$r is a reference');
    is($$r, "gloop", '$r referent is eq to the substring');

#?pugs todo 'scalarrefs are not handled correctly'
    $$r = "boing";
    is($str, "boing ding", "assignment to reference modifies original");
    is($$r, "boing", '$r is consistent');

#?pugs todo 'scalarrefs are not handled correctly'
    my $o = \substr($str, 3, 2);
    is($$o, "ng", "other ref to other lvalue");
    $$r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works");
    is($$o, " d", "other lvalue wiggled around");
}

};

#?rakudo todo 'exception'
{ # as lvalue, should work
    my $str = "gorch ding";

    substr($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");
};

#?rakudo todo 'exception'
{ # as lvalue, using :=, should work
    my $str = "gorch ding";

    substr($str, 0, 5) = "gloop";
    is($str, "gloop ding", "lvalue assignment modified original string");

    my $r := substr($str, 0, 5);
    is($r, "gloop", 'bound $r is eq to the substring');

    $r = "boing";
    is($str, "boing ding", "assignment to bound var modifies original");
    #?pugs todo 'bug'
    is($r, "boing", 'bound $r is consistent');

    my $o := substr($str, 3, 2);
    is($o, "ng", "other bound var to other lvalue");
    $r = "foo";
    is($str, "foo ding", "lvalue ref size varies but still works");
    #?pugs todo 'bug'
    is($o, " d", "other lvalue wiggled around");
};

{ # misc
    my $str = "hello foo and bar";
    is(substr($str, 6, 3), "foo", "substr");
    is($str.substr(6, 3), "foo", ".substr");
    is(substr("hello foo bar", 6, 3), "foo", "substr on literal string");
    is("hello foo bar".substr(6, 3), "foo", ".substr on literal string");
    is("hello foo bar".substr(6, 3).uc, "FOO", ".substr.uc on literal string");
    is("hello foo bar and baz".substr(6, 10).capitalize, "Foo Bar An", ".substr.capitalize on literal string");
    is("hello »« foo".substr(6, 2), "»«", ".substr on unicode string");
    is("שיעבוד כבר".substr(4, 4), "וד כ", ".substr on Hebrew text");
}

