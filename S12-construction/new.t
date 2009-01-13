use v6;
use Test;

plan 6;

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

#?rakudo todo 'OO initialization bug'
is $o.y, 4, '... worked for the child';
is $o.x, 5, '... worked for the parent';
