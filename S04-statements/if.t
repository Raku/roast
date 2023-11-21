use v6.c;

use Test;

plan 43;

=begin kwid

Basic "if" tests.


=end kwid

# L<S04/Conditional statements>

my $x = 'test';
if $x eq $x { pass('if ($x eq $x) {} works'); } else { flunk('if ($x eq $x) {} failed'); }
if $x ne $x { flunk('if ($x ne $x) {} failed'); } else { pass('if ($x ne $x) {} works'); }
if 1 { pass('if (1) {} works'); } else { flunk('if (1) {} failed'); }
if 0 { flunk('if (0) {} failed'); } else { pass('if (0) {} works'); }
if Mu { flunk('if (Mu) {} failed'); } else { pass('if (Mu) {} works'); }

{
    # die called in the condition part of an if statement should die immediately
    # rather than being evaluated as true
    my $foo = 1;
    try { if die "should die" { $foo = 3 } else { $foo = 2; } };
    #say '# $foo = ' ~ $foo;
    is $foo, 1, "die should stop execution immediately.";
}

{
    my $foo = 1; # just in case
    if 1 > 2 { $foo = 2 } else { $foo = 3 };
    is $foo, 3, 'if with no parens';
};

# if...elsif
{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 1 { $foo = 3 };
    is $foo, 2, 'if (1) {} elsif (1) {}';
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 0 { $foo = 3 };
    is $foo, 2, 'if (1) {} elsif (0) {}';
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 1 { $foo = 3 };
    is $foo, 3, 'if (0) {} elsif (1) {}';
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 0 { $foo = 3 };
    is $foo, 1, 'if (0) {} elsif (0) {}';
}


# if...elsif...else

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 0 { $foo = 3 } else { $foo = 4 };
    is $foo, 4;
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 0 { $foo = 3 } else { $foo = 4 };
    is $foo, 2;
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 1 { $foo = 3 } else { $foo = 4 };
    is $foo, 2;
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 1 { $foo = 3 } else { $foo = 4 };
    is $foo, 3;
}

{
    my $foo = 1;
    if { 1 > 0 } { $foo = 2 } else { $foo = 3 };
    is $foo, 2, 'if with parens, and closure as cond';
}

{
    my $var = 9;
    my sub func( $a, $b, $c ) { $var };    #OK not used
    if func 1, 2, 3 { $var = 4 } else { $var = 5 };
    is $var, 4, 'if with no parens, and call a function without parenthesis';
}

# I'm not sure where this should go

{
    my $flag = 0;
    if (my $x = 2) == 2 { $flag = $x }
    is($flag, 2, "'my' variable within 'if' conditional");
}

{
    throws-like 'if 1; 2', X::Syntax::Missing, '"if" requires a block';
}

# L<S04/"Conditional statements"/The value of the conditional expression may be optionally bound to a closure parameter>
{
    my ($got, $a_val, $b_val);
    my sub testa { $a_val };
    my sub testb { $b_val };

    $a_val = 'truea';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, 'truea', 'if test() -> $a { } binding';

    $a_val = 0;
    $b_val = 'trueb';
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, 'trueb', 'elsif test() -> $b { } binding';

    $a_val = '';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, 0, 'else -> $c { } binding previous elsif';

    $a_val = '';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    else          -> $c { $got = $c }
    is $got, '', 'else -> $c { } binding previous if';
}
# Sing it again.  This time with slurpy.
{
    my ($got, $a_val, $b_val);
    my sub testa { $a_val };
    my sub testb { $b_val };

    $a_val = 'truea';
    $b_val = 0;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = @c }
    is $got, ('truea',), 'if test() -> *@a { } binding';

    $a_val = 0;
    $b_val = 2;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = @c }
    is $got, 2, 'elsif test() -> *@b { } binding';

    $a_val = '';
    $b_val = 3 but False;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = (@c, "yes") }
    is $got, (3, "yes"), 'else -> *@c { } binding previous elsif';

    $a_val = 4 but False;
    $b_val = 0;
    if    testa() -> *@a { $got = @a }
    else          -> *@c { $got = (@c, "yes") }
    is $got, (4, "yes"), 'else -> *@c { } binding previous if';
}

{
    my $called = 0;
    sub cond($when) {
        is $called,$when,"condition is checked in correct order";
        $called++;
        0;
    }
    if cond(0) {
    } elsif cond(1) {
    } elsif cond(2) {
    }
    is $called,3,"all conditions are checked";
}


# L<S04/"Conditional statements"/The result of a conditional statement is the result of the block chosen to execute.>

is (if 1 { 42 }), (42), "if evaluates to executed block";
is (if 0 { 42 } else { 43 }), (43), "if+else else evaluates to executed block";
is (if 0 { 42 } else { 43 }), (43), "if+else if evaluates to executed block";
is (if 0 { 42 } elsif 0 { 43 } else { 44 }), (44), "if+elsif+else else evaluates to executed block";
is (if 0 { 42 } elsif 1 { 43 } else { 44 }), (43), "if+elsif+else elsif evaluates to executed block";
is (if 1 { 42 } elsif 0 { 43 } else { 44 }), (42), "if+elsif+else if evaluates to executed block";
is (if 0 { 42 } elsif 1 { 43 }), (43), "if+elsif elsif evaluates to executed block";
is (if 1 { 42 } elsif 0 { 43 }), (42), "if+elsif if evaluates to executed block";
is-deeply (if 0 { 42 } elsif 0 { 43 }), Empty, "if+elsif evaluates to () when no block chosen";
is-deeply (if 0 { 42 }), Empty, "if evaluates to () when no block chosen";

# L<S04/Statement parsing/keywords require whitespace>
throws-like 'if($x > 1) {}', X::Comp::Group, 'keyword needs at least one whitespace after it';

# RT #76174
# scoping of $_ in 'if' shouldn't break aliasing
{
    my @a = 0, 1, 2;
    for @a { if $_ { $_++ } };
    is ~@a, '0 2 3', '"if" does not break lexical aliasing of $_'
}

# vim: ft=perl6
