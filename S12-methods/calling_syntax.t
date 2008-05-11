use v6;

use Test;

plan 5;

=begin description

Test for 

=end description

# L<S02/Literals/"$x.foo;">

class Foo {
    method foo {
        42
    }
    method bar() {
        101
    }
    method identity($x) {
        $x
    }
}

my $x = Foo.new();
is($x.foo, 42, 'called a method without parens');
is($x.foo(), 42, 'called a method without parens');
is($x.bar, 101, 'called a method with parens');
is($x.bar(), 101, 'called a method with parens');
is($x.identity("w00t"), "w00t", 'called a method with a parameter');

# vim: syn=perl6
