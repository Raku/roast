use v6;
use Test;

# L<S06/"Parameter traits"/"=item is readonly">
# should be moved with other subroutine tests?

plan 9;

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
    dies_ok { $a := 17 }, "but binding it again does not work";
}

{
    my $a is readonly;
    ok !(try { VAR($a).defined }), ".VAR returns undefined on an uninitialized var declared with 'is readonly'";

    $a := 42;
    #?pugs todo 'feature'
    ok (try { VAR($a).defined }), ".VAR returns defined now";
}

{
    my $a = 3;

    #?pugs todo 'feature'
    ok (try { VAR($a).defined }), ".VAR on a plain normal initialized variable returns true";
}

# vim: ft=perl6
