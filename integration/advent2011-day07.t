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

my %t = get-timing();

ok %t<MyGrammar><num><calls>, "num calls recorded";
ok %t<MyGrammar><num><time> ~~ Real:D, "time recorded";
