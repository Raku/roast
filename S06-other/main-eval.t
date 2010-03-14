use v6;

use Test;

plan *;

# L<S06/Declaring a C<MAIN> subroutine/"the compilation unit was directly
# invoked rather than by being required by another compilation unit">

# a MAIN sub in eval() shouldn't be called

my $main_invoked = 0;
my $eval_worked = 0;
eval q[
    temp @*ARGS = <a b>;
    sub MAIN($a, $b) { $main_invoked = 1 };
    $eval_worked = 1;
];
#?rakudo 2 todo "temp NYI"
ok ! $!, 'no exception thrown';
ok $eval_worked, 'eval code executed';
is $main_invoked, 0, 'sub MAIN is not called in eval()';

# vim: ft=perl6
