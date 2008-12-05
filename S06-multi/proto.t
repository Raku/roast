use v6;
use Test;
plan 7;

# Test for proto definitions

class A { }
class B { }
class C is A is B { }
proto foo() { 1 }
multi foo(A $x) { 2 }
multi foo(B $x) { 3 }
is(foo(A.new), 2, 'dispatch on class worked');
is(foo(B.new), 3, 'dispatch on class worked');
is(foo(C.new), 1, 'ambiguous dispatch fell back to proto');
is(foo(42),    1, 'dispatch with no possible candidates fell back to proto');

# L<S03/"Reduction operators">
#?rakudo skip 1
{
    proto prefix:<[+]> (*@args) {
        my $accum = 0;
        $accum += $_ for @args;
        return $accum * 2; # * 2 is intentional here
    }

    is ([+] 1,2,3), 12, "[+] overloaded by proto definition";
}

# more similar tests
#?rakudo skip 2
{
    proto prefix:<moose> ($arg) { $arg + 1 }
    is (moose 3), 4, "proto definition of prefix:<moose> works";

    proto prefix:<elk> ($arg) {...}
    multi prefix:<elk> ($arg) { $arg + 1 }
    is (elk 3), 4, "multi definition of prefix:<elk> works";
}
