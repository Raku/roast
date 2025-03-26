use Test;

# L<S02/"Built-In Data Types"/Raku>

plan 30;

=begin description

These tests test subroutine references and their invocation.

See L<S02/"Built-in Data Types"> for more information about Code, Routine, Sub, Block, etc.

=end description

# Quoting A06:
#                                   Code
#                        ____________|________________
#                       |                             |
#                    Routine                        Block
#       ________________|_______________
#      |     |       |       |    |     |
#     Sub Method Submethod Multi Rule Macro

{
    my $foo = sub () { 42 };
    isa-ok($foo, Code);
    isa-ok($foo, Routine);
    isa-ok($foo, Sub);
    is $foo.(), 42,                 "basic invocation of an anonymous sub";
    dies-ok { $foo.(23) }, "invocation of a parameterless anonymous sub with a parameter dies";
}

{
    my $foo = -> { 42 };
    isa-ok($foo, Code);
    isa-ok($foo, Block);
    is $foo.(), 42,                 "basic invocation of a pointy block";
    dies-ok { $foo.(23) },  "invocation of a parameterless pointy block with a parameter dies";
}

{
    my $foo = { 100 + $^x };
    isa-ok($foo, Code);
    isa-ok($foo, Block);
    is $foo.(42), 142,              "basic invocation of a pointy block with a param";
    dies-ok { $foo.() }, "invocation of a parameterized block expecting a param without a param dies";
}

# https://github.com/Raku/old-issue-tracker/issues/798
{
    my $topic = 'topic unchanged';
    my @topic_array = <topic array unchanged>;
    my $c = { $topic = $_; @topic_array = @_ };

    $c( 2, 3, 4, 5 );

    #?rakudo 2 todo 'RT #63974'
    is $topic, 2, '$_ got right value for code ref';
    is @topic_array, ( 3, 4, 5 ), '@_ got right value in code ref';
}

{
    my $foo = sub { 100 + (@_[0] // -1) };
    isa-ok($foo, Code);
    isa-ok($foo, Routine);
    isa-ok($foo, Sub);
    is $foo.(42), 142,              "basic invocation of a Perl-like anonymous sub (1)";
    is $foo.(),    99,              "basic invocation of a Perl-like anonymous sub (2)";
}

{
    my $foo = sub ($x) { 100 + $x };
    isa-ok($foo, Code);
    isa-ok($foo, Routine);
    isa-ok($foo, Sub);
    is $foo.(42),      142,    "calling an anonymous sub with a positional param";
    dies-ok { $foo.() },
        "calling an anonymous sub expecting a param without a param dies";
    dies-ok { $foo.(42, 5) },
        "calling an anonymous sub expecting one param with two params dies";
}

{
    my $mkinc = sub { my $x = 0; return sub { $x++ }; };

    my $inc1 = $mkinc();
    my $inc2 = $mkinc();

    is($inc1(), 0, "closures: inc1 == 0");
    is($inc1(), 1, "closures: inc1 == 1");
    is($inc2(), 0, "closures: inc2 == 0");
    is($inc2(), 1, "closures: inc2 == 1");
}

# vim: expandtab shiftwidth=4
