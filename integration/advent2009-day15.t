# http://perl6advent.wordpress.com/2009/12/15/day-15-pick-your-game/

use v6;
use Test;

plan 4;

my @dice = 1..6;
is @dice.pick(2).elems, 2, 'Picking two elements using pick()';
is @dice.pick(10).elems, @dice.elems, 'Picking all elements using pick()';
is @dice.roll(10).elems, 10, 'Picking 10 elements from a list of 6 using roll';

class Card
{
  has $.rank;
  has $.suit;

  multi method Str()
  {
    return $.rank ~ $.suit;
  }
}

my @deck;
for <A 2 3 4 5 6 7 8 9 T J Q K> -> $rank
{
  for <♥ ♣ ♦ ♠> -> $suit
  {
    @deck.push(Card.new(:$rank, :$suit));
  }
}

#?niecza skip 'Cannot use value like Whatever as a number'
{
    @deck .= pick(*);
    is @deck.elems, 4 * 13, 'Shuffled card deck';
}
