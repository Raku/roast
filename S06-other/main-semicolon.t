use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

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

# https://github.com/Raku/old-issue-tracker/issues/5200
{
    is_run 'sub MAIN($x where { $x > 1 }); print "pass"', :args[2],
      {:out<pass>, :err(''), :0status}, 'can have where in sub MAIN(...);';
    is_run 'unit sub MAIN($x where { $x > 1 }); print "pass"', :args[2],
      {:out<pass>, :err(''), :0status}, 'can have where in unit sub MAIN(...);';
}

# vim: expandtab shiftwidth=4
