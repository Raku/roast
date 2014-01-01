use v6;

use Test;

plan 3;

# L<S06/Declaring a C<MAIN> subroutine/"the compilation unit was directly
# invoked rather than by being required by another compilation unit">

# a MAIN sub in EVAL() shouldn't be called

my $main_invoked = 0;
my $eval_worked = 0;
EVAL q[
    my @*ARGS = <a b>;
    sub MAIN($a, $b) { $main_invoked = 1 };
    $eval_worked = 1;
];
ok ! $!, 'no exception thrown';
ok $eval_worked, 'EVAL code executed';
#?rakudo todo 'MAIN in EVAL'
is $main_invoked, 0, 'sub MAIN is not called in EVAL()';

done;

# vim: ft=perl6
