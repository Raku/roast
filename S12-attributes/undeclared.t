use v6;

use Test;

=begin pod

    access or assign on undeclared attribute will raise an error.

=end pod

plan 11;


dies_ok { class A { method set_a { $.a = 1 }}; A.new.set_a; },
    "Test Undeclared public attribute assignment from a class";
dies_ok { role B { method set_b { $.b = 1 }};class C does B { }; C.new.set_b; },
    "Test Undeclared public attribute assignment from a role";

eval_dies_ok ' class D { method d { $!d = 1 }}; D.new.d; ',
    "Test Undeclared private attribute assignment from a class";
eval_dies_ok ' role E { method e { $!e = 1 }};class F does E { }; F.new.e; ',
    "Test Undeclared private attribute assignment from a role";

##### access the undeclared attribute
dies_ok { class H { method set_h { $.h }}; H.new.set_h; },
    "Test Undeclared public attribute access from a class";
dies_ok { role I { method set_i { $.i }};class J does I { }; J.new.set_i; },
    "Test Undeclared public attribute access from a role";

eval_dies_ok ' class K { method k { $!k }}; K.new.k; ',
    "Test Undeclared private attribute access from a class";
eval_dies_ok ' role L { method l { $!l }};class M does L { }; M.new.l; ',
    "Test Undeclared private attribute access from a role";

## skip class 'Q' here to avoid quote operator conflict.

eval_dies_ok ' role R { method r { $!r := 1 }};class S does R { }; S.new.r; ',
    "Test Undeclared private attribute binding from a role";
eval_dies_ok ' class T { method t { $!t := 1 }}; ::T.new.t; ',
    "Test Undeclared private attribute binding from a class";

# RT #102478
{
    throws_like { EVAL q[has $.x] },
        X::Attribute::NoPackage,
        message => q[You cannot declare attribute '$.x' here; maybe you'd like a class or a role?];
}

# vim: ft=perl6
