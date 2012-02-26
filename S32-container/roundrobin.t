use v6;

use Test;

plan 8;

# L<S32::Containers/Container/"=item roundrobin">

=begin pod

Tests of

  our Lazy multi Container::roundrobin( Bool :$shortest,
      Bool :$finite, **@list );

=end pod

ok(roundrobin() eqv (), 'roundrobin null identity');

ok(roundrobin(1) eqv (1,), 'roundrobin scalar identity');

ok(roundrobin(1..3) eqv 1..3, 'roundrobin list identity');

ok(roundrobin([1..3]) eqv 1..3, 'roundrobin array identity');

# Next 2 work.  Just waiting on eqv.
#
#?pugs 2 todo 'These tests depend on eqv'
ok(roundrobin({'a'=>1,'b'=>2,'c'=>3}) eqv ('a'=>1,'b'=>2,'c'=>3),
    'roundrobin hash identity');

ok(roundrobin((); 1; 2..4; [5..7]; {'a'=>1,'b'=>2})
    eqv (1, 2, 5, 'a'=>1, 3, 6, 'b'=>2, 4, 7), 'basic roundrobin');

#?pugs skip 'Named argument found where no matched parameter expected'
ok(roundrobin(:shortest, 1; 1..2; 1..3) eqv (1), 'roundrobin :shortest');

#?pugs todo
flunk('roundrobin :finite');

=begin lazy_roundrobin

#?pugs todo 'feature'
ok(roundrobin(:finite, 1; 1..2; 1..3) eqv (1), 'roundrobin :shortest');

=end lazy_roundrobin

# vim: ft=perl6
