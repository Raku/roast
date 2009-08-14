use v6;

use Test;

plan 16;

# L<S12/"Multisubs and Multimethods">
# L<S12/"Multi dispatch">

class Foo {
    multi method bar() {
        return "Foo.bar() called with no args";
    }

    multi method bar(Str $str) {
        return "Foo.bar() called with Str : $str";
    }

    multi method bar(Int $int) {
        return "Foo.bar() called with Int : $int";
    }
    
    multi method bar(Num $num) {
        return "Foo.bar() called with Num : $num";
    }
    
    multi method baz($f) {
        return "Foo.baz() called with parm : $f";
    }
}


my $foo = Foo.new();
is($foo.bar(), 'Foo.bar() called with no args', '... multi-method dispatched on no args');

is($foo.bar("Hello"), 'Foo.bar() called with Str : Hello', '... multi-method dispatched on Str');

is($foo.bar(5), 'Foo.bar() called with Int : 5', '... multi-method dispatched on Int');
my $num = '4';
is($foo.bar(+$num), 'Foo.bar() called with Num : 4', '... multi-method dispatched on Num');

#?rakudo todo 'RT #66006'
eval '$foo.baz()';
ok ~$! ~~ /:i argument[s?]/, 'Call with wrong number of args should complain about args';

role R1 {
    method foo($x) { 1 }
}
role R2 {
    method foo($x, $y) { 2 }
}
eval_dies_ok 'class X does R1 does R2 { }', 'sanity: get composition conflict error';
class C does R1 does R2 {
    proto method foo() { "proto" }
}
my $obj = C.new;
is($obj.foo(),  'proto', 'proto caused methods from roles to be composed without conflict');
is($obj.foo('a'),     1, 'method composed into multi from role called');
is($obj.foo('a','b'), 2, 'method composed into multi from role called');


class Foo2 {
    multi method a($d) {
        "Any-method in Foo";
    }
}
class Bar is Foo2 {
    multi method a(Int $d) {
        "Int-method in Bar";
    }
}

is Bar.new.a("not an Int"), 'Any-method in Foo';

# RT #67024
#?rakudo todo 'redefintion of non-multi method (RT #67024)'
{
    eval 'class A { method a(){0}; method a($x){1} }';
    ok  $!  ~~ Exception, 'redefintion of non-multi method (RT 67024)';
    ok "$!" ~~ /multi/, 'error message mentions multi-ness';
}

{
    role R3 {
        has @.order;
        multi method b() { @.order.push( 'role' ) }
    }
    class C3 does R3 {
        multi method b() { @.order.push( 'class' ); nextsame }
    }

    my $c = C3.new;
    lives_ok { $c.b }, 'can call multi-method from class with role';

    is $c.order, <class role>, 'call order is correct for class and role'
}

{
    role R4 {
        has @.order;
        multi method b() { @.order.push( 'role'   ); nextsame }
    }
    class P4 {
        method b() {       @.order.push( 'parent' ) }
    }
    class C4 is P4 does R4 {
        multi method b() { @.order.push( 'class'  ); nextsame }
    }
    my $c = C4.new;
    lives_ok { $c.b }, 'call multi-method from class with parent and role';

    is $c.order, <class role parent>,
       'call order is correct for class, role, parent'
}

# vim: ft=perl6
