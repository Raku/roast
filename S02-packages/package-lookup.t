use v6;
use Test;

plan 3;

# L<S02/Package lookup/>

class A {
    our sub foo() { 'I am foo' };
}

isa_ok A::, Stash, 'Typename:: is a Stash';
ok A::<&foo>, 'can access a subroutine in the stash';
ok A:: === A.WHO, 'A::  returns the same as A.WHO';
