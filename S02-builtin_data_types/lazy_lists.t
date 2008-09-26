use v6;

# Tests for lazy lists
#
# TODO - uncomment "countable lazy slice" test
# TODO - add timeout control, in tests that may loop forever
# TODO - the backends that don't have infinite lists implemented 
#        should warn of this, instead of entering an infinite loop.
# TODO - add test for (1..Inf:by(2)) 
# TODO - add test for "build a list from a coroutine"
# TODO - add test for zip()
# TODO - add test for 2D array

use Test;

plan( 32 );


#?pugs emit unless $?PUGS_BACKEND eq "BACKEND_PERL5" {
#?pugs emit    skip_rest ("$?PUGS_BACKEND does not support lazy lists yet.", 
#?pugs emit				:depends("lazy lists") );
#?pugs emit    exit;
#?pugs emit }

# constructors

is( (1..Inf).perl, 
    "(1, 2, 3, ..., Inf)", 
    "simple infinite list" );

#?rakudo skip "Method 'perl' not found in * (Whatever)"
is( (1..*).perl, 
    "(1, 2, 3, ..., Inf)", 
    "simple infinite list" );

is( (-Inf..Inf).perl, 
    "(-Inf, ..., Inf)", 
    "double infinite list" );

#?rakudo skip "Method 'perl' not found in * (Whatever)"
is( (*..*).perl, 
    "(-Inf, ..., Inf)", 
    "double infinite list" );

is( (-Inf..0).perl, 
    "(-Inf, ..., -2, -1, 0)", 
    "negative infinite list" );

#?rakudo skip "Method 'perl' not found in * (Whatever)"
is( (*..0).perl, 
    "(-Inf, ..., -2, -1, 0)", 
    "negative infinite list" );

# this one should not really work unless .perl gives up before infinity
is( ('aaaa'..'zzzz').perl, 
    "('aaaa', 'aaab', 'aaac', ..., 'zzzx', 'zzzy', 'zzzz')", 
    "string lazy list" );

#?rakudo skip "Method 'perl' not found in * (Whatever)"
is( ('aaaa'..*).perl, 
    "('aaaa', 'aaab', 'aaac', ..., *)", 
    "infinite string lazy list" );

#?rakudo skip 'get_integer() not implemented in "Whatever"'
is( (1..*,2,3).perl,
    "(1, 2, 3, ..., Inf, 2, 3)",
    "infinite list with non-lazy elements" );

# splices

#?rakudo skip "Method 'splice' not found in 'Perl6Array'"
{
    my @a = (1..Inf);
    is( @a.splice( 2, 3 ), 
        "(3, 4, 5)",
        "splice" );
    is( @a, 
        "(1, 2, 6, ..., Inf)",
        "spliced" );
}

#?rakudo skip "Method 'splice' not found in 'Perl6Array'"
{
    my @a = (1..Inf);
    is( @a.splice( 2, Inf, 99, 100 ), 
        "(3, 4, 5, ..., Inf)",
        "splice" );
    is( @a, 
        "(1, 2, 99, 100)",
        "spliced" );
}

# basic list operations

is( (1..Inf).elems, 
    "Inf", 
    "elems" );

is( (1..Inf).shift, 
    "1", 
    "shift" );

#?rakudo skip "decrement() not implemented in class 'Undef'"
is( (1..Inf).pop, 
    "Inf", 
    "pop" );

is( (1..Inf).clone, 
    "(1, 2, 3, ..., Inf)", 
    "clone" );

is( (1..Inf).reverse.perl, 
    "(Inf, ..., 3, 2, 1)", 
    "reverse" );

#?rakudo skip 'Parse Error: Statement not terminated properly'
is( (1..Inf).map:{ $_/2 }.perl, 
    "(0.5, 1, 1.5, ..., Inf)", 
    "map" );

is( ('x' xx 1000000).perl,
    "('x', 'x', 'x', ..., 'x', 'x', 'x')",
    "xx operator" );

#?rakudo skip "Method 'sum' not found for 'Range'"
is( (1..Inf).sum, 
    "Inf", 
    "infinite sum" );

#?rakudo skip "Method 'sum' not found for 'Range'"
is( (1..1000000).sum, 
    "500000500000", 
    "non-infinite sum" );

# slices

#?rakudo skip "get_pmc_keyed() not implemented in class 'Range'"
is( (1..Inf)[2..5].perl,
    "(3, 4, 5, 6)",
    "simple slice" );

{
    my @a = (1..Inf);
    is( @a[2..5].perl,
        "(3, 4, 5, 6)",
        "simple slice" );
}

#?rakudo skip "get_pmc_keyed() not implemented in class 'Range'"
is( (1..Inf)[2..Inf].perl,
    "(3, 4, 5, ..., Inf)",
    "lazy slice" );

#?pugs emit	if $?PUGS_BACKEND eq "BACKEND_PERL5" {
#?pugs emit    	skip ( 1, "countable lazy slice not fully implemented in $?PUGS_BACKEND yet", 
#?pugs emit    	:depends("lazy slices") );
#?pugs emit    	is( (1..Inf)[2..100000].perl,
#?pugs emit        	"(3, 4, 5, ..., 100001, 100002, 100003)",
#?pugs emit        	"countable lazy slice" );
#?pugs emit	}

# array assignment

#?rakudo skip 'Null PMC access in find_method()'
{
    my @a = (1..Inf);
    is( @a.perl,
        "(1, 2, 3, ..., Inf)",
        "array assignment" );
    @a[1] = 99;
    is( @a.perl,
        "(1, 99, 3, ..., Inf)",
        "array element assignment" );
}

#?rakudo skip 'Null PMC access in find_method()'
{
    my @a = (1..Inf);
    is( @a.perl,
        "(1, 2, 3, ..., Inf)",
        "array assignment" );
    @a[0,1] = (98, 99);
    is( @a.perl,
        "(98, 99, 3, ..., Inf)",
        "array slice assignment" );
}

#?rakudo skip "Method 'delete' not found in 'Failure'"
{
    my @a = (1..Inf);
    @a[1].delete;
    is( @a.perl,
        "(1, undef, 3, ..., Inf)",
        "array element delete()" );
}

#?rakudo skip "Method 'delete' not found in 'Failure'"
{
    my @a = (1..Inf);
    @a[0,1].delete;
    is( @a.perl,
        "(undef, undef, 3, ..., Inf)",
        "array slice delete()" );
}

{
    my @a = (1..Inf);
    @a[1..1000002] = @a[9..1000010];
    is( @a.perl,
        "(1, 10, 11, ..., Inf)",
        "big slice assignment" );
}

# assorted operations

is( (1..Inf, (1..Inf).reverse ).perl, 
    "(1, 2, 3,, ..., 3, 2, 1)", 
    "end of infinite list is readable" );

