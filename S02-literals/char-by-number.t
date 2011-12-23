use v6;

use Test;

plan 42;

# L<S02/Radix interpolation>

is("\x20", ' ', '\x20 normal space');
is("\xa0", ' ', '\xa0 non-breaking space');

is("\x[20]", ' ', '\x[20] normal space');
is("\x[a0]", chr(0xa0), '\x[a0] non-breaking space');
is("\x[263a]", '☺', '\x[263a] wide hex character (SMILEY)');
is("\x[6211]", '我', '\x[597d] wide hex character (Chinese char)');
eval_dies_ok('"\x[6211"', 'broken "\x[6211"');
eval_dies_ok('"\x [6211]"', 'broken "\x [6211]"');

is("\x[41,42,43]", 'ABC', '\x[list]');
is("\x[4f60,597d]", '你好', '\x[a,b]');
is("\x41,42,43", 'A,42,43', '\xlist not valid');

is("\o40", ' ', '\o40 normal space');
is("\o240", ' ', '\o240 non-breaking space');

is("\o[40]", ' ', '\o[40] normal space');
is("\o[240]", chr(160), '\o[240] non-breaking space');
is("\o[23072]", '☺', '\o[23072] wide hex character (SMILEY)');
is("\o[61021]", '我', '\o[61021] wide hex character (Chinese char)');
eval_dies_ok('"\o[6211"', 'broken "\o[6211"');
eval_dies_ok('"\o [6211]"', 'broken "\o [6211]"');

is("\o[101,102,103]", 'ABC', '\o[list]');
is("\o[47540,54575]", '你好', '\o[a,b]');
is("\o101,102,103", 'A,102,103', '\olist not valid');

is("\c32", ' ', '\c32 normal space');
is("\c160", ' ', '\c160 non-breaking space');

is("\c[32]", ' ', '\c[32] normal space');
is("\c[160]", chr(160), '\c[240] non-breaking space');
is("\c[9786]", '☺', '\c[9786] wide hex character (SMILEY)');
is("\c[25105]", '我', '\c[25105] wide hex character (Chinese char)');
eval_dies_ok('"\c[6211"', 'broken "\c[6211"');
eval_dies_ok('"\c [6211]"', 'broken "\c [6211]"');

is("\c[65,66,67]", 'ABC', '\c[list]');
is("\c[20320,22909]", '你好', '\c[a,b]');
is("\c65,66,67", 'A,66,67', '\clist not valid');

# L<S02/Radix interpolation/"\123 form">

{
    eval_dies_ok q{"\123"}, '"\123" form is no longer valid Perl 6';
    eval_dies_ok q{"\10"}, '"\10" form is no longer valid Perl 6';
}

{
    is "\040", "\x[0]40", '\0stuff is actually valid';
}

{
    is "\08", chr(0) ~ '8', 'next char of \0 is 8 (> 7)';
    is "\0fff", chr(0) ~ 'fff', 'next char of \0 is `f`';
}

#?rakudo todo 'Detecting malformed escape sequences NYI'
#?niecza todo 'Detecting malformed escape sequences NYI'
{
    eval_dies_ok q{"\00"}, 'next char of \0 is 0';
    eval_dies_ok q{"\01"}, 'next char of \0 is 1';
    eval_dies_ok q{"\05"}, 'next char of \0 is 5';
    eval_dies_ok q{"\07"}, 'next char of \0 is 7';
}

# vim: ft=perl6
