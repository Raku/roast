use v6;
use Test;

# L<S32::Containers/"Array"/"=item splice">

=begin description

This test tests the C<splice> builtin

=end description

plan 37;

my (@a,@b,@res);

#?DOES 2
sub splice_ok (@got, @ref, @exp, @exp_ref, Str $comment) {
  is @got, @exp, "$comment - results match";
  is @ref, @exp_ref, "$comment - array got modified in-place";
};

@a = (1..10);
@b = splice(@a,+@a,0,11,12);

is( @b, [], "push-via-splice result works" );
is( @a, [1..12], "push-via-splice modification works");

{
    my @a = (1..10);
    my @b = splice(@a,+@a,0,11,12);

    is( @b, [], "push-via-splice result works" );
    is( @a, [1..12], "push-via-splice modification works");
}

@a  = ('red', 'green', 'blue');
is( splice(@a, 1, 2), [<green blue>],
  "splice() in scalar context returns an array references");

# Test the single arg form of splice (which should die IMO)
@a = (1..10);
@res = splice(@a);
splice_ok( @res, @a, [1..10],[], "Single-arg splice returns the whole array" );

@a = (1..10);
@res = splice(@a,8,2);
splice_ok( @res, @a, [9,10], [1..8], "3-arg positive indices work");

@a = (1..12);
splice_ok splice(@a,0,1), @a, [1], [2..12], "Simple 3-arg splice";

@a = (1..10);
@res = splice(@a,8);
splice_ok @res, @a, [9,10], [1..8], "2-arg positive indices work";

#?rakudo skip "needs WhateverCode args"
{
    @a = (1..10);
    @res = splice(@a,*-2,2);
    splice_ok @res, @a, [9,10], [1..8], "3-arg negative indices work";
}

#?rakudo skip "needs WhateverCode args"
{
    @a = (1..10);
    @res = splice(@a,*-2);
    splice_ok @res, @a, [9,10], [1..8], "2-arg negative indices work";
}

# to be converted into more descriptive tests
@a = (2..10);
splice_ok splice(@a,0,0,0,1), @a, [], [0..10], "Prepending values works";

# Need to convert these
# skip 5, "Need to convert more tests from Perl5";
@a = (0..11);
splice_ok splice(@a,5,1,5), @a, [5], [0..11], "Replacing an element with itself";

@a = (0..11);
splice_ok splice(@a, +@a, 0, 12, 13), @a, [], [0..13], "Appending an array";

#?rakudo skip "needs WhateverCode args"
{
    @a = (0..13);
    @res = splice(@a, *-@a, +@a, 1, 2, 3);
    splice_ok @res, @a, [0..13], [1..3], "Replacing the array contents from right end";
}

#?rakudo skip "needs WhateverCode args"
{
    @a = (1, 2, 3);
    splice_ok splice(@a, 1, *-1, 7, 7), @a, [2], [1,7,7,3], "Replacing a array into the middle";
} 

#?rakudo skip "needs WhateverCode args"
{
    @a = (1,7,7,3);
    splice_ok splice(@a,*-3,*-2,2), @a, [7], [1,2,7,3], "Replacing negative count of elements";
}

# Test the identity of calls to splice:
sub indirect_slurpy_context( *@got ) { @got };

# splice4 gets "CxtItem _" or "CxtArray _" instead of "CxtSlurpy _"
my @tmp = (1..10);
{
    @a = splice @tmp, 5, 3;
    @a = indirect_slurpy_context( @a );
    @tmp = (1..10);
    @b = indirect_slurpy_context( splice @tmp, 5, 3 );
    is( @b, @a, "Calling splice with immediate and indirect context returns consistent results");
    is( @a, [6,7,8], "Explicit call/assignment gives the expected results");
    is( @b, [6,7,8], "Implicit context gives the expected results"); # this is due to the method-fallback bug
}

{
    @tmp = (1..10);
    @a = item splice @tmp, 5, 3;
    is( @a, [6..8], "Explicit scalar context returns an array reference");
}

## test some error conditions

@a = splice([], 1);
is +@a, 0, '... empty arrays are not fatal anymore';
# But this should generate a warning, but unfortunately we can't test for
# warnings yet.

#?pugs todo 'bug'
dies_ok({ 42.splice }, '.splice should not work on scalars');

@a = (1..10);
dies_ok({use fatal; splice(@a,-2)}, "negative offset dies");
dies_ok({use fatal; splice(@a,2,-20)}, "negative size dies");

# vim: ft=perl6
