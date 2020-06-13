use v6;
use Test;

plan 28;

# not specifically typed
{
    my $a is dynamic;
    ok $a.VAR.dynamic, 'dynamic set correctly for uninitialized $a';
    $a = 42;
    ok $a.VAR.dynamic, 'dynamic set correctly for initialized $a';
    $a = Nil;
    ok $a.VAR.dynamic, 'dynamic set correctly for reset $a';
} #3

# typed
{
    my Int $a is dynamic;
    ok $a.VAR.dynamic, 'dynamic set correctly for uninitialized Int $a';
    $a = 42;
    ok $a.VAR.dynamic, 'dynamic set correctly for initialized Int $a';
    $a = Nil;
    ok $a.VAR.dynamic, 'dynamic set correctly for reset Int $a';
} #3

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

# R#2276
{
    sub visible($type) {
        is $*a, 42, "is \$*a$type visible";
        $*a = 666 if $type;
    }
    sub a($*a) {
        visible('')
    }
    sub b($*a is copy) {
        visible(' is copy');
        is $*a, 666, 'did the assignment work with is copy';
    }
    sub c($*a is rw) {
        visible(' is rw');
        is $*a, 666, 'did the assignment work with is rw';
    }

    a(42);
    b(42);
    c(my $c = 42);
    is $c, 666, 'did the assignment work pass through with is rw';
}

# vim: expandtab shiftwidth=4
