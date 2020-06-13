use v6;

use Test;

plan 3;

# L<S12/Attributes/If you declare the class as>

subtest "Basic sanity" => {
    plan 1;
    my class Foo {
        has $.readonly_attr;
    }
    my Foo $foo .= new;
    dies-ok { $foo.readonly_attr++ }, "the default is readonly";
}

subtest "'is rw' on a class" => {
    plan 4;

    my class Bar is rw {
        has $.readwrite_attr;
        has $.but_not_this is readonly;
    }

    my Bar $bar .= new(but_not_this => 42);

    lives-ok { $bar.readwrite_attr++ },
        "'is rw' on the class declaration applies to all attributes (1)";
    is $bar.readwrite_attr, 1,
        "'is rw' on the class declaration applies to all attributes (2)";

    dies-ok { $bar.but_not_this = 42 },
        "'is readonly' on a specific attribute can overrule the is rw on the class (1)";
    is $bar.but_not_this, 42,
        "'is readonly' on a specific attribute can overrule the is rw on the class (2)";
}

subtest "With 'also is rw'" => {
    plan 6;

    my class C {
        has $.a;
        has $.a-ro is readonly;
        also is rw;
        has $.b;
    }

    my $obj = C.new( a => 12, a-ro => 42, b => 1 );
    lives-ok { $obj.a++ }, "'also is rw' is being respected as class default";
    is $obj.a, 13, "attribute value has been changed";
    lives-ok { $obj.b-- }, "post-'also is rw' attribute is writable";
    is $obj.b, 0, "post-'also is rw' attribute value changed";
    dies-ok { $obj.a-ro++ }, "'is readonly' is not altered";
    is $obj.a-ro, 42, "readonly attribute value unchanged";
}

# vim: expandtab shiftwidth=4
