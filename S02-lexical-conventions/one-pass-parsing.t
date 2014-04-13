use v6;
use Test;

plan 3;

# L<S02/"One-pass parsing">

ok(EVAL('regex { <[ } > ]> }; 1'),
    "can parse non-backslashed curly and right bracket in cclass");

# RT #74988
{
    eval_lives_ok 'sub if() { "#foo" }; say if();', "Can call sub if()";
    eval_dies_ok 'sub if() { "#foo" }; say if;', "Calling sub if without parens parsefails";
}

# vim: ft=perl6
