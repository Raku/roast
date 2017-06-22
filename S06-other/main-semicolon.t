use v6;

use Test;

plan 10;

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
    throws-like { EVAL "module AtBeginning \{\}\nsub MAIN;" },
        X::UnitScope::TooLate, what => "sub"
}

{
    throws-like { EVAL '{ sub MAIN; }' },
        X::UnitScope::Invalid, what => "sub"
}

{
    throws-like { EVAL 'multi sub MAIN;' },
        X::UnitScope::Invalid, what => "sub"
}

# RT #127785
@*ARGS = '2';
eval-lives-ok 'sub MAIN($x where { $x > 1 }); 1', 'Can have where in sub MAIN(...);';
eval-lives-ok 'unit sub MAIN($x where { $x > 1 }); 1', 'Can have where in unit sub MAIN(...);';

# vim: ft=perl6
