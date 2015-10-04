use v6;
use Test;

plan 32;

# L<S13/"Type Casting"/"method postcircumfix:<{ }> (**@slice) {...}">
# basic tests to see if the methods overload correctly.

#?niecza skip 'No value for parameter $capture in TypeCastSub.postcircumfix:<( )>'
{
    my multi testsub ($a,$b) {   #OK not used
        return 1;
    }
    my multi testsub ($a) {   #OK not used
        return 2;
    }
    my multi testsub () {
        return 3;
    }
    class TypeCastSub {
        method CALL-ME (|c) {return 'pretending to be a sub ' ~ testsub(|c) }
    }

    my $thing = TypeCastSub.new;
    is($thing(), 'pretending to be a sub 3', 'overloaded () call works');
    is($thing.(), 'pretending to be a sub 3', 'overloaded .() call works');
    is($thing.(1), 'pretending to be a sub 2', 'overloaded .($) call works');
    is($thing.(1,2), 'pretending to be a sub 1', 'overloaded .($,$) call works');

    class TypeCastSub2 {
        method postcircumfix:<( )> (|c) {return 'pretending to be a sub ' ~ testsub(|c) }
    }

    my $thing2 = TypeCastSub2.new;
    is($thing2(), 'pretending to be a sub 3', 'overloaded () call works (postcircumfix:)');
    is($thing2.(), 'pretending to be a sub 3', 'overloaded .() call works (postcircumfix:)');
    is($thing2.(1), 'pretending to be a sub 2', 'overloaded .($) call works (postcircumfix:)');
    is($thing2.(1,2), 'pretending to be a sub 1', 'overloaded .($,$) call works (postcircumfix:)');

    class TypeCastSub3 {
        multi method postcircumfix:<( )> () {return 'pretending to be a sub 3' }
        multi method postcircumfix:<( )> ($a) {return "pretending to be a sub $a" }
        multi method postcircumfix:<( )> ($a, $b) {return "pretending to be a sub $a $b" }
    }

    my $thing3 = TypeCastSub3.new;
    is($thing3(), 'pretending to be a sub 3', 'overloaded () call works (multi postcircumfix:)');
    is($thing3.(), 'pretending to be a sub 3', 'overloaded .() call works (multi postcircumfix:)');
    is($thing3.(2), 'pretending to be a sub 2', 'overloaded .($) call works (multi postcircumfix:)');
    is($thing3.(3,4), 'pretending to be a sub 3 4', 'overloaded .($,$) call works (multi postcircumfix:)');

    class TypeCastSub4 {
        method postcircumfix:<( )> () {return "pretending to be a sub" }
    }

    my $thing4 = TypeCastSub4.new;
    is($thing4(), 'pretending to be a sub', 'overloaded () call works (only postcircumfix:)');
    is($thing4.(), 'pretending to be a sub', 'overloaded .() call works (only postcircumfix:)');

    class TypeCastSub5 {
        method postcircumfix:<( )> ($a) {return "pretending to be a sub $a" }
    }

    my $thing5 = TypeCastSub5.new;
    is($thing5(42), 'pretending to be a sub 42', 'overloaded ($) call works (only postcircumfix:)');
    is($thing5.(42), 'pretending to be a sub 42', 'overloaded .($) call works (only postcircumfix:)');

    class TypeCastSub6 {
        method postcircumfix:<( )> ($a,$b) {return "pretending to be a sub $a $b" }
    }

    my $thing6 = TypeCastSub6.new;
    is($thing6(42,43), 'pretending to be a sub 42 43', 'overloaded ($,$) call works (only postcircumfix:)');
    is($thing6.(42,43), 'pretending to be a sub 42 43', 'overloaded .($,$) call works (only postcircumfix:)');

}

# RT #114026
{
    my $*res = 0;
    sub somesub () { $*res = 42; };
    class Foo {
        has @.a is rw;
        method add(&c){ @.a.push(&c) }
        method postcircumfix:<( )>($self: |c) {
            @.a>>.(|c)
        } 
    }
    my $foo = Foo.new;
    $foo.add(&somesub);
    $foo();
    is $*res, 42, 'example code from RT #114026 works';
}

# RT #112642
{
    class A { method postcircumfix:<( )> (A:U:) { 3 } };
#?rakudo todo 'RT #112642 A() unwanted magic for :(A:U) with an overloaded .()'
    is A(), 3, 'RT #112642 () -> (:U) works';
    is A.(), 3, 'RT #112642 .() -> (:U) works, dotted form';
    is A(:a), 3, 'RT #112642 (:a) -> (:U) works';
    is A.(:a), 3, 'RT #112642 .(:a) -> (:U) works, dotted form';

    class B { method postcircumfix:<( )>(B:U: $x) { 3 } };
    is B(0), 3, 'RT #112642 ($: $) -> (:U, $) case';
    is B.(0), 3, 'RT #112642 .($: $) -> (:U, $) case, dotted form';
    ## TODO test for specific exception once the code dies
#?rakudo todo 'RT #112642 A() unwanted magic for :(A:U) with an overloaded .()'
    throws-like 'class XXX { method postcircumfix:<( )>(XXX:U: $x) { } }; XXX();', Exception, 'RT #112642 ($:) -> (:U, $) arity check';
    throws-like 'class XYX { method postcircumfix:<( )>(XYX:U: $x) { } }; XYX(:a);', X::AdHoc, 'RT #112642 ($:, :$) -> (:U, $) arity check';
    throws-like 'class XYY { method postcircumfix:<( )>(XYY:U: $x) { } }; XYY.();', X::AdHoc, 'RT #112642 .($:) -> (:U, $) arity check';
    throws-like 'class YYY { method postcircumfix:<( )>(YYY:U: $x) { } }; YYY.(:a);', X::AdHoc, 'RT #112642 .($:, :$) -> (:U, $) arity check';
    throws-like 'class XYZ { method postcircumfix:<( )>(XYZ:U: $x) { } }; XYZ(3,4,5);', X::AdHoc, 'RT #112642 ($: $, $, $) -> (:U, $) arity check';
    throws-like 'class XZZ { method postcircumfix:<( )>(XZZ:U: $x) { } }; XZZ.(3,4,5);', X::AdHoc, 'RT #112642 .($: $, $, $) -> (:U, $) arity check';
}

# RT #115850
{
    class Bar {
        has $.str;
        method postcircumfix:<( )>($i, $k) { $.str.substr: $i, $k }
    }
    my Bar $x .= new: :str("abcde");
    is $x(2, 1), 'c', 'example from RT #115850 works';
}

# vim: ft=perl6
