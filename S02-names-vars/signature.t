use v6;

use Test;

plan 12;

# The :() form constructs signatures similar to how \() constructs Captures.
# A subroutine's .signature is a Siglist object.

#L<S02/Names and Variables/"A signature object">

{
    my $a;
    ok :($a) ~~ Signature, ':($a) create a Signature object';
    :($a) := 3;
    #?rakudo 2 todo 'signature binding'
    is $a, 3, 'can bind to one-element signature';
    dies_ok { $a++ }, 'cannot increment an Int';

    my $b = :();
    ok $b.WHAT === Signature, '.WHAT on :() is Signature';
}


#?rakudo 2 todo 'signature binding'
{
    my ($x, $y, $z);
    :($x,$y,$z) := (1,2,3);
    is("$x $y $z", "1 2 3", "siglist bindings works");
}

# Same, but more complex
{
    my ($x, @y, @rest);
    :($x,@y,*@rest) := (42,[13,17],5,6,7);
    #?pugs todo 'feature'
    is("$x!{@y}!{@rest}", "42!13 17!5 6 7", "complex siglist bindings works (1)");
}

{
    my ($x);
    :($x?) := ();
    ok(!$x.defined, "complex siglist bindings works (2)");
}

# &sub.signature should return a Siglist object
{
    sub foo1 ($a, $b) {}    #OK not used
    my $siglist = :($a, $b);

    ok ~$siglist,
        "a siglist stringifies";
    #?pugs todo 'feature'
    #?rakudo todo 'eqv on signatures'
    ok $siglist eqv &foo1.signature,
        "a subroutine's siglist can be accessed via .signature (1)";
}

# Same as above, but more complex
{
    my sub foo (Num $a, $b?, *@rest) {}    #OK not used
    my $siglist = :(Num $a, $b?, *@rest);

    #?pugs todo 'feature'
    #?rakudo todo 'eqv on signatures'
    ok $siglist eqv &foo.signature ,
        "a subroutine's siglist can be accessed via .signature (2)";
}

{
    my sub foo ($a, $b) {}   #OK not used
    my $siglist = :($a);

    ok $siglist !eqv &foo.signature,
        "a subroutine's siglist can be accessed via .signature (3)";
}

{
    my @a = 1,2,3;
    my (@c) = @a;
    my $i = 0;
    $i++ for @c;
    is $i, 3, 'asigning to an array in a signature is sane';
}

# vim: ft=perl6
