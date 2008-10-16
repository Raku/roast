use v6;

use Test;

plan 1;

=begin pod

Classes with names containing double colons.

=end pod

class Foo::Bar {
    method baz {
        return 42;
    }
}

{
    my $foobar = Foo::Bar.new();
    #?rakudo todo 'classes with namespaces with ::'
    is($foobar.baz, 42,
        'methods can be called on classes with namespaces with ::');
}
