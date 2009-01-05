use v6;

use Test;

plan 5;

# L<S02/Names/"it then looks in %*ENV for the identifier of the variable">

%*ENV<THIS_NEVER_EXISTS> = 123;

{
	is $+THIS_NEVER_EXISTS, 123, "Testing contextual variable which changed within %*ENV";
}

{
	%*ENV.delete('THIS_NEVER_EXISTS');
        my $rv = eval('$+THIS_NEVER_EXISTS');
	ok $!, "Testing for accessing contextual which is deleted.";
	ok $rv ~~ undef, "Testing for value of contextual variables that was deleted.";
}

{
	my $rv = eval('$+THIS_IS_NEVER_THERE_EITHER');
        ok $!, "Test for contextual which doesn't exists.";
	ok $rv ~~ undef, "Testing for value of contextual variables that never existed.";
}

