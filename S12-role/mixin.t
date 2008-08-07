use v6;
use Test;
plan 13;

role R1 { method test { 42 } }
class C1 { }

my $x = C1.new();
$x does R1;
is $x.test,     42,         'method from a role can be mixed in';


role R2 { method test { 42 } }
class C2 { has $.x }
my $y = C2.new(x => 100);
is $y.x,        100,        'initialization sanity check';
$y does R2;
is $y.test,     42,         'method from role was mixed in';
is $y.x,        100,        'mixing in did not destroy old value';


role R3 { has $.answer is rw }
class C3 { has $.x }
$y = C3.new(x => 100);
$y does R3;
$y.answer = 42;
is $y.x,        100,        'mixing in with attributes did not destroy existing ones';
is $y.answer,   42,         'mixed in new attributes';


$y = C3.new(x => 100);
$y does (R2, R3);
$y.answer = 13;
is $y.x,        100,        'multi-role mixin preserved existing values';
is $y.answer,   13,         'attribute from multi-role mixing OK';
is $y.test,     42,         'method from other role was OK too';


role Answer { has $.answer is rw }
$x = 0;
$x does Answer(42);
is $x.answer,   42,         'role mix-in with initialization value worked';
is $x,          0,          'mixing into Int still makes it function as an Int';

role A { has $.a is rw }
role B { has $.b is rw }
$x does A(1);
$x does B(2);
is $x.a,        1,          'mixining in two roles one after the other';
is $x.b,        2,          'mixining in two roles one after the other';


# vim: syn=perl6
