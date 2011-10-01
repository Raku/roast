use v6;

use Test;

plan 7;

# L<S12/"Open vs Closed Classes"/"Otherwise you'll get a class redefinition error.">


use MONKEY_TYPING;
{
    class Foo {
        method a {'called Foo.a'}
    }
    augment class Foo {
        method b {'called Foo.b'}
    }

    my $o = Foo.new;
    is($o.a, 'called Foo.a', 'basic method call works');
    is($o.b, 'called Foo.b', 'added method call works');

    ok(!eval('augment class NonExistent { }'), 'augment on non-existent class dies');
}

# RT #76104
{
    augment class Hash {
        method foo() { self.keys };
    }
    is { a => 1 }.foo, 'a', 'can augment Hash';
}

# RT #66694
eval_dies_ok q[
    class MethodClash { method foo() { 3 } };
    augment class MethodClash { method foo() { 3 } };
], 'cannot override a method by monkey-typing';

#?rakudo skip 'supersede'
{
    class Bar {
        method c {'called Bar.c'}
    }
    supersede class Bar {
        method d {'called Bar.d'}
    }

    my $o = Bar.new;
    eval_dies_ok('$o.c', 'overridden method is gone completely');
    is($o.d, 'called Bar.d', 'new method is present instead');
}

# vim: ft=perl6
