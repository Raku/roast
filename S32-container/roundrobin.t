use v6;

use Test;

plan 7;

# L<S32::Containers/Container/"=item roundrobin">

=begin pod

Tests of

  our Lazy multi Container::roundrobin( Bool :$shortest,
      Bool :$finite, **@list );

=end pod

is roundrobin().elems, 0, 'roundrobin null identity';

is roundrobin(1).join, '1', 'roundrobin scalar identity';

is(roundrobin(1..3).Str,  (1..3).Str, 'roundrobin list identity');

is(roundrobin([], [1], [2..4], [5..7], <a b>).join(' '),
   (1, 2, 5, 'a', 3, 6, 'b', 4, 7).join(' '), 'basic roundrobin');

# https://github.com/Raku/old-issue-tracker/issues/4705
is roundrobin($(1, 2), <a b c>), (($(1, 2), 'a'), ('b',), ('c',)),
    'roundrobin respects itemization of arguments (1)';
is roundrobin(<a b c>, $(1, 2)), (('a', $(1, 2)), ('b',), ('c',)),
    'roundrobin respects itemization of arguments (2)';

# https://github.com/rakudo/rakudo/issues/3402
my %h = %(:a);
is-deeply roundrobin(%h<>:v.map: *.flat), ((True,),),
  'is a 1-element list handled correctly with roundrobin';

# vim: expandtab shiftwidth=4
