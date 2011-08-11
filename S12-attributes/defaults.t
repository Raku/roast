use v6;

use Test;

plan 21;

# L<S12/Attribute default values/The value on the right is evaluated at object build time>

my $got_a_num;  sub get_a_num  { $got_a_num++;  42 }
my $got_a_str;  sub get_a_str  { $got_a_str++;  "Pugs" }

my $got_a_code;
my $was_in_closure;
sub get_a_code {
    $got_a_code++;
    return {
        $was_in_closure++;
        42;
    };
}

# L<S12/Attribute default values/the attribute being initialized>

my $set_by_code_attr;

class Foo {...}
eval 'class Foo {
    has $.num  = get_a_num();
    has $.str  = { get_a_str() };
    has $.code = { get_a_code() };

    has $.set_by_code = {
        $set_by_code_attr := $_;
        42;
    };

    has $.self_in_code = { self.echo };

    method echo { "echo" }
}';

{
    is $got_a_num, 1, "default should be called at compile-time";
    my Foo $foo .= new;
    is $got_a_num, 1, "default should be called only once, at compile-time (1)";
    is $foo.num,  42, "attribute default worked";
    is $got_a_num, 1, "default should be called only once, at compile-time (2)";
}

{
    $got_a_str = 0;  # reset

    {
        my Foo $foo .= new;
        is $got_a_str,            1, "using a coderef as a default value delays execution";
        is try { $foo.str }, "Pugs", "attribute default worked";
    }

    {
        my Foo $foo .= new;
        is $got_a_str,            2, "using a coderef as a default value delays execution";
        is try { $foo.str }, "Pugs", "attribute default worked";
    }
}

{
    $got_a_code = 0;  # reset

    {
        my Foo $foo .= new;
        is $got_a_code,     1, "using a coderef as a default value delays execution";
        is $was_in_closure, 0, "sub-coderef not yet executed";
        try { $foo.code };
        is $was_in_closure, 0, "sub-coderef still not executed";
    }

    {
        my Foo $foo .= new;
        is $got_a_code,          2, "using a coderef as a default value delays execution";
        is $was_in_closure,      0, "sub-coderef not yet executed";
        is try { $foo.code() }, 42, "sub-coderef execution works";
        is $was_in_closure,      1, "sub-coderef still not executed";
    }
}

{
    my Foo $foo .= new;

    is try { $foo.set_by_code }, 42, '$_ is the attribute being initialized (1)';
    is $set_by_code_attr,        42, '$_ is the attribute being initialized (2)';

    lives_ok { $set_by_code_attr++ },
        '$_ is the attribute being initialized (3)';

    is try { $foo.set_by_code }, 43, '$_ is the attribute being initialized (4)';
    is $set_by_code_attr,        43, '$_ is the attribute being initialized (5)';
}

{
    my Foo $foo .= new;

    is try { $foo.self_in_code }, "echo", "self is the object being initialized";
}

# vim: ft=perl6
