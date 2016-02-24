use v6.c;

use Test;
plan 5;

# L<S12/Class methods/>

class C {method h {42}}
class B is C { method g { self.f } };
class A is B { method f {1; } };

class AA {method i {108}}
class D is A is AA {method f {2} }

is(A.g(), 1, 'inheritance works on class methods');
is(A.h(), 42, '>1 level deep inheritance works on class methods');
is(D.h(), 42, 'multiple inheritance works on class methods (1)');
is(D.i(), 108, 'multiple inheritance works on class methods (2)');
is(D.f(), 2, 'method from class is selected over inherited method');

# vim: ft=perl6
