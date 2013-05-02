use v6;

use Test;

plan 3;

# test splatted parameter for rw ability
# L<S06/"Parameter traits"/"is rw">

my @test = 1..5;
my $test = 42;
lives_ok {
    my sub should_work ( *@list is rw ) {
        @list[0]   = "hi"; 
        @list[*-1] = "ho"; 
    }
    should_work(@test, $test);
}, "trying to use an 'is rw' splat does work out";
is(@test[0], "hi", "@test was changed");
is($test,    "ho", '$test was changed');

# vim: ft=perl6
