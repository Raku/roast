use v6.c;
use Test;

plan 15;

{
    my @a;
    nok @a.Bool, '@a.Bool returns False for empty @a';
    nok ?@a,     '?@a returns False for empty @a';
    nok @a,      '@a in bool context returns False for empty @a';
    
    @a.push: 37;
    ok @a.Bool, '@a.Bool returns True for @a with one element';
    ok ?@a,     '?@a returns True for @a with one element';
    ok @a,      '@a in bool context returns True for @a with one element';

    @a.push: -23;
    ok @a.Bool, '@a.Bool returns True for @a with two elements';
    ok ?@a,     '?@a returns True for @a with two elements';
    ok @a,      '@a in bool context returns True for @a with two elements';
}

{
    my @a = 4..3;
    nok @a.Bool, '@a.Bool returns False for empty range in @a';
    nok ?@a,     '?@a returns False for empty range in @a';
    nok @a,      '@a in bool context returns False for empty range in @a';
    
    @a = 4..6;
    ok @a.Bool, '@a.Bool returns True for non-empty range in @a';
    ok ?@a,     '?@a returns True for non-empty range in @a';
    ok @a,      '@a in bool context returns True for non-empty range in @a';
}

# TODO: This could definitely use tests to make sure that @a.Bool only examines
# the first (few?) elements of @a.

# vim: ft=perl6
