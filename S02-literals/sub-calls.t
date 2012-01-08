use v6;

use Test;

plan 20;

# TODO: *really* need a better smartlink
# L<S02/Bare identifiers/"If the unrecognized subroutine name">

#?pugs emit if $?PUGS_BACKEND ne "BACKEND_PUGS" {
#?pugs emit   skip_rest "PIL2JS and PIL-Run do not support eval() yet.";
#?pugs emit   exit;
#?pugs emit }

# These tests are for parse-fails:
# (They check that the parser doesn't abort, but they might still parse
#  incorrectly.)
{
    sub foo(*@args, *%named) { 1 }    #OK not used

    ok eval(q/foo;      /), 'call with no args, no parens';
    ok eval(q/foo();    /), 'call with no args, has parens';
    ok eval(q/&foo.();   /), 'call with no args, has dot and parens';
    ok eval(q/&foo\ .(); /), 'call with no args, has long dot and parens';

    ok eval(q/foo 1;    /), 'call with one arg, no parens';
    ok eval(q/foo(1);   /), 'call with one arg, has parens';
    ok eval(q/&foo.(1);  /), 'call with one arg, has dot and parens';
    ok eval(q/&foo\ .(1);/), 'call with one arg, has long dot and parens';
    #?pugs todo 'unspecced'
    dies_ok { eval(q/foo'bar'; /) }, 'call with one arg, has no space and no parens';

    ok eval(q/foo 1, 2; /), 'call with two args, no parens';
    ok eval(q/foo(1, 2);/), 'call with two args, has parens';

    #?rakudo skip 'should parse as a routine foo:bar'
    #?niecza skip 'Undeclared routine "foo:bar"'
    ok eval(q/foo:bar;  /), 'call with adverb after no space';
    ok eval(q/foo :bar; /), 'call with adverb after space';

    ok eval(q/foo(:bar);  /), 'call with adverb in parens';
    ok eval(q/&foo.(:bar); /), 'call with adverb in dotted-parens';
    ok eval(q/&foo\.(:bar);/), 'call with adverb in long-dotted parens';
}


# These tests are for mis-parses:
{
    sub succ($x) { $x + 1 }

    is(eval(q/succ  (1+2) * 30;/),  91, "parens after space aren't call-parens");
    nok(try {eval(q/succ .(1+2) * 30;/) }, 'parsed as method call on $_');
}
{
    sub first() { "first" }

    is(eval(q/first.uc/), 'FIRST', '`first.second` means `(first()).second()`');
}

{
    is(eval(q/"hello".substr: 1, 2/), "el", "listop method");

    # foo $bar.baz: quux
    # should be (and is currently) interpreted as:
    # foo($bar.baz(quux))
    # where the alternate interpretation can be achieved by:
    # foo ($bar.baz): quux
    # which is interpreted as
    # $bar.baz.foo(quux)
    # but we need tests, tests, tests! XXX
}

# vim: ft=perl6
