use v6;

use Test;

plan 8;

## If this test file is fudged, then MAIN never executes because
## the fudge script introduces an C<exit(1)> into the mainline.
## This definition prevents that insertion from having any effect.  :-)
sub exit { }

# L<S06/Declaring a C<MAIN> subroutine/"a sub declaration
# ending in semicolon is allowed at the outermost file scope">

@*ARGS = <a b c d e>;
sub MAIN($a, $b, *@c);

ok 1, "This was parsed and called";
is($a, 'a', 'first positional param set correctly');
is($b, 'b', 'second positional param set correctly');
is(~@c, 'c d e', 'slurpy param set correctly');

is &?ROUTINE.name, "MAIN", "...and we're actually in MAIN now";

{
    throws_like { EVAL "module AtBeginning \{\}\nsub MAIN;" },
        X::SemicolonForm::TooLate, what => "sub"
}

{
    throws_like { EVAL '{ sub MAIN; }' },
        X::SemicolonForm::Invalid, what => "sub"
}

{
    throws_like { EVAL 'multi sub MAIN;' },
        X::SemicolonForm::Invalid, what => "sub"
}

# vim: ft=perl6
