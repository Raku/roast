# http://perl6advent.wordpress.com/2009/12/16/day-16-we-call-it-the-old-switcheroo/

use v6;
use Test;

plan *;

sub weather($weather) {
    given $weather {
      when 'sunny'  { return 'Aah! ☀'                    }
      when 'cloudy' { return 'Meh. ☁'                    }
      when 'rainy'  { return 'Where is my umbrella? ☂'   }
      when 'snowy'  { return 'Yippie! ☃'                 }
      default       { return 'Looks like any other day.' }
    }
}
is weather(Any), 'Looks like any other day.', 'Weather given/when';

{
    sub probability($probability) {
        given $probability {
          when     1.00 { return 'A certainty'   }
          when * > 0.75 { return 'Quite likely'  }
          when * > 0.50 { return 'Likely'        }
          when * > 0.25 { return 'Unlikely'      }
          when * > 0.00 { return 'Very unlikely' }
          when     0.00 { return 'Fat chance'  }
        }
    }
    is probability(0.80), 'Quite likely', 'Probability given/when';

    sub fib(Int $_) {
      when * < 2 { 1 }
      default { fib($_ - 1) + fib($_ - 2) }
    }
    is fib(5), 8, '6th fibonacci number';
}

class Card {
    method bend()     { return "Card bent" }
    method fold()     { return "Card folded" }
    method mutilate() { return "Card mutilated" }
}
my Card $punch-card .= new;

my $actions;
given $punch-card {
  $actions ~= .bend;
  $actions ~= .fold;
  $actions ~= .mutilate;
}
is $actions, 'Card bentCard foldedCard mutilated', 'Given as a sort of once-only for loop.';


my @list = 1, 2, 3, 4, 5;
my $castle = 'phantom';
my $full-of-vowels = 'aaaooouuuiiee';
is (.[0] + .[1] + .[2] given @list), 6, 'Statement ending given';

#?rakudo skip "This given/when usage doesn't work in current Rakudo"
{
    is ("My God, it's full of vowels!" when $full-of-vowels ~~ /^ <[aeiou]>+ $/), "My God, it's full of vowels!", 'Statement ending when';
    is ('Boo!' when /phantom/ given $castle), 'Boo!', 'Nesting when inside given';
}

done_testing;
