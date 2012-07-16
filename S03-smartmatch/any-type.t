use v6;
use Test;
plan 15;

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

# RT #71462
{
    is 'RT71462' ~~ Str,      True,  '~~ Str returns a Bool (1)';
    is 5         ~~ Str,      False, '~~ Str returns a Bool (2)';
    is 'RT71462' ~~ Int,      False, '~~ Int returns a Bool (1)';
    is 5         ~~ Int,      True,  '~~ Int returns a Bool (2)';
    #?pugs 2 skip 'Set'
    is 'RT71462' ~~ Set,      False, '~~ Set returns a Bool (1)';
    is set(1, 3) ~~ Set,      True,  '~~ Set returns a Bool (2)';
    #?pugs 2 skip 'Numeric'
    is 'RT71462' ~~ Numeric,  False, '~~ Numeric returns a Bool (1)';
    is 5         ~~ Numeric,  True,  '~~ Numeric returns a Bool (2)';
    #?pugs 2 skip 'Callable'
    is &say      ~~ Callable, True,  '~~ Callable returns a Bool (1)';
    is 5         ~~ Callable, False, '~~ Callable returns a Bool (2)';
}

# RT 76610
{
    module M { };
    #?niecza todo "Unable to resolve method ACCEPTS in type M"
    lives_ok { 42 ~~ M }, '~~ module lives';
    ok not $/, '42 is not a module';
}

done;

# vim: ft=perl6
