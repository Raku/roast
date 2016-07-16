use v6.c;
# used in t/spec/S11-modules/nested.t 

module A::A {
    use A::B;
}

# vim: ft=perl6
