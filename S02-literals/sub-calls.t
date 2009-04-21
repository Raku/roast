use v6;

use Test;

plan 20;

# TODO: *really* need a better smartlink
# L<S02/Literals/"If the unrecognized subroutine name">

# Since these are all parsing tests, they should use eval to ensure all tests
# can run even if something is broken.  (Unless things are VERY broken.)

#?pugs emit if $?PUGS_BACKEND ne "BACKEND_PUGS" {
#?pugs emit   skip_rest "PIL2JS and PIL-Run do not support eval() yet.";
#?pugs emit   exit;
#?pugs emit }

# These tests are for parse-fails:
# (They check that the parser doesn't abort, but they might still parse
#  incorrectly.)
{
    sub foo(*@args, *%named) { 1 }

    eval_lives_ok q/foo;      /, 'call with no args, no parens';
    eval_lives_ok q/foo();    /, 'call with no args, has parens';
    eval_lives_ok q/&foo.();   /, 'call with no args, has dot and parens';
    eval_lives_ok q/&foo\ .(); /, 'call with no args, has long dot and parens';

    eval_lives_ok q/foo 1;    /, 'call with one arg, no parens';
    eval_lives_ok q/foo(1);   /, 'call with one arg, has parens';
    eval_lives_ok q/&foo.(1);  /, 'call with one arg, has dot and parens';
    eval_lives_ok q/&foo\ .(1);/, 'call with one arg, has long dot and parens';
    #?pugs todo 'unspecced'
    #?rakudo todo 'unspecced'
    eval_lives_ok q/foo'bar'; /, 'call with one arg, has no space and no parens';

    eval_lives_ok q/foo 1, 2; /, 'call with two args, no parens';
    eval_lives_ok q/foo(1, 2);/, 'call with two args, has parens';

    #?rakudo todo 'adverbs'
    eval_lives_ok q/foo:bar;  /, 'call with adverb after no space';
    eval_lives_ok q/foo :bar; /, 'call with adverb after space';

    eval_lives_ok q/foo(:bar);  /, 'call with adverb in parens';
    eval_lives_ok q/&foo.(:bar); /, 'call with adverb in dotted-parens';
    eval_lives_ok q/&foo\.(:bar);/, 'call with adverb in long-dotted parens';
}


# These tests are for mis-parses:
{
    sub succ($x) { $x + 1 }

    is(eval(q/succ  (1+2) * 30;/),  91, "parens after space aren't call-parens");
    eval_dies_ok(q/succ .(1+2) * 30;/, 'parsed as method call on $_');
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
