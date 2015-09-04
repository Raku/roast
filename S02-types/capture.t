use v6;

use Test;

plan 29;

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
    throws-like { foo2(|$capture) },
      Exception,
      'simply capture creation with \\( works (2)';
}

{
    my $capture = \(1, named => "arg");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo3 ($a, :$named) { "$a!$named" }
    is foo3(|$capture), "1!arg",
        'simply capture creation with \\( works (3)';
}

{
    my $capture = \(1, 'positional' => "pair");

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo4 ($a, $pair) { "$a!$pair" }
    is foo4(|$capture), "1!positional\tpair",
        'simply capture creation with \\( works (4)';
}

{
    my @array   = <a b c>;
    my $capture = \(@array);

    # L<S03/Argument List Interpolating/explicitly flatten it in one of>
    sub foo5 (@arr) { ~@arr }
    is foo5(|$capture), "a b c",
        'capture creation with \\( works';
}

# L<S06/Argument list binding/single scalar parameter marked>
{
    sub bar6 ($a, $b, $c) { "$a!$b!$c" }
    sub foo6 (|capture)  { bar6(|capture) }

    is foo6(1,2,3), "1!2!3",
        'capture creation with \\$ works (1)';
    throws-like { foo6(1,2,3,4) },
      Exception,  # too many args
      'capture creation with \\$ works (2)';
    throws-like { foo6(1,2) },
      Exception,  # too few args
      'capture creation with \\$ works (3)';
}

# Arglists are first-class objects
{
    my $capture;
    sub foo7 (|args) { $capture = args }

    lives-ok { foo7(1,2,3,4) }, "captures are first-class objects (1)";
    ok $capture,               "captures are first-class objects (2)";

    my $old_capture = $capture;
    lives-ok { foo7(5,6,7,8) }, "captures are first-class objects (3)";
    ok $capture,               "captures are first-class objects (4)";
    ok !($capture === $old_capture), "captures are first-class objects (5)";
}

{
    my $capture1;
    sub foo8 ($args) { $capture1 = $args }

    my $capture2 = \(1,2,3);
    try { foo8 $capture2 };  # note: no |$args here

    ok $capture1 eqv $capture2,
        "unflattened captures can be passed to subs";
}

# Mixing ordinary args with captures
{
    my $capture = \(:foo<bar>, :baz<grtz>);
    sub foo9 ($a,$b, :$foo, :$baz) { "$a!$b!$foo!$baz" }

    throws-like { foo9(|$capture) },
      Exception,  # too few args
      "mixing ordinary args with captures (1)";
    is foo9(1, 2, |$capture), "1!2!bar!grtz",
        "mixing ordinary args with captures (2)";
}

{
    my @a = 1, 2;
    my $capture = \(|@a,3);
    sub foo10 ($a, $b, $c) { "$a!$b!$c" }
    is foo10(|$capture), "1!2!3",
        '|@a interpolation into \(...) works';
}

{
    my %h = named => 'arg';
    my $capture = \(1, |%h);

    sub foo11 ($a, :$named) { "$a!$named" }
    is foo11(|$capture), "1!arg",
        '|%h interpolation into \(...) works';
}

{
    # RT #78496
    my $c = ('OH' => 'HAI').Capture;
    is $c<key>,   'OH',  '.<key> of Pair.Capture';
    is $c<value>, 'HAI', '.<value> of Pair.Capture';
}

# RT #89766
nok (defined  \()[0]), '\()[0] is not defined';

# RT #116002
{
    class RT116002 {
        method foo (Int) {}
    }
    my @a = 42;

    ok \(RT116002, 42) ~~ RT116002.^find_method("foo").signature,
        'capture with scalar matches signature';
    nok \(RT116002, @a) ~~ RT116002.^find_method("foo").signature,
        'capture with one element array does not match signature';
    ok \(RT116002, |@a) ~~ RT116002.^find_method("foo").signature,
        'capture with infix:<|> on one element array matches signature';
}

# RT #75850
{
    is @(\( (:a(2)) )).elems, 1, 'Parens around a colonpair in \(...) make a positional (1)';
    is %(\( (:a(2)) )).elems, 0, 'Parens around a colonpair in \(...) make a positional (2)';
}

# RT #114100
{
    sub f(|everything) { everything.perl };
    my %h = :a, :b, :!c;
    ok f(%h) ~~ /'\(' \s* '{'/, 'Hashes not flattened into capture list';
}

# RT #125505
{
    my $a = 41;
    my $c = \($a);
    $c[0]++;
    is $a, 42, 'Can modify Capture positional elements';
}
{
    my $a = 41;
    my $c = \(:$a);
    $c<a>++;
    is $a, 42, 'Can modify Capture associative elements';
}

# vim: ft=perl6
