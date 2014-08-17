use v6;

use Test;

plan 20;

# TODO: *really* need a better smartlink
# L<S02/Bare identifiers/"If the unrecognized subroutine name">

# These tests are for parse-fails:
# (They check that the parser doesn't abort, but they might still parse
#  incorrectly.)
{
    sub foo(*@args, *%named) { 1 }    #OK not used

    ok EVAL(q/foo;      /), 'call with no args, no parens';
    ok EVAL(q/foo();    /), 'call with no args, has parens';
    ok EVAL(q/&foo.();   /), 'call with no args, has dot and parens';
    ok EVAL(q/&foo\ .(); /), 'call with no args, has long dot and parens';

    ok EVAL(q/foo 1;    /), 'call with one arg, no parens';
    ok EVAL(q/foo(1);   /), 'call with one arg, has parens';
    ok EVAL(q/&foo.(1);  /), 'call with one arg, has dot and parens';
    ok EVAL(q/&foo\ .(1);/), 'call with one arg, has long dot and parens';
    throws_like { EVAL q/foo'bar'; / },
      X::Syntax::Confused,
      'call with one arg, has no space and no parens';

    ok EVAL(q/foo 1, 2; /), 'call with two args, no parens';
    ok EVAL(q/foo(1, 2);/), 'call with two args, has parens';

    throws_like { EVAL q/foo:bar;  / },
      X::Undeclared::Symbols,
      'call with adverb after no space';
    ok EVAL(q/foo :bar; /), 'call with adverb after space';

    ok EVAL(q/foo(:bar);  /), 'call with adverb in parens';
    ok EVAL(q/&foo.(:bar); /), 'call with adverb in dotted-parens';
    ok EVAL(q/&foo\.(:bar);/), 'call with adverb in long-dotted parens';
}


# These tests are for mis-parses:
{
    sub succ($x) { $x + 1 }

    is(EVAL(q/succ  (1+2) * 30;/),  91, "parens after space aren't call-parens");
    $_ = sub ($x) { $x - 1 };
    is (succ .(1+2) * 30), 61, 'parsed as method call on $_';
}
{
    sub first() { "first" }

    is(EVAL(q/first.uc/), 'FIRST', '`first.second` means `(first()).second()`');
}

{
    is(EVAL(q/"hello".substr: 1, 2/), "el", "listop method");

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
