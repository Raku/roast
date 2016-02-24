use v6.c;
use Test;
plan 12;

# L<S06/Named subroutines>

#first lets test lexical named subs
{
    my Str sub myNamedStr() { return 'string' };
    is myNamedStr(), 'string', 'lexical named sub() return Str';
}

throws-like 'myNamedStr()', X::Undeclared::Symbols,
    'Correct : lexical named sub myNamedStr() should NOT BE available outside its scope';

{
    my Int sub myNamedInt() { return 55 };
    is myNamedInt(), 55, 'lexical named sub() return Int';
}

throws-like 'myNamedInt()', X::Undeclared::Symbols,
    'Correct : lexical named sub myNamedInt() should NOT BE available outside its scope';


#packge-scoped named subs

{
    our Str sub ourNamedStr() { return 'string' };
    is ourNamedStr(), 'string', 'package-scoped named sub() return Str';
}

{
    our &ourNamedStr;
    is ourNamedStr(), 'string', 'Correct : package-scoped named sub ourNamedStr() should BE available in the whole package';
}

{
    our Int sub ourNamedInt() { return 55 };
    is ourNamedInt(), 55, 'package-scoped named sub() return Int';
}

{
    our &ourNamedInt;
    is ourNamedInt(), 55, 'Correct : package-scoped named sub ourNamedInt() should BE available in the whole package';
}

## TODO temporarily X::Comp::NYI (Multiple prefix constraints not yet implemented. Sorry.)
throws-like 'my Num List sub f () { return ("A",) }; f()',
    X::Comp::NYI,
    'Return of list with wrong type dies';

eval-lives-ok
    'my List sub f () { return () }; f()',
    'return of empty List should live';
is EVAL('my List sub f () { return () }; (f(), "a")'), ((),'a'),
    'return of empty List should be empty List';

## TODO temporarily X::Comp::NYI (Multiple prefix constraints not yet implemented. Sorry.)
throws-like 'my Num List sub f () { ("A",) }; f()',
    X::Comp::NYI,
    'implicit return of list with wrong type dies';

# vim: ft=perl6
