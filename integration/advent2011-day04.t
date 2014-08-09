# http://perl6advent.wordpress.com/2011/12/04/traits-meta-data-with-character/

use v6;
use Test;
plan 2;

# this gets called when 'is Cached' is added
# to a routine
our %cache;
multi sub trait_mod:<is>(Routine $r, :$Cached!) {
    #wrap the routine in a block that..
    $r.wrap(-> $arg {
	# looks up the argument in the cache
	%cache{$arg}:exists
	    ?? %cache{$arg}
            # ... and calls the original, if it
            # is not found in the cache
	    !! (%cache{$arg} = callwith($arg))
        }
    );
}
 
 # example aplication:
sub fib($x) is Cached {
    $x <= 1 ?? 1 !! fib($x - 1) + fib($x - 2);
}
 # only one call for each value from 0 to 10
#?rakudo.jvm 2 skip 'RT #122497'
#?rakudo.parrot 2 skip 'RT #122497'
is fib(10), 89, 'fibinacci output';
is_deeply %cache, {1 => 1, 0 => 1, 2 => 2, 3 => 3,
		   4 => 5, 5 => 8, 6 => 13, 7 => 21,
		   8 => 34, 9 => 55, 10 => 89}, 'caching';

