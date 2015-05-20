use v6;
use Test;

plan 5;

# L<S02/"One-pass parsing">

lives-ok { EVAL 'regex { <[ } > ]> }; 1' },
  "can parse non-backslashed curly and right bracket in cclass";

# RT #74988
{
    lives-ok { EVAL 'sub if() { "#foo" }; say if();' },
      "Can call sub if()";
    dies-ok { EVAL 'sub if() { "#foo" }; say if ;' },
      "Calling sub if without parens parsefails due to no-arg say";
    lives-ok { EVAL 'sub if() { "#foo" }; say if;' },
      "Calling sub if okay parens as long as not followed by whitespace";
    dies-ok { EVAL 'say "OK" if+1' },
      "Using keyword if fails if not followed by whitespace";
}

# vim: ft=perl6
