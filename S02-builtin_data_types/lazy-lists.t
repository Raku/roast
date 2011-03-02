use v6;

# L<S09/Lazy lists>

# Tests for lazy lists
#
# TODO - uncomment "countable lazy slice" test
# TODO - add timeout control, in tests that may loop forever
# TODO - the backends that don't have infinite lists implemented
#        should warn of this, instead of entering an infinite loop.
# TODO - add test for "build a list from a coroutine"
# TODO - add test for zip()
# TODO - add test for 2D array

use Test;

plan 12;


#?pugs emit unless $?PUGS_BACKEND eq "BACKEND_PERL5" {
#?pugs emit    skip_rest ("$?PUGS_BACKEND does not support lazy lists yet.",
#?pugs emit				:depends("lazy lists") );
#?pugs emit    exit;
#?pugs emit }


{
    my @a = (1..Inf);
    is( @a.splice( 2, 3 ),
        "(3, 4, 5)",
        "splice" );
}

# basic list operations

is( (1..Inf).elems,
    Inf,
    "elems" );

is( (1..Inf).shift,
    1,
    "shift" );

is( (1..Inf).pop,
    Inf,
    "pop" );


is( (1..Inf)[2..5],
    [3, 4, 5, 6],
    "simple slice" );

{
    my @a = (1..Inf);
    is( @a[2..5],
        [3, 4, 5, 6],
        "simple slice" );
}


#?pugs emit	if $?PUGS_BACKEND eq "BACKEND_PERL5" {
#?pugs emit    	skip ( 1, "countable lazy slice not fully implemented in $?PUGS_BACKEND yet",
#?pugs emit    	:depends("lazy slices") );
#?pugs emit    	is( (1..Inf)[2..100000].perl,
#?pugs emit        	"(3, 4, 5, ..., 100001, 100002, 100003)",
#?pugs emit        	"countable lazy slice" );
#?pugs emit	}

# array assignment

{
    my @a = (1..Inf);
    @a[1] = 99;
    is @a[0, 1, 2].join(' '), '1 99 2', 'assignment to infinite list';
}

{
    my @a = (1..Inf);
    @a[0,1] = (98, 99);
    is( ~@a[0..2],
        "98 99 3",
        "array slice assignment" );
}

{
    my @a = (1..Inf);
    @a[1].delete;
    is ~@a[0, 2], '1 3', 'array elemente delete (1)';
    nok @a[1].defined, 'array element delete (2)';
}

{
    my @a = (1..Inf);
    @a[0,1].delete;
    nok( all(@a[0, 1]).defined,
        "array slice delete()" );
}

{
    my @a = (1..Inf);
    @a[1..1000002] = @a[9..1000010];
    is( ~@a[0, 1, 2],
        '1 10 11',
        "big slice assignment" );
}

# vim: ft=perl6
