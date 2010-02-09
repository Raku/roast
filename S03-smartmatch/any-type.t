use v6;
use Test;
plan 3;

#L<S03/Smart matching/type membership>
{ 
    class Dog {}
    class Cat {}
    class Chihuahua is Dog {} # i'm afraid class Pugs will get in the way ;-)
    role SomeRole { };
    class Something does SomeRole { };

    ok (Chihuahua ~~ Dog), "chihuahua isa dog";
    ok (Something ~~ SomeRole), 'something does dog';
    ok !(Chihuahua ~~ Cat), "chihuahua is not a cat";
}

done_testing;

# vim: ft=perl6
