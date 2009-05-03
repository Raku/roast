use v6;

use Test;

plan 9;

# L<S12/"Calling sets of methods"/"Any method can defer to the next candidate method in the list">

class Foo {
    # $.tracker is used to determine the order of calls.
    has $.tracker;
    method doit()  {$.tracker ~= 'foo,'}
    method doit(Int $num) {$.tracker ~= 'fooint,'}
    method show  {$.tracker}
    method clear {$.tracker = ''}
}

class BarNextSame is Foo {
    method doit() {$.tracker ~= 'bar,'; nextsame; $.tracker ~= 'ret1,'}
    method doit(Int $num) {$.tracker ~= 'barint,'; nextsame; $.tracker ~= 'ret2,'}
}

{
    my $o = BarNextSame.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextsame inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,bar,fooint,', 'nextsame multimethod/inheritance test');
}

class BarNextWithEmpty is Foo {
    method doit() {$.tracker ~= 'bar,'; nextwith(); $.tracker ~= 'ret1,'}
    method doit(Int $num) {$.tracker ~= 'barint,'; nextwith(); $.tracker ~= 'ret2,'}
}

{
    my $o = BarNextWithEmpty.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,foo,', 'nextwith() inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,bar,foo,', 'nextwith() multimethod/inheritance test');
}

class BarNextWithInt is Foo {
    method doit() {$.tracker ~= 'bar,'; nextwith(42); $.tracker ~= 'ret1,'}
    method doit(Int $num) {$.tracker ~= 'barint,'; nextwith(42); $.tracker ~= 'ret2,'}
}

{
    my $o = BarNextWithInt.new;
    $o.clear;
    $o.doit;
    is($o.show, 'bar,fooint,', 'nextwith(42) inheritance test');
    $o.clear;
    is($o.show, '', 'sanity test for clearing');
    $o.doit(5);
    is($o.show, 'barint,fooint,', 'nextwith(42) multimethod/inheritance test');
}
