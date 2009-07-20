use v6;
use Test;

plan 12;

# L<S02/Built-In Data Types/"The * character as a standalone term captures the notion of">
# L<S02/Native types/"If any native type is explicitly initialized to">

{
    my $x = *;
    ok($x.isa(Whatever), 'can assign * to a variable and isa works');
}

# L<S02/Built-In Data Types/"Most of the built-in numeric operators treat an argument of">

my $x = *-1;
lives_ok { $x.WHAT }, '(*-1).WHAT lives';
isa_ok $x, Code, '*-1 is of type Code';
is $x.(5), 4, 'and we can execute that Code';

isa_ok *.abs, Code, '*.abs is of type Code';
my @a = map *.abs, 1, -2, 3, -4;
is @a, [1,2,3,4], '*.meth created closure works';

{
    # check that it also works with Enums - used to be a Rakudo bug
    # RT #63880
    enum A <b c>;
    isa_ok (b < *), Code, 'Enums and Whatever star interact OK';
}

# check that more complex expressions work:

#?rakudo skip '* to code translation for multi-step expressions'
{
    my $code = *.uc eq 'FOO';
    ok $code ~~ Callable, '"*.uc eq $str" produces a Callable object';
    ok $code("foo"), 'and it works (+)';
    ok !$code("bar"), 'and it works (-)';
}

# RT #64566
#?rakudo todo 'RT #64566'
{
    my @a = 1 .. 4;
    is @a[1..*], 2..4, '@a[1..*] skips first element, stops at last';
    is @a, 1..4, 'array is unmodified after reference to [1..*]';
}

# vim: ft=perl6
