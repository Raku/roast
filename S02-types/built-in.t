use v6.c;

use Test;

plan 1;

# various tests for built-in types
# L<S02/Built-In Data Types>

# RT #122094
# TODO: better test (e.g. typed exception instead of testing for backend specific error messages
{
    throws-like {
        my $foo = ObjAt.new(:val("test"));
        $foo ~~ /"foo"/;
    },
    Exception,
    message => / 'Too few positionals passed; expected 2 arguments but got 1' /,
        'no segfault in ObjAt initalization when passing bogus named parameters';
}

# vim: ft=perl6
