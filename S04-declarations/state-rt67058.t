use v6;

use Test;

plan 1;

sub bughunt1 { (state $svar) }
{
    sub bughunt2 { state $x //= 17; $x++ }
    #?rakudo todo 'b0rk'
    lives_ok { bughunt2() },
        'a state variable in parens lives with a state variable with //= init';
}

#
# I've tried removing pretty much every part of this test case
# and it's all necessary.
#
# * state $svar in parens in bughunt1.
# * braces around bughunt2 definition.
# * Assignment and modification of $x
# * call to bughunt2
#
