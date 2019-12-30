use v6;
unit module LongNames;

class Foo::C1 is export { }
class Foo::C2 is export { }
class Bar::C1 is export { }
class Bar::C2 is export { }

enum Foo::Vals is export <FooVal1 FooVal2>;
enum Bar::Vals is export <BarVal1 BarVal2>;

subset Foo::MyInt of Int is export where * > 10;
subset Bar::MyInt of Int is export where * > 10;
