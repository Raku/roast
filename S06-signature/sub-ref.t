use v6;

use Test;

# L<S02/"Built-In Data Types"/Perl 6> 

plan 34;

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
    isa_ok($foo, Code);
    isa_ok($foo, Routine);
    isa_ok($foo, Sub);
    is $foo.(), 42,                 "basic invocation of an anonymous sub";
    dies_ok { $foo.(23) }, "invocation of a parameterless anonymous sub with a parameter dies";
}

{
    my $foo = -> { 42 };
    isa_ok($foo, Code);
    isa_ok($foo, Block);
    is $foo.(), 42,                 "basic invocation of a pointy block";
    dies_ok { $foo.(23) },  "invocation of a parameterless pointy block with a parameter dies";
}

{
    my $foo = { 100 + $^x };
    isa_ok($foo, Code);
    isa_ok($foo, Block);
    is $foo.(42), 142,              "basic invocation of a pointy block with a param";
    dies_ok { $foo.() }, "invocation of a parameterized block expecting a param without a param dies";
}

# RT #63974
#?pugs skip 'No compatible multi variant found: "$c"'
{
    my $topic = 'topic unchanged';
    my @topic_array = <topic array unchanged>;
    my $c = { $topic = $_; @topic_array = @_ };

    $c( 2, 3, 4, 5 );

    #?rakudo 2 todo 'RT #63974'
    #?niecza 2 todo
    is $topic, 2, '$_ got right value for code ref';
    is @topic_array, ( 3, 4, 5 ), '@_ got right value in code ref';
}

{
    my $foo = sub { 100 + (@_[0] // -1) };
    isa_ok($foo, Code);
    isa_ok($foo, Routine);
    isa_ok($foo, Sub);
    is $foo.(42), 142,              "basic invocation of a perl5-like anonymous sub (1)";
    is $foo.(),    99,              "basic invocation of a perl5-like anonymous sub (2)";
}

{
    my $foo = sub ($x) { 100 + $x };
    isa_ok($foo, Code);
    isa_ok($foo, Routine);
    isa_ok($foo, Sub);
    is $foo.(42),      142,    "calling an anonymous sub with a positional param";
    dies_ok { $foo.() }, 
        "calling an anonymous sub expecting a param without a param dies";
    dies_ok { $foo.(42, 5) },
        "calling an anonymous sub expecting one param with two params dies";
}

# Confirmed by p6l, see thread "Anonymous macros?" by Ingo Blechschmidt
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21825">
#?rakudo skip 'macros, compile time binding'
#?niecza skip 'macros NYI'
{
    # We do all this in a EVAL() not because the code doesn't parse,
    # but because it's safer to only call macro references at compile-time.
    # So we'd need to wrap the code in a BEGIN {...} block. But then, our test
    # code would be called before all the other tests, causing confusion. :)
    # So, we wrap the code in a EVAL() with an inner BEGIN.
    # (The macros are subject to MMD thing still needs to be fleshed out, I
    # think.)
    our &foo_macro ::= macro ($x) { "1000 + $x" };
    isa_ok(&foo_macro, Code);
    isa_ok(&foo_macro, Routine);
    #?pugs todo 'macros'
    isa_ok(&foo_macro, Macro);

    is foo_macro(3), 1003, "anonymous macro worked";
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

# vim: ft=perl6
