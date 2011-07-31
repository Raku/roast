use v6;

use Test;

plan 18;

{
    my $capture = \(1,2,3);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo1 ($a, $b, $c) { "$a!$b!$c" }
    is foo1(|$capture), "1!2!3",
        'simply capture creation with \\( works (1)';
}

{
    my $capture = \(1,2,3,'too','many','args');

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo2 ($a, $b, $c) { "$a!$b!$c" }
    dies_ok { foo2(|$capture) },
        'simply capture creation with \\( works (2)';
}

{
    my $capture = \(1, named => "arg");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo3 ($a, :$named) { "$a!$named" }
    #?rakudo skip 'nom regression'
    is foo3(|$capture), "1!arg",
        'simply capture creation with \\( works (3)';
}

{
    my $capture = \(1, 'positional' => "pair");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo4 ($a, $pair) { "$a!$pair" }
    #?rakudo skip 'should this pair not become positional?'
    is foo4(|$capture), "1!positional\tpair",
        'simply capture creation with \\( works (4)';
}

#?rakudo skip 'nom regression'
{
    my @array   = <a b c>;
    my $capture = \(@array);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo5 (@arr) { ~@arr }
    is foo5(|$capture), "a b c",
        'capture creation with \\( works';
}

# L<S06/Argument list binding/single scalar parameter marked>
#?rakudo skip 'nom regression'
{
    sub bar6 ($a, $b, $c) { "$a!$b!$c" }
    sub foo6 (|$capture)  { bar6(|$capture) }

    #?pugs todo "feature"
    is foo6(1,2,3), "1!2!3",
        'capture creation with \\$ works (1)';
    dies_ok { foo6(1,2,3,4) },  # too many args
        'capture creation with \\$ works (2)';
    dies_ok { foo6(1,2) },      # too few args
        'capture creation with \\$ works (3)';
    is try { foo6(a => 1, b => 2, c => 3) }, "1!2!3",
    #?pugs 2 todo "feature"
        'capture creation with \\$ works (4)';
    is try { foo6(1, b => 2, c => 3) }, "1!2!3",
        'capture creation with \\$ works (5)';
}

# Arglists are first-class objects
{
    my $capture;
    sub foo7 (|$args) { $capture = $args }

    lives_ok { foo7(1,2,3,4) }, "captures are first-class objects (1)";
    #?pugs todo "feature"
    ok $capture,               "captures are first-class objects (2)";

    my $old_capture = $capture;
    lives_ok { foo7(5,6,7,8) }, "captures are first-class objects (3)";
    #?pugs 2 todo "feature"
    ok $capture,               "captures are first-class objects (4)";
    ok !($capture === $old_capture), "captures are first-class objects (5)";
}

{
    my $capture1;
    sub foo8 ($args) { $capture1 = $args }

    my $capture2 = \(1,2,3);
    try { foo8 $capture2 };  # note: no |$args here

    ok $capture1 === $capture2,
        "unflattened captures can be passed to subs";
}

# Mixing ordinary args with captures
{
    my $capture = \(:foo<bar>, :baz<grtz>);
    sub foo9 ($a,$b, :$foo, :$baz) { "$a!$b!$foo!$baz" }

    #?rakudo todo 'nom regression'
    dies_ok { foo9(|$capture) },  # too few args
        "mixing ordinary args with captures (1)";
    #?rakudo skip 'nom regression'
    is foo9(1, 2, |$capture), "1!2!bar!grtz",
        "mixing ordinary args with captures (2)";
}

# vim: ft=perl6
