use v6;
use Test;

plan 7;

role WithStub { method a() { ... } };
role ProvidesStub1 { method a() { 1 } };
role ProvidesStub2 { method a() { 2 } };

dies_ok  { eval 'class A does WithStub { }' },
        'need to implement stubbed methods at role-into-class composition time';
lives_ok { eval 'role B does WithStub { }' },
        'but roles are fine';
lives_ok { eval 'class C does WithStub { method a() { 3 } }' },
        'directly implementing the stubbed method is fine';
lives_ok { eval 'class D does WithStub does ProvidesStub1 { }' },
        'composing the stubbed method is fine';
dies_ok  { eval 'class E does WithStub does ProvidesStub1 does ProvidesStub2 { }' },
        'composing stub and 2 implementations dies again';
lives_ok { eval 'class F does WithStub does ProvidesStub1 does ProvidesStub2 {
    method a() { 4 } }' },
        'composing stub and 2 implementations allows custom implementation';

class ProvidesA { method a() { 5 } };
lives_ok { eval 'class ChildA is ProvidesA does WithStub { }' },
        'stubbed method can come from parent class too';
