use v6;
use Test;

plan 9;

role WithStub { method a() { ... } };
role ProvidesStub1 { method a() { 1 } };
role ProvidesStub2 { method a() { 2 } };

#?pugs todo
dies_ok  { EVAL 'class A does WithStub { }' },
        'need to implement stubbed methods at role-into-class composition time';
lives_ok { EVAL 'role B does WithStub { }' },
        'but roles are fine';
lives_ok { EVAL 'class C does WithStub { method a() { 3 } }' },
        'directly implementing the stubbed method is fine';
lives_ok { EVAL 'class D does WithStub does ProvidesStub1 { }' },
        'composing the stubbed method is fine';
#?pugs todo
dies_ok  { EVAL 'class E does WithStub does ProvidesStub1 does ProvidesStub2 { }' },
        'composing stub and 2 implementations dies again';
lives_ok { EVAL 'class F does WithStub does ProvidesStub1 does ProvidesStub2 {
    method a() { 4 } }' },
        'composing stub and 2 implementations allows custom implementation';

class ProvidesA { method a() { 5 } };
lives_ok { EVAL 'class ChildA is ProvidesA does WithStub { }' },
        'stubbed method can come from parent class too';

lives_ok { EVAL 'class RT115212 does WithStub { has $.a }' }, 'stubbed method can come from accessor';

class HasA { has $.a }
lives_ok { EVAL 'class RT115212Child is HasA does WithStub { }' }, 'stubbed method can come from accessor in parent class';
