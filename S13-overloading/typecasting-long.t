use v6;
use Test;

plan 14;

# L<S13/"Type Casting"/"method postcircumfix:<{ }> (*@@slice) {...}">
# basic tests to see if the methods overload correctly.

{
    module TypeCastSub {
        method postcircumfix:<( )> (|$capture) {return 'pretending to be a sub'}
    }

    my $thing = TypeCastSub.new;
    is($thing(), 'pretending to be a sub', 'overloaded () call works');
    is($thing.(), 'pretending to be a sub', 'overloaded .() call works');
}

{
    module TypeCastArray {
        method postcircumfix:<[ ]> (*@@slice) {return 'pretending to be an array'}
    }

    my $thing = TypeCastArray.new;
    is($thing[1], 'pretending to be an array', 'overloaded [] call works');
    is($thing[2,3], 'pretending to be an array', 'overloaded [] call works (slice)');
    is($thing.[4], 'pretending to be an array', 'overloaded .[] call works');
    is($thing.[5,6], 'pretending to be an array', 'overloaded .[] call works (slice)');
}

{
    module TypeCastHash {
        method postcircumfix:<{ }> (*@@slice) {return 'pretending to be a hash'}
    }

    my $thing = TypeCastHash.new;
    is($thing{'a'}, 'pretending to be a hash', 'overloaded {} call works');
    is($thing{'b','c'}, 'pretending to be a hash', 'overloaded {} call works (slice)');
    is($thing.{'d'}, 'pretending to be a hash', 'overloaded .{} call works');
    is($thing.{'e','f'}, 'pretending to be a hash', 'overloaded .{} call works (slice)');
    is($thing<a>, 'pretending to be a hash', 'overloaded <> call works');
    is($thing<b c>, 'pretending to be a hash', 'overloaded <> call works (slice)');
    is($thing.<d>, 'pretending to be a hash', 'overloaded .<> call works');
    is($thing.<e f>, 'pretending to be a hash', 'overloaded .<> call works (slice)');
}
