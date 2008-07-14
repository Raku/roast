use v6;

use Test;

plan 13;

# The :() form constructs signatures similar to how \() constructs arguments.
# A subroutine's .signature is a Siglist object.

#L<S02/Names and Variables/"A signature object">

# Basic siglist binding --
#   $x    := 42;  # is sugar for
#   :($x) := 42;  # which in turn is sugar for
#   :($x).infix:<:=>(42);

#?rakudo skip '.infix:<:=>()'
#?pugs skip "todo: signature objects"
{
    my $x;
    my $siglist = eval :($x);
    $siglist.infix:<:=>(42);
    is($x, 42, "basic siglist binding works");
    dies_ok { $x++ }, "binding was really a binding, not an assignment";
}

# same with direct := syntax
{
    my $x;

    my $siglist = :($x);
    $siglist := 42;
    is($x, 42, "basic siglist binding works", :todo<feature>);
    dies_ok { $x++ }, "binding was really a binding, not an assignment", :todo<feature>;
}

#?rakudo skip '.infix:<:=>()'
{
    my ($x, $y, $z);
    my $siglist = eval ':($x,$y,$z)';
    try { $siglist.infix:<:=>(1,2,3)};
    is("$x $y $z", "1 2 3", "siglist bindings works", :todo<feature>);
}

# Same, but more complex 
#?rakudo skip '.infix:<:=>()'
{
    my ($x, @y, @rest);
    my $siglist = eval ':($x,@y,*@rest)';
    try { $siglist.infix:<:=>(42,[13,17],5,6,7) };
    is("$x!@y[]!@rest[]", "42!13 17!5 6 7", "complex siglist bindings works (1)", :todo<feature>);
}

#?rakudo skip '.infix:<:=>()'
{
    my ($x);
    my $siglist = eval ':($x?)';
    try { $siglist.infix:<:=>() };
    ok(!exists $x, "complex siglist bindings works (2)", :todo<feature>);
}

# &sub.signature should return a Siglist object
{
    my sub foo ($a, $b) {}
    my $siglist = :($a, $b);

    ok $siglist,
        "a subroutine's siglist can be accessed via .signature (1-1)";
    #?rakudo skip 'infix:<===>'
    cmp_ok $siglist, &infix:<===>, &foo.signature,
        "a subroutine's siglist can be accessed via .signature (1-2)", :todo<feature>;
}

# Same as above, but more complex
#?rakudo skip 'infix:<===>'
{
    my sub foo (Num $a, $b?, *@rest) {}
    my $siglist = :(Num $a, $b?, *@rest);

    cmp_ok $siglist, &infix:<===>, &foo.signature ,
        "a subroutine's siglist can be accessed via .signature (2)", :todo<feature>;
}

#?rakudo 999 skip 'Rest not properly fudged'
{
    my sub foo ($a, $b) {}
    my $siglist = :($a);

    ok !($siglist === try { &foo.signature }),
        "a subroutine's siglist can be accessed via .signature (3)";
}

# User-customized binding
{
    my $x = 42;
    my $siglist = eval '(:($x)) but role {
        method infix:<:=> {
            # do nothing
        }
    }';

    try { $siglist.infix:<:=>(23) };
    is $x, 42,        "user-defined binding worked as expected (1)";
    lives_ok { $x++}, "user-defined binding worked as expected (2)";
}

# vim: ft=perl6
