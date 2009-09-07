use v6;

use Test;

plan 6;

# L<S02/Names/"for the identifier of the variable">

sub foo() { $*VAR };

{
    my $*VAR = 'one';
    is $*VAR, 'one', 'basic contextual declaration works';
    is foo(), 'one', 'called subroutine sees caller $*VAR';
    {
        my $*VAR = 'two';
        is $*VAR, 'two', 'inner contextual declaration works';
        is foo(), 'two', 'inner caller hides outer caller';
    }
    is foo(), 'one', 'back to seeing outer caller';
}

ok !foo().defined, 'contextual $*VAR is undef';

# vim: ft=perl6
