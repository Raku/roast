use v6;
use Test;

plan 22;

#?pugs   skip "is dynamic NYI"
#?niecza skip "is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# not specifically typed
{
    my $a is dynamic;
    ok $a.VAR.dynamic, 'dynamic set correctly for uninitialized $a';
    $a = 42;
    ok $a.VAR.dynamic, 'dynamic set correctly for initialized $a';
    $a = Nil;
    ok $a.VAR.dynamic, 'dynamic set correctly for reset $a';
} #3

#?pugs   skip "Int is dynamic NYI"
#?niecza skip "Int is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# typed
{
    my Int $a is dynamic;
    ok $a.VAR.dynamic, 'dynamic set correctly for uninitialized Int $a';
    $a = 42;
    ok $a.VAR.dynamic, 'dynamic set correctly for initialized Int $a';
    $a = Nil;
    ok $a.VAR.dynamic, 'dynamic set correctly for reset Int $a';
} #3

#?pugs   skip "is dynamic NYI"
#?niecza skip "is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# not specifically typed
{
    my @a is dynamic;
    ok @a.VAR.dynamic,    'dynamic set correctly for @a';
    ok @a[0].VAR.dynamic, 'dynamic set correctly for non-existing @a[0]';
    @a[0] = 42;
    ok @a[0].VAR.dynamic, 'dynamic set correctly for existing @a[0]';
    @a[0] = Nil;
    ok @a[0].VAR.dynamic, 'dynamic set correctly for reset @a[0]';
} #4

#?pugs   skip "Int is dynamic NYI"
#?niecza skip "Int is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# typed
{
    my Int @a is dynamic(42);
    ok @a.VAR.dynamic,    'dynamic set correctly for Int @a';
    ok @a[0].VAR.dynamic, 'dynamic set correctly for non-existing Int @a[0]';
    @a[0] = 42;
    ok @a[0].VAR.dynamic, 'dynamic set correctly for existing Int @a[0]';
    @a[0] = Nil;
    ok @a[0].VAR.dynamic, 'dynamic set correctly for reset Int @a[0]';
} #4

#?pugs   skip "is dynamic NYI"
#?niecza skip "is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# not specifically typed
{
    my %a is dynamic;
    ok %a.VAR.dynamic,    'dynamic set correctly for %a';
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for non-existing %a<a>';
    %a<a> = 42;
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for existing %a<a>';
    %a<a> = Nil;
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for reset %a<a>';
} #4

#?pugs   skip "Int is dynamic NYI"
#?niecza skip "Int is dynamic NYI"
#?rakudo.jvm skip "oh no, .VAR does not work on JVM"
# typed
{
    my Int %a is dynamic(42);
    ok %a.VAR.dynamic,    'dynamic set correctly for Int %a';
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for non-existing Int %a<a>';
    %a<a> = 42;
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for existing Int %a<a>';
    %a<a> = Nil;
    ok %a<a>.VAR.dynamic, 'dynamic set correctly for reset Int %a<a>';
} #4

# vim: ft=perl6
