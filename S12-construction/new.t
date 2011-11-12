use v6;
use Test;

plan 23;

class Parent {
    has $.x;
}

class Child is Parent {
    has $.y;
}

my $o;
lives_ok { $o =  Child.new(:x(2), :y(3)) }, 
         'can instantiate class with parent attributes';

is $o.y, 3, '... worked for the child';
is $o.x, 2, '... worked for the parent';

#?rakudo 3 todo 'parent attributes in initialization'
lives_ok { $o = Child.new( :y(4), Parent{ :x<5> }) }, 
         'can instantiate class with explicit specification of parent attrib';

is $o.y, 4, '... worked for the child';
is $o.x, 5, '... worked for the parent';

class GrandChild is Child {
}

#?rakudo 6 todo 'parent attributes in initialization'
lives_ok { $o = GrandChild.new( Child{ :y(4) }, Parent{ :x<5> }) },
         'can instantiate class with explicit specification of parent attrib (many parents)';
is $o.y, 4, '... worked for the class Child';
is $o.x, 5, '... worked for the class Parent';
lives_ok { $o = GrandChild.new( Parent{ :x<5> }, Child{ :y(4) }) }, 
         'can instantiate class with explicit specification of parent attrib (many parents, other order)';
is $o.y, 4, '... worked for the class Child (other order)';
is $o.x, 5, '... worked for the class Parent (other order)';

# RT #66204
{
    class RT66204 {}
    ok ! RT66204.defined, 'NewClass is not .defined';
    dies_ok { RT66204 .= new }, 'class asked to build itself refuses';
    ok ! RT66204.defined, 'NewClass is still not .defined';
}

# RT 71706
{
    class RT71706 {
        class RT71706::Artie {}
    }
    # TODO: check the error message, not just the timing.
    #?rakudo todo "nested package handling does't quite get this one right"
    dies_ok { RT71706::Artie.new }, 'die trying to instantiate missing class';
}

# RT #69676
{
    class NewFromMu {
        has $.x;
        has $.y;

        method new($a, $b) {
            self.Mu::new(:x($a), :y($b));
        }
    }

    my $x;
    lives_ok { $x = NewFromMu.new('j', 'k') }, 'can delegate to self.Mu::new';
    is $x.x, 'j', '... got the right attribute (1)';
    is $x.y, 'k', '... got the right attribute (2)';
}

# RT #68756
{

    class RT68756 {
        has $.a1;
        has $.a2;

        multi method new(Int $number, Str $color) {
            self.bless(*, :a1($number), :a2($color));
        }
    }


    my RT68756 $foo .= new(2, "geegaw");
    is_deeply [ $foo.a1, $foo.a2 ],
        [2, "geegaw"],
        'multi-constructor class alternate (positional) constructor';

    my RT68756 $bar .= new(:a1(3), :a2<yoohoo>);
    is_deeply [ $bar.a1, $bar.a2 ],
        [3, "yoohoo"],
        'multi-constructor class alternate default named constructor';
}

# RT #68558
{
    class RT68558 {
        has $.foo;
        method new($foo) { nextwith(:$foo) }
    }
    is RT68558.new('x').foo, 'x', 'Can call nextwith in .new';

}

# RT #100780
{
    dies_ok { X.new }, 'RT #100780'
}

done;

# vim: ft=perl6
