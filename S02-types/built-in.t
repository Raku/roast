use v6;

use Test;

plan 1;

# various tests for built-in types
# L<S02/Built-In Data Types>

# RT 122094
# TODO: better test (e.g. typed exception instead of testing for backend specific error messages
{
    throws_like {
        my $foo = ObjAt.new(:val("test"));
        $foo ~~ /"foo"/;
    },
    Exception,
    message => {
        m/
            'Too few positionals passed; expected 2 arguments but got 1'
            |
            'Not enough positional parameters passed; got 1 but expected 2'
        /
        },
        'no segfault in ObjAt initalization when passing bogus named parameters';
}

done;

# vim: ft=perl6
