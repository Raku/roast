use v6;

use Test;

plan 8;

# basic test that multi is lexical
{
    {
        my multi foo() { 42 }
        is(foo(), 42, 'can call lexically scoped multi');
    }
    dies_ok({ foo() }, 'lexical multi not callable outside of lexical scope');
}

# test that lexical multis in inner scopes add to those in outer scopes
{
    {
        my multi bar() { 1 }
    
        {
            my multi bar($x) { 2 }
		    
            is(bar(),      1, 'outer lexical multi callable');
            is(bar('syr'), 2, 'new inner lexical multi callable');
        }

        is(bar(), 1, 'in outer scope, can call the multi that is in scope');
        dies_ok({ bar('pivo') }, 'multi variant from inner scope not callable in outer');
    }

    dies_ok({ bar() },       'no multi variants callable outside of lexical scope');
    dies_ok({ bar('kava') }, 'no multi variants callable outside of lexical scope');
}

# vim: ft=perl6 :
