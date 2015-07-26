use v6;
use Test;

plan 11;

role WithStub { method a() { ... } };
role ProvidesStub1 { method a() { 1 } };
role ProvidesStub2 { method a() { 2 } };

dies-ok  { EVAL 'class A does WithStub { }' },
        'need to implement stubbed methods at role-into-class composition time';
lives-ok { EVAL 'role B does WithStub { }' },
        'but roles are fine';
lives-ok { EVAL 'class C does WithStub { method a() { 3 } }' },
        'directly implementing the stubbed method is fine';
lives-ok { EVAL 'class D does WithStub does ProvidesStub1 { }' },
        'composing the stubbed method is fine';
dies-ok  { EVAL 'class E does WithStub does ProvidesStub1 does ProvidesStub2 { }' },
        'composing stub and 2 implementations dies again';
lives-ok { EVAL 'class F does WithStub does ProvidesStub1 does ProvidesStub2 {
    method a() { 4 } }' },
        'composing stub and 2 implementations allows custom implementation';

class ProvidesA { method a() { 5 } };
lives-ok { EVAL 'class ChildA is ProvidesA does WithStub { }' },
        'stubbed method can come from parent class too';

lives-ok { EVAL 'class RT115212 does WithStub { has $.a }' }, 'stubbed method can come from accessor';

class HasA { has $.a }
lives-ok { EVAL 'class RT115212Child is HasA does WithStub { }' }, 'stubbed method can come from accessor in parent class';

# RT #119643
throws-like { EVAL 'my role F119643 { ... }; class C119643 does F119643 {}' },
    X::Role::Parametric::NoSuchCandidate;

# RT #125606
{
    my role WithPrivate { method !foo { "p" } };
    my role WithPrivateStub { method !foo { ... } };
    my class ClassPrivate does WithPrivate does WithPrivateStub { method bar {self!foo } };

    is ClassPrivate.new.bar(), 'p', 'RT #125606: Stub resolution works for private methods too';
}
