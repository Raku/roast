use v6;
use Test;

plan 72;

# L<S02/Variables Containing Undefined Values

#?pugs   skip "is default NYI"
#?niecza skip "is default NYI"
# not specifically typed
{
    my $a is default(42);
    is $a, 42, "uninitialized untyped variable should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is $a.VAR.default, 42, 'is the default set correctly for $a';
    lives_ok { $a++ }, "should be able to update untyped variable";
    is $a, 43, "update of untyped variable to 43 was successful";
    lives_ok { $a = Nil }, "should be able to assign Nil to untyped variable";
    is $a, 42, "untyped variable returned to its default with Nil";
    lives_ok { $a = 314 }, "should be able to update untyped variable";
    is $a, 314, "update of untyped variable to 314 was successful";
    lives_ok { undefine $a }, "should be able to undefine untyped variable";
    is $a, 42, "untyped variable returned to its default with undefine";

    my $b is default(42) = 768;
    is $b, 768, "untyped variable should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is $b.VAR.default, 42, 'is the default set correctly for $b';
} #12

#?pugs   skip "Int is default NYI"
#?niecza skip "Int is default NYI"
# typed
{
    my Int $a is default(42);
    is $a, 42, "uninitialized typed variable should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is $a.VAR.default, 42, 'is the default set correctly for Int $a';
    lives_ok { $a++ }, "should be able to update typed variable";
    is $a, 43, "update of typed variable to 43 was successful";
    lives_ok { $a = Nil }, "should be able to assign Nil to typed variable";
    is $a, 42, "typed variable returned to its default with Nil";
    lives_ok { $a = 314 }, "should be able to update typed variable";
    is $a, 314, "update of typed variable to 314 was successful";
    lives_ok { undefine $a }, "should be able to undefine typed variable";
    is $a, 42, "typed variable returned to its default with undefine";

    my Int $b is default(42) = 768;
    is $b, 768, "typed variable should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is $b.VAR.default, 42, 'is the default set correctly for Int $b';
} #12

#?pugs   skip "is default NYI"
#?niecza skip "is default NYI"
# not specifically typed
{
    my @a is default(42);
    is @a[0], 42, "uninitialized untyped array element should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is @a.VAR.default, 42, 'is the default set correctly for @a';
    lives_ok { @a[0]++ }, "should be able to update untyped array element";
    is @a[0], 43, "update of untyped array element to 43 was successful";
    lives_ok { @a[0] = Nil }, "assign Nil to untyped array element";
    is @a[0], 42, "untyped array element returned to its default with Nil";
    lives_ok { @a[0] = 314 }, "should be able to update untyped array element";
    is @a[0], 314, "update of untyped array element to 314 was successful";
    lives_ok { undefine @a[0] }, "undefine untyped array element";
    is @a[0], 42, "untyped array element returned to its default with undefine";

    my @b is default(42) = 768;
    is @b[0], 768, "untyped array element should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is @b.VAR.default, 42, 'is the default set correctly for @b';
} #12

#?pugs   skip "Int is default NYI"
#?niecza skip "Int is default NYI"
# typed
{
    my Int @a is default(42);
    is @a[0], 42, "uninitialized typed array element should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is @a.VAR.default, 42, 'is the default set correctly for Int @a';
    lives_ok { @a[0]++ }, "should be able to update typed array element";
    is @a[0], 43, "update of typed array element to 43 was successful";
    lives_ok { @a[0] = Nil }, "assign Nil to typed array element";
    is @a[0], 42, "typed array element returned to its default with Nil";
    lives_ok { @a[0] = 314 }, "should be able to update typed array element";
    is @a[0], 314, "update of typed array element to 314 was successful";
    lives_ok { undefine @a[0] }, "undefine typed array element";
    is @a[0], 42, "typed array element returned to its default with undefine";

    my Int @b is default(42) = 768;
    is @b[0], 768, "typed array element should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is @b.VAR.default, 42, 'is the default set correctly for Int @b';
} #12

#?pugs   skip "is default NYI"
#?niecza skip "is default NYI"
# not specifically typed
{
    my %a is default(42);
    is %a<o>, 42, "uninitialized untyped hash element should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is %a.VAR.default, 42, 'is the default set correctly for %a';
    lives_ok { %a<o>++ }, "should be able to update untyped hash element";
    is %a<o>, 43, "update of untyped hash element to 43 was successful";
    lives_ok { %a<o> = Nil }, "assign Nil to untyped hash element";
    is %a<o>, 42, "untyped hash element returned to its default with Nil";
    lives_ok { %a<o> = 314 }, "should be able to update untyped hash element";
    is %a<o>, 314, "update of untyped hash element to 314 was successful";
    lives_ok { undefine %a<o> }, "undefine untyped hash element";
    is %a<o>, 42, "untyped hash element returned to its default with undefine";

    my %b is default(42) = o => 768;
    is %b<o>, 768, "untyped hash element should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is %b.VAR.default, 42, 'is the default set correctly for %b';
} #12

#?pugs   skip "Int is default NYI"
#?niecza skip "Int is default NYI"
# typed
{
    my Int %a is default(42);
    is %a<o>, 42, "uninitialized typed hash element should have its default";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is %a.VAR.default, 42, 'is the default set correctly for Int %a';
    lives_ok { %a<o>++ }, "should be able to update typed hash element";
    is %a<o>, 43, "update of hash array element to 43 was successful";
    lives_ok { %a<o> = Nil }, "assign Nil to hash array element";
    is %a<o>, 42, "typed hash element returned to its default with Nil";
    lives_ok { %a<o> = 314 }, "should be able to update typed hash element";
    is %a<o>, 314, "update of typed hash element to 314 was successful";
    lives_ok { undefine %a<o> }, "undefine typed hash element";
    is %a<o>, 42, "typed hash element returned to its default with undefine";

    my Int %b is default(42) = o => 768;
    is %b<o>, 768, "typed hash element should be initialized";
    #?rakudo.jvm skip "oh no, .VAR does not work on JVM"
    is %b.VAR.default, 42, 'is the default set correctly for Int %b';
} #12

# vim: ft=perl6
