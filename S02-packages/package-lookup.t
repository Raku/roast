use v6;
use Test;

plan 4;

# L<S02/Package lookup/>

class A {
    our sub foo() { 'I am foo' };
}

isa_ok A::, Stash, 'Typename:: is a Stash';
ok A::<&foo>, 'can access a subroutine in the stash';
ok A:: === A.WHO, 'A::  returns the same as A.WHO';

# RT 74412
{
    class P {
        my $q;
        method r {
            $P::q = 5;
            return $P::q;
        }
    };

    lives_ok { P.new.r ~~ 5 or die },
        'can access a variable in a class package through its long name';
}