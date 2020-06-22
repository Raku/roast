use v6;
use Test;

plan 28;

class Parent {
    has $.x;
}

class Child is Parent {
    has $.y;
}

my $o;
lives-ok { $o =  Child.new(:x(2), :y(3)) }, 
         'can instantiate class with parent attributes';

is $o.y, 3, '... worked for the child';
is $o.x, 2, '... worked for the parent';

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 3 skip 'parent attributes in initialization'
lives-ok { $o = Child.new( :y(4), Parent{ :x<5> }) }, 
         'can instantiate class with explicit specification of parent attrib';

is $o.y, 4, '... worked for the child';
is $o.x, 5, '... worked for the parent';

class GrandChild is Child {
}

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo 6 skip 'parent attributes in initialization'
lives-ok { $o = GrandChild.new( Child{ :y(4) }, Parent{ :x<5> }) },
         'can instantiate class with explicit specification of parent attrib (many parents)';
is $o.y, 4, '... worked for the class Child';
is $o.x, 5, '... worked for the class Parent';
lives-ok { $o = GrandChild.new( Parent{ :x<5> }, Child{ :y(4) }) }, 
         'can instantiate class with explicit specification of parent attrib (many parents, other order)';
is $o.y, 4, '... worked for the class Child (other order)';
is $o.x, 5, '... worked for the class Parent (other order)';

# https://github.com/Raku/old-issue-tracker/issues/1030
{
    class RT66204 {}
    ok ! RT66204.defined, 'NewClass is not .defined';
    dies-ok { RT66204 .= new }, 'class asked to build itself refuses';
    ok ! RT66204.defined, 'NewClass is still not .defined';
}

# https://github.com/Raku/old-issue-tracker/issues/1460
{
    class RT71706 {
        class RT71706::Artie {}
    }
    # TODO: check the error message, not just the timing.
    #?rakudo todo "nested package handling does't quite get this one right"
    dies-ok { RT71706::Artie.new }, 'die trying to instantiate missing class';
}

# https://github.com/Raku/old-issue-tracker/issues/1353
{
    class NewFromMu {
        has $.x;
        has $.y;

        method new($a, $b) {
            self.Mu::new(:x($a), :y($b));
        }
    }

    my $x;
    lives-ok { $x = NewFromMu.new('j', 'k') }, 'can delegate to self.Mu::new';
    is $x.x, 'j', '... got the right attribute (1)';
    is $x.y, 'k', '... got the right attribute (2)';
}

{
    my class MultiNewFromMu {
        has $.x;
        multi method new($x) {
            self.new(:$x);
        }
    }
    is MultiNewFromMu.new('wirklich!').x, 'wirklich!',
       'Mu.new is a multi method';
}

# https://github.com/Raku/old-issue-tracker/issues/1250
{

    class RT68756 {
        has $.a1;
        has $.a2;

        multi method new(Int $number, Str $color) {
            self.bless(:a1($number), :a2($color));
        }
    }


    my RT68756 $foo .= new(2, "geegaw");
    is-deeply [ $foo.a1, $foo.a2 ],
        [2, "geegaw"],
        'multi-constructor class alternate (positional) constructor';

    my RT68756 $bar .= new(:a1(3), :a2<yoohoo>);
    is-deeply [ $bar.a1, $bar.a2 ],
        [3, "yoohoo"],
        'multi-constructor class alternate default named constructor';
}

# https://github.com/Raku/old-issue-tracker/issues/1228
{
    class RT68558 {
        has $.foo;
        method new($foo) { nextwith(:$foo) }
    }
    is RT68558.new('x').foo, 'x', 'Can call nextwith in .new';

}

# https://github.com/Raku/old-issue-tracker/issues/2506
{
    # https://github.com/Raku/old-issue-tracker/issues/2506
    dies-ok { X.new }, 'RT #100780'
}

# https://github.com/Raku/old-issue-tracker/issues/1673
{
    class RT74300 {
        has $.foo;
        multi method new($) {}
    }
    is RT74300.new(:foo<bar>).foo, 'bar', 'multi method($) does not break attribute initialization';
}

# https://github.com/Raku/old-issue-tracker/issues/2053
{
    my class RT77200 { }
    lives-ok { my RT77200 $lex .= new },
        "Can call .=new on a variable of a lexical type";
}

# https://github.com/rakudo/rakudo/issues/2782
{
    my class A { has $.a; }
    my class B { has $.b }
    my class C is B is A { }
    given C.new(:a(1), :b(2)) {
        is .a, 1, "Initialization of attributes in multiple inheritance works (1)";
        is .b, 2, "Initialization of attributes in multiple inheritance works (2)";
    }
}

# vim: expandtab shiftwidth=4
