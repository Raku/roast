use v6;
use Test;

plan 14;

# L<S13/"Type Casting"/"method %.{ **@slice } {...}">
# basic tests to see if the methods overload correctly.
{
    class TypeCastMixed {
        method &.( |capture ) {
            return 'pretending to be a sub';
        }   #OK not used
        method postcircumfix:<[ ]> (**@slice) {   # METHOD TO SUB CASUALTY
            return 'pretending to be an array';
        }   #OK not used
        method %.{ **@slice } {                   # METHOD TO SUB CASUALTY
            return 'pretending to be a hash';
        }   #OK not used
    }

    my $thing = TypeCastMixed.new;
    is($thing(), 'pretending to be a sub', 'overloaded () call works');
    is($thing.(), 'pretending to be a sub', 'overloaded .() call works');
    #?rakudo 2 skip 'cannot easily override [] at the moment'
    is($thing[1], 'pretending to be an array', 'overloaded [] call works');
    is($thing[2,3], 'pretending to be an array', 'overloaded [] call works (slice)');
    #?rakudo todo 'cannot easily override [] at the moment'
    is($thing.[4], 'pretending to be an array', 'overloaded .[] call works');
    #?rakudo skip 'cannot easily override [] at the moment'
    is($thing.[5,6], 'pretending to be an array', 'overloaded .[] call works (slice)');
    #?rakudo todo 'cannot easily override {} at the moment'
    is($thing{'a'}, 'pretending to be a hash', 'overloaded {} call works');
    #?rakudo skip 'cannot easily override {} at the moment'
    is($thing{'b','c'}, 'pretending to be a hash', 'overloaded {} call works (slice)');
    #?rakudo todo 'cannot easily override {} at the moment'
    is($thing.{'d'}, 'pretending to be a hash', 'overloaded .{} call works');
    #?rakudo skip 'cannot easily override {} at the moment'
    is($thing.{'e','f'}, 'pretending to be a hash', 'overloaded .{} call works (slice)');
    #?rakudo todo 'cannot easily override {} at the moment'
    is($thing<a>, 'pretending to be a hash', 'overloaded <> call works');
    #?rakudo skip 'cannot easily override {} at the moment'
    is($thing<b c>, 'pretending to be a hash', 'overloaded <> call works (slice)');
    #?rakudo todo 'cannot easily override {} at the moment'
    is($thing.<d>, 'pretending to be a hash', 'overloaded .<> call works');
    #?rakudo skip 'cannot easily override {} at the moment'
    is($thing.<e f>, 'pretending to be a hash', 'overloaded .<> call works (slice)');
}

# vim: ft=perl6
