use v6;
use Test;
plan *;

# RT #69610

class RT69610 {
    method rt69610() {
        return self;
    }
}

ok( { "foo" => &RT69610::rt69610 }.<foo>( RT69610.new ) ~~ RT69610,
    "Can return from method called from a hash lookup (RT 69610)" );

done_testing;

# vim: ft=perl6
