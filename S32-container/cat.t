use v6;

use Test;

plan 6;

# L<S32::Containers/Container/"=item cat">

=begin pod

Tests of

  our Lazy multi Container::cat( **@list );

=end pod

ok(cat() eqv (), 'cat null identity');

ok(cat(1) eqv (1,), 'cat scalar identity');

ok(cat(1..3) eqv 1..3, 'cat list identity');

ok(cat([1..3]) eqv 1..3, 'cat array identity');

# These below work.  Just waiting on eqv.

ok(cat({'a'=>1,'b'=>2,'c'=>3}) eqv ('a'=>1, 'b'=>2, 'c'=>3),
    'cat hash identity');

ok(cat((); 1; 2..4; [5..7], {'a'=>1,'b'=>2}) eqv (1..7, 'a'=>1, 'b'=>2),
    'basic cat');

# vim: ft=perl6
