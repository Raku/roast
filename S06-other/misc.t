use v6;

use Test;

plan 16;

#not really much of a test (no links to the spec either). Please improve, I only wrote what was required! --lue

sub a () { my $a=4; }; #zero-arg sub to test the underlying problem   #OK not used

throws-like 'e("wtz")', X::Undeclared,
    "e should not be defined to accept arguments";
throws-like 'pi("wtz")', X::Undeclared,
    "pi should not be defined to accept arguments either :) ";
dies-ok { EVAL('a(3)') }, "this should die, no arguments defined";

# RT #76096
{
    lives-ok {  sub foo($ where 1 --> Int) { return 42 } },
        "where clause combined with --> works";
    lives-ok {  sub foo($ where 1, $y  --> Int) { return 42 } },
        "where clause combined with --> works";
}

# RT #118875
{
    lives-ok { sub ndr($r where ($r ||= 10) > 0 && 1) { } },
        'where clause followed by (non-parenthesized) expression with "&&" in it does parse';
}

# RT #117901
{
    my $rt117901;
    sub not-foo { $rt117901 = 2 };
    sub so-what { $rt117901 = "nyan" };
    sub m-bar { $rt117901 = "string" };
    not-foo();
    is $rt117901, 2, "can name sub 'not-foo'";
    so-what();
    is $rt117901, "nyan", "can name sub 'so-what'";
    m-bar();
    is $rt117901, "string", "can name sub 'm-bar'";
}

# RT #125376
{
    throws-like 'my $rt125376 = Sub.new; say $rt125376', Exception,
        'no Segfault when creating a Sub object with .new and trying to say it';
    throws-like 'my $rt125376 = Sub.bless; say $rt125376', Exception,
        'no Segfault when creating a Sub object with .bless and trying to say it';
    throws-like 'Sub(0)', Exception, 'no Segfault when trying to invoke the Sub type object';
}

# RT #129780
{
    throws-like
        { EVAL q|sub foo($a where {* < 5 or $a > 9}) { dd $a }| },
        X::Syntax::Malformed,
        'where clause with only one *, but two expressions',
        message => /Malformed \s double \s closure/;

    throws-like
        { EVAL q|sub foo($a where {* < 5 or * > 9}) { dd $a }| },
        X::Syntax::Malformed,
        'where clause with two *s and two expressions (with an or)',
        message => /Malformed \s double \s closure/;

    throws-like
        { EVAL q|sub foo($a where {* < 5 and * > 9}) { dd $a }| },
        X::Syntax::Malformed,
        'where clause with two *s and two expressions (with an and)',
        message => /Malformed \s double \s closure/;

    throws-like
        { EVAL q|sub foo($a where {* < 5 and * > 9 and *.char == 2}) { dd $a }| },
        X::Syntax::Malformed,
        'where clause with three *s and three expressions',
        message => /Malformed \s double \s closure/;
}

# vim: ft=perl6 expandtab sw=4
