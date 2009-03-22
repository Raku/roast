# used in t/spec/S11-modules/nested.t 

module A::B;
role B { };
class D does A::B::B { };



