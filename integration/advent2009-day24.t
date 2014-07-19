# http://perl6advent.wordpress.com/2009/12/24/day-24-the-perl-6-standard-grammar/

use v6;
use Test;
plan 4;

grammar BaseGrammar {
    rule TOP { <statement-list> }
    rule statement-list { <stmt> +%% ';' }
    # simplistic statement syntax - test purposes only
    rule id { '$'<ident> }
    rule val { \d+ | <id> <postfix>? }
    rule postfix { < ++ -- > }
    rule expr  { <id> <infix>?'=' <expr> || <val> +% [ <infix> ] | '(' ~ ')' <expr> }
    rule infix { < + - * / == \< \> > }
    rule stmt { <statement> | '{' ~ '}' <statement-list> }
    proto token statement { <...> }
    rule statement:sym<if>    { 'if' <expr> <statement> }
    rule statement:sym<while> { 'while' <expr> <statement> }
    rule statement:sym<for>
    { 'for' '(' <expr> ';' <expr> ';' <expr> ')' <stmt> }
    rule statement:sym<expr>  { <expr> }
}

grammar MyNewGrammar is BaseGrammar {
    rule statement:sym<repeat> { 'repeat' <stmt> 'until' <expr> }
}

ok BaseGrammar.parse('$j = 1; for ($i = 0; $i > 10; $i++) { $j *= $i }'), 'base grammar';
ok MyNewGrammar.parse('$j = 1; for ($i = 0; $i > 10; $i++) { $j *= $i }'), 'derived grammar';
ok MyNewGrammar.parse('$i = 10; $j = 1; repeat $j *= $i-- until $i == 0'), 'derived grammar is extended';
nok BaseGrammar.parse('$i = 10; $j = 1; repeat $j *= $i-- until $i == 0'), 'base grammar is not extended';

