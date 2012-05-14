use v6;

use Test;

plan 5;

# L<S32::Containers/Container/"=item roundrobin">

=begin pod

Tests of

  our Lazy multi Container::roundrobin( Bool :$shortest,
      Bool :$finite, **@list );

=end pod

is roundrobin().elems, 0, 'roundrobin null identity';

is roundrobin(1).join, '1', 'roundrobin scalar identity';

is(roundrobin(1..3).Str,  (1..3).Str, 'roundrobin list identity');

#?rakudo todo 'over-flattening'
is(roundrobin([1..3]).elems, 1, 'roundrobin does not flatten array items');


is(roundrobin((); 1; 2..4; (5..7); <a b>).join(' '),
   (1, 2, 5, 'a', 3, 6, 'b', 4, 7).join(' '), 'basic roundrobin');

# vim: ft=perl6
