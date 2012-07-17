use v6;
use Test;
plan 12;

# L<S06/Named subroutines>

#first lets test lexical named subs
{
    my Str sub myNamedStr() { return 'string' };
    is myNamedStr(), 'string', 'lexical named sub() return Str';
}

eval_dies_ok 'myNamedStr()', 'Correct : lexical named sub myNamedStr() should NOT BE available outside its scope';

{
    my Int sub myNamedInt() { return 55 };
    is myNamedInt(), 55, 'lexical named sub() return Int';
}
eval_dies_ok('myNamedInt()', 'Correct : lexical named sub myNamedInt() should NOT BE available outside its scope');


#packge-scoped named subs

{
    our Str sub ourNamedStr() { return 'string' };
    is ourNamedStr(), 'string', 'package-scoped named sub() return Str';
}
#?pugs skip 'Cannot use Undef as a Code object'
{
    our &ourNamedStr;
    is ourNamedStr(), 'string', 'Correct : package-scoped named sub ourNamedStr() should BE available in the whole package';
}

{
    our Int sub ourNamedInt() { return 55 };
    is ourNamedInt(), 55, 'package-scoped named sub() return Int';
}
#?pugs skip 'Cannot use Undef as a Code object'
{
    our &ourNamedInt;
    is ourNamedInt(), 55, 'Correct : package-scoped named sub ourNamedInt() should BE available in the whole package';
}

eval_dies_ok
    'my Num List sub f () { return ("A") }; f()',
    'Return of list with wrong type dies';

eval_lives_ok
    'my List sub f () { return () }; f()',
    'return of empty list should live';
is eval('my List sub f () { return () }; (f(), "a")'), ['a'],
    'return of empty list should be empty list';

eval_dies_ok
    'my Num List sub f () { ("A") }; f()',
    'implicit return of list with wrong type dies';

# vim: ft=perl6
