use v6;

use Test;
plan 1;

# L<S12/Class methods/>

class A is B { method f {1; } };
class B { method g { self.f } };

is(A.g(), 1, 'inheritance works on class methods');

