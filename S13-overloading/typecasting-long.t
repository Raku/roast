use v6;
use Test;

plan 4;

# L<S13/"Type Casting"/"method postcircumfix:<{ }> (**@slice) {...}">
# basic tests to see if the methods overload correctly.

#?niecza skip 'No value for parameter $capture in TypeCastSub.postcircumfix:<( )>'
{
    my multi testsub ($a,$b) {   #OK not used
        return 1;
    }
    my multi testsub ($a) {   #OK not used
        return 2;
    }
    my multi testsub () {
        return 3;
    }
    class TypeCastSub {
        method CALL-ME (|c) {return 'pretending to be a sub ' ~ testsub(|c) }
    }

    my $thing = TypeCastSub.new;
    is($thing(), 'pretending to be a sub 3', 'overloaded () call works');
    is($thing.(), 'pretending to be a sub 3', 'overloaded .() call works');
    is($thing.(1), 'pretending to be a sub 2', 'overloaded .() call works');
    is($thing.(1,2), 'pretending to be a sub 1', 'overloaded .() call works');
}


# vim: ft=perl6
