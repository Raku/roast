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
    is(~@c, 'c d e', 'slurpy param set correctly');
}

@*ARGS = <a b c d e>;

ok( @*ARGS == 5, '@*ARGS has correct elements');

# RT #114354
@*INC.push: 't/spec/packages/';
lives_ok { require HasMain }, 'MAIN in a module did not get executed';

# vim: ft=perl6
