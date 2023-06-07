use Test;

plan 1;

# various tests for built-in types
# L<S02/Built-In Data Types>

# https://github.com/Raku/old-issue-tracker/issues/3413
# TODO: typed exception instead of testing for specific error message
{
    throws-like {
        my $foo = ObjAt.new(:val("test"));
        $foo ~~ /"foo"/;
    },
        Exception,
        message => / 'Too few positionals passed' .+ 'expected 2 arguments but got 1' /,
        'no segfault in ObjAt initialization when passing bogus named arguments';
}

# vim: expandtab shiftwidth=4
