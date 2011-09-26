use v6;
use Test;

plan 5;

is Any.Str,     '',      'Any.Str is empty string';
is Any.Stringy, '',      'Any.Str is empty string';
is Any.gist,    'Any()', 'Any.gist has those parens';

# maybe a bit too retrictive?
is Any.perl,    'Any',   'Any.perl does not have parens';

is Any.^name,   'Any',   '.^name'
