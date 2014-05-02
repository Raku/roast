# used in t/spec/S11-modules/nested.t 

use lib 't/spec/packages';

module A::A {
    use A::B;
}

# vim: ft=perl6
