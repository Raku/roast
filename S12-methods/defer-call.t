use v6;

use Test;

plan 14;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

# Simple test, making sure callwith passes on parameters properly.
class A {
    method a(*@A) {
        (self.perl, @A)
    }
}
class B is A {
    method a() {
        callwith("FIRST ARG", "SECOND ARG")
    }
}
{
    my $instance = B.new;
    my @result = $instance.a();
    is @result.elems, 3, 'nextwith passed on right number of parameters';
    is @result[0], $instance.perl, 'invocant passed on correctly';
    is @result[1], "FIRST ARG", 'first argument correct';
    is @result[2], "SECOND ARG", 'second argument correct';
}

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker is rw;
    multi method doit()  {$.tracker ~= 'foo,'}
    multi method doit(Int $num) {$.tracker ~= 'fooint,'}   #OK not used
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BarCallSame is Foo {
    multi method doit() {$.tracker ~= 'bar,'; callsame; $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $o = BarCallSame.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,ret1,', 'callsame inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,ret2,', 'callsame multimethod/inheritance test');
}


class BarCallWithEmpty is Foo {
    multi method doit() {$.tracker ~= 'bar,'; callwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callwith($num); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarCallWithEmpty.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,ret1,', 'callwith() inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    {
        $o.doit(5);
        is($o.show, 'barint,fooint,ret2,', 'callwith() multimethod/inheritance test');
    }
}

class BarCallWithInt is Foo {
    multi method doit() {$.tracker ~= 'bar,'; callwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; callwith(42); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarCallWithInt.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,ret1,', 'callwith(42) inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,ret2,', 'callwith(42) multimethod/inheritance test');
}

# RT #69756
{
    multi sub f(0) { };
    multi sub f($n) {
        callwith($n - 1);
    }
    lives_ok { f(3) }, 'can recurse several levels with callwith()';
}

# vim: ft=perl6
