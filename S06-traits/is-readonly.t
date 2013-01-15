use v6;
use Test;

plan 14;

# L<S06/"Parameter traits"/"=item is readonly">
# should be moved with other subroutine tests?


{
    my $a is readonly := 42;
    is $a, 42, "basic declaration of a 'is readonly' variable works";

    dies_ok { $a = 23 }, "a var declared with 'is readonly' is readonly (1)";
    is $a, 42,           "a var declared with 'is readonly' is readonly (2)";
}

{
    my $a is readonly;
    ok !$a, "declaration of an 'is readonly' var without supplying a container to bind to works";
    try { $a := 42 };
    is $a, 42, "binding the variable now works";

    #?pugs todo 'feature'
    #?rakudo todo 'todo'
    dies_ok { $a := 17 }, "but binding it again does not work";
}

#?rakudo skip 'segfault'
{
    my $a is readonly;
    ok !(try { VAR($a).defined }), ".VAR returns undefined on an uninitialized var declared with 'is readonly'";

    $a := 42;
    ok (try { VAR($a).defined }), ".VAR returns defined now";
}

#?rakudo skip 'VAR'
{
    my $a = 3;

    ok (try { VAR($a).defined }), ".VAR on a plain normal initialized variable returns true";
}

# RT #65900
{
    my ($rt65900 is readonly) = 5;
    is $rt65900, 5, 'my ($x is readonly) can take assignment';
    #?rakudo 2 todo 'todo'
    #?pugs 2 todo
    dies_ok { $rt65900 = 'ro' }, 'dies on assignment to readonly variable';

    dies_ok { (my $rt65900 is readonly) = 5 },
        'dies on assignment to (my $x is readonly)';
}

# RT #71356
{
    class C {
        has $!attr is readonly = 71356;
        method get-attr() { $!attr }
        method set-attr($val) { $!attr = $val }
    }
    is C.new.get-attr, 71356, 'can read from readonly private attributes';
    #?rakudo todo 'readonly attributes'
    #?pugs todo
    dies_ok { my $c = C.new; $c.set-attr: 99; }, 'cannot assign to readonly private attribute'
}

# vim: ft=perl6
