use v6;

use Test;

plan 5;

# L<S12/Attributes/If you declare the class as>

class Foo {
    has $.readonly_attr;
}

{
    my Foo $foo .= new;
    dies_ok { $foo.readonly_attr++ }, "basic sanity";
}


class Bar is rw {
    has $.readwrite_attr;
    has $.but_not_this is readonly;
}

{
    my Bar $bar .= new(but_not_this => 42);
    
    lives_ok { $bar.readwrite_attr++ },
        "'is rw' on the class declaration applies to all attributes (1)";
    is $bar.readwrite_attr, 1,
        "'is rw' on the class declaration applies to all attributes (2)";

    dies_ok { $bar.but_not_this = 42 },
        "'is readonly' on a specific attribute can overrule the is rw on the class (1)";
    is $bar.but_not_this, 42,
        "'is readonly' on a specific attribute can overrule the is rw on the class (2)";
}

# vim: ft=perl6
