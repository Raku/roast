use v6.c;
# used in t/spec/S11-modules/nested.t 

unit module A::B;
role B { };
class D does A::B::B { };



