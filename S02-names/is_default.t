use v6;
use Test;

plan 20;

# L<S02/Variables Containing Undefined Values

#?pugs   skip "is default NYI"
#?niecza skip "is default NYI"
# not specifically typed
{
    my $a is default(42);
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "uninitialized untyped variable should have its default";
    lives_ok { $a++ }, "should be able to update untyped variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 43, "update of untyped variable to 43 was successful";
    lives_ok { $a = Nil }, "should be able to assign Nil to untyped variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "untyped variable returned to its default with Nil";
    lives_ok { $a = 314 }, "should be able to update untyped variable";
    is $a, 314, "update of untyped variable to 314 was successful";
    lives_ok { undefine $a }, "should be able to undefine untyped variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "untyped variable returned to its default with undefine";

    my $b is default(42) = 768;
    is $b, 768, "untyped variable should be initialized";
} #10

#?pugs   skip "Int is default NYI"
#?niecza skip "Int is default NYI"
# typed
{
    my Int $a is default(42);
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "uninitialized typed variable should have its default";
    lives_ok { $a++ }, "should be able to update typed variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 43, "update of typed variable to 43 was successful";
    lives_ok { $a = Nil }, "should be able to assign Nil to typed variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "typed variable returned to its default with Nil";
    lives_ok { $a = 314 }, "should be able to update typed variable";
    is $a, 314, "update of typed variable to 314 was successful";
    lives_ok { undefine $a }, "should be able to undefine typed variable";
    #?rakudo todo "is default not functioning yet"
    is $a, 42, "typed variable returned to its default with undefine";

    my Int $b is default(42) = 768;
    is $b, 768, "typed variable should be initialized";
} #10

# vim: ft=perl6
