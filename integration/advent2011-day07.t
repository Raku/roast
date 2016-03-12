#! http://perl6advent.wordpress.com/2011/12/07/grammarprofiler/
use v6;
use lib 't/spec/packages';

use Test;
use Advent::GrammarProfiler;
plan 3;

grammar MyGrammar {
	rule TOP { <num> +% <op>  }
        token num { <[ 0..9 \. ]>+ }
        token op { < + - * / = >   }
}
ok MyGrammar.parse("37 + 10 - 5 = 42"), "parsed";

my %timing = get-timing();

ok %timing<MyGrammar><num><calls>, "num calls recorded";
ok %timing<MyGrammar><num><time> ~~ Real:D, "time recorded";
