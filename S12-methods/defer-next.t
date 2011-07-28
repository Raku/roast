use v6;

use Test;

plan 15;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

# Simple test, making sure nextwith passes on parameters properly.
class A {
    method a(*@A) {
        (self.perl, @A)
    }
}
class B is A {
    method a() {
        nextwith("FIRST ARG", "SECOND ARG")
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

class BarNextSame is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextsame; $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextsame; $.tracker ~= 'ret2,'}   #OK not used
}

{
    my $o = BarNextSame.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextsame inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextsame multimethod/inheritance test');
}

class BarNextWithEmpty is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith($num); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarNextWithEmpty.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextwith() inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextwith() multimethod/inheritance test');
}

class BarNextWithInt is Foo {
    multi method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    multi method doit(Int $num) {$.tracker ~= 'barint,'; nextwith(42); $.tracker ~= 'ret2,'}   #OK not used
}
{
    my $o = BarNextWithInt.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextwith(42) inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextwith(42) multimethod/inheritance test');
}

{
    my $called = 0;
    class DeferWithoutCandidate {
        multi method a($x) {   #OK not used
            $called = 1;
            nextwith();
        }
    }
    #?rakudo todo 'variant of RT 69608'
    dies_ok { DeferWithoutCandidate.new.a(1) },
        'Dies when nextwith() does not find a candidate to dispatch to';
    is $called, 1, 'but was in the correct method before death';
}

# vim: ft=perl6
