use v6.c;
use Test;
plan 7;

is &infix:<+>(3, 8), 11, 'Can refer to &infix:<+>';
is  infix:<+>(3, 8), 11, 'Can refer to  infix:<+>';

is &infix:<->(3, 8), -5, 'Can refer to &infix:<->';
is  infix:<->(3, 8), -5, 'Can refer to  infix:<->';

is &infix:<cmp>(3, 4), Order::Less, 'Can refer to &infix:<cmp>';

#?niecza todo
ok ~&infix:<+> ~~ /infix/, 'String value of &infix:<+> contains "infix"';
#?niecza todo
ok ~&infix:<+> ~~ /\+/, 'String value of &infix:<+> contains "+"';
