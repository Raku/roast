use v6;

use Test;

plan 2;

# test splatted parameter for rw ability
# L<S06/"Subroutine traits"/"is rw">

my @test = 1..5;
lives_ok {
    my sub should_work ( *@list is rw ) {
        @list[0] = "hi"; 
    }
    should_work(@test);
}, "trying to use an 'is rw' splat does work out";
is(@test[0], "hi", "@test was changed");

# vim: ft=perl6
