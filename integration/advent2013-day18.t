use v6;
use Test;
plan 10;
{
    my grammar CardGame {

	rule TOP { ^ <deal> $ }

	rule deal {
	    :my %*PLAYED = ();
	    <hand>+ % ';'
	}

	rule hand { [ <card> ]**5 }
	token card {<face><suit>}

	proto token suit {*}
	token suit:sym<♥>  {<sym>}
	token suit:sym<♦>  {<sym>}
	token suit:sym<♣>  {<sym>}
	token suit:sym<♠>  {<sym>}

	token face {:i <[2..9]> | 10 | j | q | k | a }
    }

    class CardGame::Actions {
        has @.dups = ();
	method card($/) {
	    my $card = $/.lc;

	    @.dups.push($card)
		if %*PLAYED{$card}++;
	}
    }

    is ~CardGame.parse("2♥ 5♥ 7♦ 8♣ 9♠"), "2♥ 5♥ 7♦ 8♣ 9♠", "card game parse";
    is ~CardGame.parse("2♥ a♥ 7♦ 8♣ j♥"), "2♥ a♥ 7♦ 8♣ j♥", "card game parse";

    my $a = CardGame::Actions.new;

    is ~CardGame.parse("2♥ a♥ 7♦ 8♣ j♥", :actions($a)), "2♥ a♥ 7♦ 8♣ j♥", "card game + actions parse";
    is ~CardGame.parse("a♥ a♥ 7♦ 8♣ j♥", :actions($a)), "a♥ a♥ 7♦ 8♣ j♥", "card game + actions parse";
    is ~CardGame.parse("a♥ 7♥ 7♦ 8♣ j♥; 10♥ j♥ q♥ k♥ a♦",
		       :actions($a)), "a♥ 7♥ 7♦ 8♣ j♥; 10♥ j♥ q♥ k♥ a♦", "card game + actions parse";

    is_deeply $a.dups, ["a♥", "j♥"], 'duplicates detected in actions';
    
}

{

    our @dups = ();

    my grammar CardGame {

	rule TOP { ^ <deal> $ }

	rule deal {
	    :my %*PLAYED = ();
	    <hand>+ % ';'
	}

	rule hand { [ <card> ]**5 }
	token card {<face><suit>
	    <?{
		# only allow each card to appear once
		my $card = $/.lc;
		@dups.push($card)
		    if %*PLAYED{$card};

		! %*PLAYED{$card}++;
	     }>
	}
	proto token suit {*}
	token suit:sym<♥>  {<sym>}
	token suit:sym<♦>  {<sym>}
	token suit:sym<♣>  {<sym>}
	token suit:sym<♠>  {<sym>}

	token face {:i <[2..9]> | 10 | j | q | k | a }
    }

    class CardGame::Actions {
        has @.dups = ();
	method card($/) {
	    my $card = $/.lc;

	    @.dups.push($card)
		if %*PLAYED{$card}++;
	}
    }

    is ~CardGame.parse("2♥ 7♥ 2♦ 3♣ 3♦"), "2♥ 7♥ 2♦ 3♣ 3♦", 'card game parse';
    ok !defined(CardGame.parse("a♥ a♥ 7♦ 8♣ j♥")), 'duplicate detection - parse failure';
    ok !defined(CardGame.parse("a♥ 7♥ 7♦ 8♣ j♥; 10♥ j♥ q♥ k♥ a♦")), 'duplicate detection - parse failure';

    is_deeply @dups, ["a♥", "j♥"], 'duplicates detected in grammar';
}
