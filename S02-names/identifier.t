use v6;
use Test;

plan 13;

# L<S02/Names/An identifier is composed of an alphabetic character>

{
    sub don't($x) { !$x }

    ok don't(0),    "don't() is a valid sub name (1)";
    ok !don't(1),   "don't() is a valid sub name (2)";

    my $a'b'c = 'foo';
    is $a'b'c, 'foo', "\$a'b'c is a valid variable name";

    eval_dies_ok  q[sub foo-($x) { ... }],
                 'foo- (trailing hyphen) is not an identifier';
    eval_dies_ok  q[sub foo'($x) { ... }],
                 "foo' (trailing apostrophe) is not an identifier";
    eval_dies_ok  q[sub foob'4($x) { ... }],
                 "foob'4 is not a valid identifer (not alphabetic after apostrophe)";
    eval_dies_ok  q[sub foob-4($x) { ... }],
                 "foob-4 is not a valid identifer (not alphabetic after hyphen)";
    eval_lives_ok q[sub foo4'b($x) { ... }],
                 "foo4'b is a valid identifer";
}

{
    # This confirms that '-' in a sub name is legal.
    my $calls = 0;
    my sub foo-bar { $calls++ };
    foo-bar();
    is $calls, 1, "foo-bar was called";
}

# RT #64656
{
    my $calls = 0;
    my sub do-check { $calls++ };
    do-check();
    is $calls, 1, "do-check was called";
}

{
    # check with a different keyword
    sub if'a($x) {$x}
    is if'a(5), 5, "if'a is a valid sub name";
}

{
    my $calls = 0;
    my sub sub-check { $calls++ };
    sub-check();
    is $calls, 1, "do-check was called";
}

{
    my $calls = 0;
    my sub method-check { $calls++ };
    method-check();
    is $calls, 1, "method-check was called";
}

# vim: ft=perl6
