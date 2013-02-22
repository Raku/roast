use v6;
use Test;
plan 28;

# Test for proto definitions
class A { }
class B { }
proto foo($x) { * }    #OK not used
multi foo(A $x) { 2 }  #OK not used
multi foo(B $x) { 3 }  #OK not used
multi foo($x)   { 1 }  #OK not used
is(foo(A.new), 2, 'dispatch on class worked');
is(foo(B.new), 3, 'dispatch on class worked');
is(foo(42),    1, 'dispatch with no possible candidates fell back to proto');

#?rakudo skip 'todo'
#?niecza skip "Illegal redeclaration of routine 'bar'"
{
    # Test that proto makes all further subs in the scope also be multi.
    proto bar() { "proto" }
    sub bar($x) { 1 }    #OK not used
    multi bar($x, $y) { 2 }    #OK not used
    multi sub bar($x, $y, $z) { 3 }    #OK not used
    sub bar($x, $y, $z, $a) { 4 }    #OK not used
    is bar(),  "proto", "called the proto";
    is bar(1),       1, "sub defined without multi has become one";
    is bar(1,2),     2, "multi ... still works, though";
    is bar(1,2,3),   3, "multi sub ... still works too";
    is bar(1,2,3,4), 4, "called another sub as a multi candidate, made a multi by proto";
}

# L<S03/"Reduction operators">
#?rakudo skip 'operator protos'
{
    proto prefix:<[+]> (*@args) {
        my $accum = 0;
        $accum += $_ for @args;
        return $accum * 2; # * 2 is intentional here
    }

    #?niecza todo
    is ([+] 1,2,3), 12, "[+] overloaded by proto definition";
}

# more similar tests
{
    proto prefix:<moose> ($arg) { $arg + 1 }
    is (moose 3), 4, "proto definition of prefix:<moose> works";
}

#?niecza skip '>>>Stub code executed'
{
    proto prefix:<elk> ($arg) { * }
    multi prefix:<elk> ($arg) { $arg + 1 }
    is (elk 3), 4, "multi definition of prefix:<elk> works";
}

eval_dies_ok 'proto rt68242($a){};proto rt68242($c,$d){};',
    'attempt to define two proto subs with the same name dies';

# RT #65322
{
    my $rt65322 = q[
        multi sub rt65322( Int $n where 1 ) { 1 }
              sub rt65322( Int $n ) { 2 }
    ];
    eval_dies_ok $rt65322, "Can't define sub and multi sub without proto";
}

{
    eval_dies_ok q[
        multi sub i1(Int $x) {}
        sub i1(Int $x, Str $y) {} 
    ], 'declaring a multi and a single routine dies';

    eval_dies_ok q[
        sub i2(Int $x, Str $y) {1}
        sub i2(Int $x, Str $y) {2}
    ], 'declaring two only-subs with same name dies';



}

# RT #68242
{
    eval_dies_ok 'proto foo($bar) {}; proto foo($baz, $quux) {}';
}

# RT #111454
#?niecza skip "System.NullReferenceException: Object reference not set to an instance of an object"
{
    my package Cont {
        our proto sub ainer($) {*}
        multi sub ainer($a) { 2 * $a };
    }
    is Cont::ainer(21), 42, 'our proto can be accessed from the ouside';
}

#?niecza skip 'Unhandled exception: Cannot use value like Block as a number'
{
    my proto f($) {
        2 * {*} + 5
    }
    multi f(Str) { 1 }
    multi f(Int) { 3 }

    is f('a'), 7, 'can use {*} in an expression in a proto (1)';
    is f(1),  11, 'can use {*} in an expression in a proto (2)';

    # RT #114882
    my $called_with = '';
    proto cached($a) {
        state %cache;
        %cache{$a} //= {*}
    }
    multi cached($a) {
        $called_with ~= $a;
        $a x 2;
    }
    is cached('a'), 'aa', 'caching proto (1)';
    is cached('b'), 'bb', 'caching proto (2)';
    is cached('a'), 'aa', 'caching proto (3)';
    is $called_with, 'ab', 'cached value did not cause extra call';

    proto maybe($a) {
        $a > 0 ?? {*} !! 0;
    }
    multi maybe($a) { $a };

    is maybe(8),  8, 'sanity';
    is maybe(-5), 0, "It's ok not to dispatch to the multis";
}

#RT #76298
{
    eval_lives_ok q{
        class TestA { has $.b; proto method b {} };
    }, 'proto method after same-named attribute';
    eval_lives_ok q{
        class TestB { proto method b {}; has $.b };
    }, 'proto method before same-named attribute';
}

# RT #116164
#?niecza todo
{
    eval_dies_ok q[
        proto f(Int $x) {*}; multi f($) { 'default' }; f 'foo'
    ], 'proto signature is checked, not just that of the candidates';
}
done;

# vim: ft=perl6
