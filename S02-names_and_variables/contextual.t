use v6;

use Test;

plan 9;

# L<S02/Names/"for the identifier of the variable">

%*ENV<THIS_NEVER_EXISTS> = 123;

{
	is $*THIS_NEVER_EXISTS, 123, "Testing contextual variable which changed within %*ENV";
}

{
	%*ENV.delete('THIS_NEVER_EXISTS');
        my $rv = eval('$*THIS_NEVER_EXISTS');
	ok $rv ~~ undef, "Testing for value of contextual variables that was deleted.";
}

{
	my $rv = eval('$*THIS_IS_NEVER_THERE_EITHER');
	ok $rv ~~ undef, "Testing for value of contextual variables that never existed.";
}


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
