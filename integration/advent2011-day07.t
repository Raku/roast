#! http://perl6advent.wordpress.com/2011/12/07/grammarprofiler/
use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Advent/lib");

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

# vim: expandtab shiftwidth=4
