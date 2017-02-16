use v6;

use Test;

plan 23;

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
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with recursively-typed attribute';
    isa-ok $a, A, 'Sanity check, $a is of type A';
    ok $b.attr === $a, "Recursively-typed attribute stores correctly";
    lives-ok { $a.attr = $b; }, "Cycles are fine";
    ok $b.attr.attr === $b, "Cycles resolve correctly";
}

#L<S12/Class attributes/"Class attributes are declared">
{
    class B {
        my B $.attr;
    };
    
    my B $a;
    lives-ok {
        $a .= new();
        B.attr = $a;
    }, "Can instantiate class with recursively-typed class lexical";
    ok B.attr === $a, "Recursively-typed class lexical stores correctly";
    
}

#L<S12/Invocants/current lexically-determined class ::?CLASS>
{
    class C {
        has ::?CLASS $.attr is rw;
    };

    my C $a;
    my C $b;
    lives-ok {
        $a .= new();
        $b .= new(:attr($a));
    }, 'Can instantiate class with ::?CLASS attribute';
    is $b.attr, $a, '::?CLASS attribute stores correctly';
    lives-ok { $a.attr = $b; }, '::?CLASS cycles are fine';
    ok $b.attr.attr === $b, '::?CLASS cycles resolve correctly';
    lives-ok { $a.attr .= new(); }, 'Can instantiate attribute of type ::?CLASS';
    isa-ok $a.attr, C, '::?CLASS instantiates to correct class';


    class D is C { };
    my D $d;
    lives-ok {
        $d .= new();
        $d.attr .= new();
    }, 'Can instantiate derived class with ::?CLASS attribute';
    isa-ok $d.attr, C, '::?CLASS is lexical, not virtual';
}

# RT #67236
{
    class Z {
        has Z @.a is rw;
        has Z %.h is rw;
    }

    my $z1 = Z.new;
    isa-ok $z1.a[0], Z, "check type-object";
    lives-ok { $z1.a[0] = Z.new }, 'can assign';
    isa-ok $z1.a[0], Z;
    isa-ok $z1.h<k>, Z, "check type-object";
    lives-ok { $z1.h<k> = Z.new }, 'can assign';
    isa-ok $z1.h<k>, Z;

    my $z2 = Z.new;
    lives-ok { $z2.a.push( Z.new ) }, 'can push';
    isa-ok $z2.a[0], Z;
}

# vim: ft=perl6
