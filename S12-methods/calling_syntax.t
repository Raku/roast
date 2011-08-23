use v6;

use Test;

plan 11;

=begin description

Test for 

=end description

# L<S02/Bare identifiers/"$x.foo;">

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

# L<S12/Methods/"You can replace the identifier with a quoted string">
eval_dies_ok(q{$x.'foo'}, 'indirect method call using quotes, no parens');
is($x.'bar'(), 101, 'indirect method call using quotes, with parens');   #OK use of quotes
is($x.'identity'('qwerty'), 'qwerty', 'indirect method call using quotes, with parameter');   #OK use of quotes
{
    my $name = 'foo';
    eval_dies_ok(q{$x."$name"}, 'indirect method call, no parens');
    is($x."$name"(), 42, 'indirect method call, with parens');
}
{
    my $name = 'identity';
    is($x."$name"('asdf'), 'asdf', 'indirect method call, with parameter');
}

# vim: syn=perl6
