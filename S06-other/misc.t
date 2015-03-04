use v6;

use Test;

plan 9;

#not really much of a test (no links to the spec either). Please improve, I only wrote what was required! --lue

sub a () { my $a=4; }; #zero-arg sub to test the underlying problem   #OK not used

eval_dies_ok 'e("wtz")', "e should not be defined to accept arguments";
eval_dies_ok 'pi("wtz")',"pi should not be defined to accept arguments either :) ";
dies_ok { EVAL('a(3)') }, "this should die, no arguments defined";

# RT #76096
{
    lives_ok {  sub foo($ where 1 --> Int) { return 42 } },
        "where clause combined with --> works";
    lives_ok {  sub foo($ where 1, $y  --> Int) { return 42 } },
        "where clause combined with --> works";
}

# RT #118875
{
    lives_ok { sub ndr($r where ($r ||= 10) > 0 && 1) { } },
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
