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

# https://github.com/Raku/old-issue-tracker/issues/1875
{
    lives-ok {  sub foo($ where 1 --> Int) { return 42 } },
        "where clause combined with --> works";
    lives-ok {  sub foo($ where 1, $y  --> Int) { return 42 } },
        "where clause combined with --> works";
}

# https://github.com/Raku/old-issue-tracker/issues/3189
{
    lives-ok { sub ndr($r where ($r ||= 10) > 0 && 1) { } },
        'where clause followed by (non-parenthesized) expression with "&&" in it does parse';
}

# https://github.com/Raku/old-issue-tracker/issues/3125
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

# https://github.com/Raku/old-issue-tracker/issues/4312
{
    throws-like 'my $rt125376 = Sub.new; say $rt125376', Exception,
        'no Segfault when creating a Sub object with .new and trying to say it';
    throws-like 'my $rt125376 = Sub.bless; say $rt125376', Exception,
        'no Segfault when creating a Sub object with .bless and trying to say it';
    throws-like 'Sub(0)', Exception, 'no Segfault when trying to invoke the Sub type object';
}

# https://github.com/Raku/old-issue-tracker/issues/5713
{
    throws-like ｢sub foo($a where {* < 5 or $a > 9}) { say $a }｣,
        X::Syntax::Malformed, :what{.contains: 'closure'},
        'where clause with only one *, but two expressions';

    throws-like ｢sub foo($a where {* < 5 or * > 9}) { say $a }｣,
        X::Syntax::Malformed, :what{.contains: 'closure'},
        'where clause with two *s and two expressions (with an or)';

    throws-like ｢sub foo($a where {* < 5 and * > 9}) { say $a }｣,
        X::Syntax::Malformed, :what{.contains: 'closure'},
        'where clause with two *s and two expressions (with an and)';

    throws-like
        ｢sub foo($a where {* < 5 and * > 9 and *.char == 2}) { say $a }｣,
        X::Syntax::Malformed, :what{.contains: 'closure'},
        'where clause with three *s and three expressions';
}

# vim: expandtab shiftwidth=4
