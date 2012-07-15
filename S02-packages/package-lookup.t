use v6;
use Test;

plan 6;

# L<S02/Package lookup/>

class A {
    my $x;
    method x { $A::x = 5; return $A::x; }
    our sub foo() { 'I am foo' };
}

isa_ok A::, Stash, 'Typename:: is a Stash';
ok A::<&foo>, 'can access a subroutine in the stash';
ok A:: === A.WHO, 'A::  returns the same as A.WHO';

# RT 74412
lives_ok { A.new.x ~~ 5 or die },
    'can access a variable in a class package through its long name from class method';

# RT 75632
lives_ok { my $A::y = 6; $A::y ~~ 6 or die },
    'can declare and access variable in a class package through its long name from outside class';
lives_ok { my $B::x = 7; $B::x ~~ 7 or die },
    'can declare and access variable through its long name without declaring package';
