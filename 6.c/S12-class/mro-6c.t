use v6.c;
use Test;

plan 5;

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
    is $x.^mro.gist, '((F) (D) (B) (E) (C) (A) (Any) (Mu))',
       '.^mro';
}

{
    # from http://192.220.96.201/dylan/linearization-oopsla96.html
    class grid { };
    class horizontal is grid { };
    class vertical   is grid { }
    class hv is horizontal is vertical   { }
    class vh is vertical   is horizontal { }
    throws-like 'class confused is vh is hv { }', Exception,
        'Cannot do multi inheritance that causes inconsistent MRO';
}

# https://github.com/Raku/old-issue-tracker/issues/2077
eval-lives-ok q[
    class GrandParent { };
    class Parent is GrandParent { };
    class Me is Parent is GrandParent { };
    Me.new;
], 'a class can inherit both from its parent and then from its grand parent';

subtest "Hidden classes", {
    plan 5;
    {
        my class C1 { }
        my class C2 is C1 is hidden { }
        my class C3 is C2 { }

        # Exclude Any, Mu from the end of the list
        is-deeply C3.^mro_unhidden[0..*-3], (C3, C1), "'is hidden' on a class excludes it from mro_unhidden return";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my class C3 hides C2 { }
        my class C4 is C3 { }

        is-deeply C4.^mro_unhidden[0..*-3], (C4, C3, C1), "'hides' on a class excludes it from mro_unhidden return"
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3a hides C2 { }
        my class C3 does R3a { }
        my class C4 is C3 { }

        is-deeply C4.^mro_unhidden[0..*-3], (C4, C3, C1), "'hides' on consumed role is preserved"
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3a is C2 is hidden { }
        my role R3b { }
        my class C3 is R3a is R3b { }
        my class C4 is C3 { }

        is-deeply C4.^mro_unhidden[0..*-3], (C4, C3, C2, C1, R3b.^pun), "'is hidden' is preserved on puned roles"
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3a is C2 { }
        my role R3b { }
        my class C3 hides R3a is R3b { }
        my class C4 is C3 { }

        is-deeply C4.^mro_unhidden[0..*-3], (C4, C3, C2, C1, R3b.^pun), "'hides' on a role hides its pun"
    }
}

# vim: expandtab shiftwidth=4
