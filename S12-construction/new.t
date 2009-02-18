use v6;
use Test;

plan 12;

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

lives_ok { $o = Child.new( :y(4), Parent{ :x<5> }) }, 
         'can instantiate class with explicit specification of parent attrib';

is $o.y, 4, '... worked for the child';
is $o.x, 5, '... worked for the parent';

class GrandChild is Child {
}

lives_ok { $o = GrandChild.new( Child{ :y(4) }, Parent{ :x<5> }) }, 
         'can instantiate class with explicit specification of parent attrib (many parents)';
is $o.y, 4, '... worked for the class Child';
is $o.x, 5, '... worked for the class Parent';
lives_ok { $o = GrandChild.new( Parent{ :x<5> }, Child{ :y(4) }) }, 
         'can instantiate class with explicit specification of parent attrib (many parents, other order)';
is $o.y, 4, '... worked for the class Child (other order)';
is $o.x, 5, '... worked for the class Parent (other order)';
