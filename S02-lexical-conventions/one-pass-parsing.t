use v6;
use Test;

plan 3;

# L<S02/"One-pass parsing">

lives_ok { EVAL 'regex { <[ } > ]> }; 1' },
  "can parse non-backslashed curly and right bracket in cclass";

# RT #74988
{
    lives_ok { EVAL 'sub if() { "#foo" }; say if();' },
      "Can call sub if()";
    dies_ok { EVAL 'sub if() { "#foo" }; say if;' },
      "Calling sub if without parens parsefails due to no-arg say";
}

# vim: ft=perl6
