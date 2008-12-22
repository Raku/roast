use v6;

use Test;

plan 6;

## If this test file is fudged, then MAIN never executes because 
## the fudge script introduces an C<exit(1)> into the mainline.
## This definition prevents that insertion from having any effect.  :-)
sub exit { }

# L<S06/Declaring a C<MAIN> subroutine/>

sub MAIN($a, $b, *@c) {
    ok(1, 'MAIN called correctly');
    is($a, 'a', 'first positional param set correctly');
    is($b, 'b', 'second positional param set correctly');
    #?rakudo todo "bug in slurpy parameters"
    is(~@c, 'c d e', 'slurpy param set correctly');
}

@*ARGS = <a b c d e>;

ok( @*ARGS == 5, '@*ARGS has correct elements');


# L<S06/Declaring a C<MAIN> subroutine/"the compilation unit was directly
# invoked rather than by being required by another compilation unit">

# a MAIN sub in eval() shouldn't be called

my $invoked = 0;
eval 'temp @*ARGS = <a b>; sub MAIN($a, $b) { $invoked = 0 };';
#?rakudo skip 'temp(), lexicals shared in eval()'
is $invoked, 0, 'sub MAIN is not called in eval()';

# vim: ft=perl6
