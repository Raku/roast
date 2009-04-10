use v6;

use Test;

plan 3;

# L<S12/Attributes/If you declare the class as>

class Foo {
    has $.readonly_attr;
}

{
    my Foo $foo .= new;
    dies_ok { $foo.readonly_attr++ }, "basic sanity", :todo<bug>;
}


class Bar is rw {
    has $.readwrite_attr;
}

{
    my Bar $bar .= new;
    lives_ok { $bar.readwrite_attr++ },
        "'is rw' on the class declaration applies to all attributes (1)";
    is $bar.readwrite_attr, 1,
        "'is rw' on the class declaration applies to all attributes (2)";
}
