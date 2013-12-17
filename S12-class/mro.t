use v6;
use Test;

plan 4;

{
    class A      {
        has $.tracker is rw = '';
        method x { $.tracker ~= 'A' }
    };
    class B is A      { method x { $.tracker ~= 'B'; nextsame } };
    class C is A      { method x { $.tracker ~= "C"; nextsame } };
    class D is B is C { method x { $.tracker ~= "D"; nextsame } }
    class E is C      { method x { $.tracker ~= "E"; nextsame } };
    class F is D is E { method x { $.tracker ~= "F"; nextsame } };
    my $x = F.new;
    $x.x;
    is $x.tracker, 'FDBECA', 'got the right MRO for 6 classes';
    # not really spec yet
    #?niecza skip '.^mro'
    is $x.^mro.gist, '(F) (D) (B) (E) (C) (A) (Any) (Mu)',
       '.^mro';
}

{
    # from http://192.220.96.201/dylan/linearization-oopsla96.html
    class grid { };
    class horizontal is grid { };
    class vertical   is grid { }
    class hv is horizontal is vertical   { }
    class vh is vertical   is horizontal { }
    eval_dies_ok 'class confused is vh is hv { }',
        'Cannot do multi inheritance that causes inconsistent MRO';
}

# RT #77274
eval_lives_ok q[
    class GrandParent { };
    class Parent is GrandParent { };
    class Me is Parent is GrandParent { };
    Me.new;
], 'a class can inherit both from its parent and then from its grand parent';
