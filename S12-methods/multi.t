use v6;

use Test;

plan 8;

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
}


my $foo = Foo.new();
is($foo.bar(), 'Foo.bar() called with no args', '... multi-method dispatched on no args');

is($foo.bar("Hello"), 'Foo.bar() called with Str : Hello', '... multi-method dispatched on Str');

is($foo.bar(5), 'Foo.bar() called with Int : 5', '... multi-method dispatched on Int');
my $num = '4';
is($foo.bar(+$num), 'Foo.bar() called with Num : 4', '... multi-method dispatched on Num');

role R1 {
    method foo($x) { 1 }
}
role R2 {
    method foo($x, $y) { 2 }
}
dies_ok 'class X does R1 does R2 { }', 'sanity: get composition conflict error';
class C does R1 does R2 {
    proto method foo() { "proto" }
}
my $obj = C.new;
is($obj.foo(),  'proto', 'proto caused methods from roles to be composed without conflict');
is($obj.foo('a'),     1, 'method composed into multi from role called');
is($obj.foo('a','b'), 2, 'method composed into multi from role called');

