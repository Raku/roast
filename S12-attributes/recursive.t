use v6;

use Test;

plan 15;

=begin pod

Test attributes with recursively typed attributes

=end pod

#L<S12/Attributes>
{
    class A {
        has A $.attr is rw;
    };

    my A $a;
    my A $b;
    lives_ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with recursively-typed attribute';
    isa_ok $a, 'A', 'Sanity check, $a is of type A';
    ok $b.attr === $a, "Recursively-typed attribute stores correctly";
    lives_ok { $a.attr = $b; }, "Cycles are fine";
    ok $b.attr.attr === $b, "Cycles resolve correctly";
}

#L<S12/Attributes/"Class attributes are declared">
{
    class B {
        my B $.attr is rw;
    };
    
    my B $a;
    lives_ok {
        $a .= new();
        B.attr = $a;
    }, "Can instantiate class with recursively-typed class lexical";
    ok B.attr === $a, "Recursively-typed class lexical stores correctly";
    
}

#L<S12/Methods/current lexically-determined class ::?CLASS>
#?rakudo skip '::?CLASS'
{
    class C {
        has ::?CLASS $.attr is rw;
    };

    my C $a;
    my C $b;
    lives_ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with ::?CLASS attribute';
    is $b.attr, $a, '::?CLASS attribute stores correctly';
    lives_ok { $a.attr = $b; }, '::?CLASS cycles are fine';
    ok $b.attr.attr === $b, '::?CLASS cycles resolve correctly';
    lives_ok { $a.attr .= new(); }, 'Can instantiate attribute of type ::?CLASS';
    isa_ok $a.attr, C, '::?CLASS instantiates to correct class';


    class D is C { };
    my D $d;
    lives_ok {
        $d .= new();
        $d.attr .= new();
    }, 'Can instantiate derived class with ::?CLASS attribute';
    isa_ok $d.attr, C, '::?CLASS is lexical, not virtual', :todo<bug>;
}

