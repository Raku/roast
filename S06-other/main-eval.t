use v6;

use Test;

plan 1;

# L<S06/Declaring a C<MAIN> subroutine/"the compilation unit was directly
# invoked rather than by being required by another compilation unit">

# a MAIN sub in eval() shouldn't be called

my $invoked = 0;
eval 'temp @*ARGS = <a b>; sub MAIN($a, $b) { $invoked = 1 };';
is $invoked, 0, 'sub MAIN is not called in eval()';
