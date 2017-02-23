use v6;
use Test;
plan 2;

{
    my $x = 0;
    42 notandthen $x++;
    is-deeply $x, 0, 'notandthen properly thunks RHS';
}
{
    my $x = 0;
    Int notandthen $x++ notandthen $x++;
    is-deeply $x, 1,
        'chaned notandthen executes RHS thunks only when appropriate';
}
