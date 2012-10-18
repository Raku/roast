use v6;
use Test;

plan 6;

{
    my constant name = 'TestName';
    class ::(name) {
        method f() { 42 }
    }
    is TestName.f, 42, 
       'can declare and use a class with indirect (but constant) name';
    is ::(name).^name, 'TestName',
        'and it reports the right name';
}

{
    my constant name = 'a';
    sub ::(name) ($x) { $x + 38 }
    is a(4), 42, 'indirect sub name works';
    is &a.name, 'a', 'and the sub knows its name';
}

{
    class A {
        method ::('indirect') {
            42
        }
        method ::('with space') {
            23
        }
    }
    is A.indirect,       42, 'can declare method with indirect name';
    is A."with space"(), 23, 'can declare indirect method name with space';
}
