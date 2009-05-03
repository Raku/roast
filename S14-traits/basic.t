use v6;
use Test;

plan 8;

# L<S14/Traits/>

{
    role testtrait1 {
        method exists-only-in-test-trait {
            42;
        }
        multi trait_auxiliary:is(testtrait1 $trait, $container) {
            $container does testtrait1;
        }
    }
    my Int $x is testtrait1 = 3;
    lives_ok { $x.exists-only-in-test-trait() }, 
             'can access method that was mixed in by the trait';
    ok $x ~~ testtrait1, 'since its a mixin, it should do that role';
    is $x.exists-only-in-test-trait(), 42, 'right value';
}

# with an argument
# I don't know if that's supposed to be done with parametric roles,
# but it should work
{
    role multiply_with[$num] {
        multi method mul() {
            $num * self;
        }
        multi trait_auxiliary:is(multiply_with $trait, $cont, $n) {
            $cont does multiply_with[$n];
        }
    }

    my Num $x is multiply_with(4) = 5;
    ok $x ~~ multiply_with[4], 'matches multiply_with[4]';
    is $x.mul, 20, 'parametric traits';
}

# now the version that uses an attribute instead
{
    role multiply_with2 {
        has $.num is rw;
        multi method mul() {
            $.num * self;
        }
        multi trait_auxiliary:is(multiply_with2 $trait, $cont, $n) {
            $cont does multiply_with2($n);
        }
    }

    my Num $x is multiply_with2(4) = 5;
    ok $x ~~ multiply_with2, 'matches multiply_with[4]';
    is $x.mul, 20, 'parametric traits';
}

{
    class A { method b { 5 } };
    role different_keyword {
        multi method a() { b() };
        multi trait_auxiliary:implements(different_keyword $trait, $cont) {
            $cont does different_keyword();
        }
    }
    my A $x implements different_keyword .= new();
    is $x.a(), 5, 'can define other trait_auxiliary keywords';
}

# vim: ft=perl6
