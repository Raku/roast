use v6;

use Test;

plan 4;

# L<S12/"Open vs Closed Classes"/"Otherwise you'll get a class redefinition error.">

{
    class Foo {
        method a {'called Foo.a'}
    }
    class Foo is also {
        method b {'called Foo.b'}
    }

    my $o = Foo.new;
    is($o.a, 'called Foo.a', 'basic method call works');
    is($o.b, 'called Foo.b', 'added method call works');
}

#?rakudo skip 'is instead not yet implemented'
#?DOES 2
{
    class Bar {
        method c {'called Bar.c'}
    }
    class Bar is instead {
        method d {'called Bar.d'}
    }

    my $o = Bar.new;
    eval_dies_ok('$o.c', 'overridden method is gone completely');
    is($o.d, 'called Bar.d', 'new method is present instead');
}
