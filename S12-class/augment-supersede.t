use v6;

use Test;

plan 11;

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

    dies_ok { eval('augment class NonExistent { }') },
        'augment on non-existent class dies';
}

# RT #74910
{
    my class LexFoo { };
    augment class LexFoo { method b { 'called LexFoo.b' } };
    is LexFoo.b, 'called LexFoo.b', 'can augment lexical class';
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

# RT #76600
eval_lives_ok q[
    use MONKEY_TYPING;
    role Bar { has $.counter; }
    class Pub does Bar { has $.saloon; }
    augment class Pub { method snug() { } }
], 'augmenting a class which has a role composed works';


#?rakudo skip 'redeclaration of symbol Bar'
{
    use MONKEY_TYPING;
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

# RT #75432
{
    lives_ok {
        class A { multi method a() { }};
        augment class A { multi method a() { } }
    }, 'RT #75432'
}

# RT #71456
# some integers produces from ranges didn't have 
# methods that augment added. Weird.

{
    augment class Int {
        method prime { True };
    }
    my $primes = 0;
    lives_ok {
        for 1..5 {
            $primes++ if .prime;
        }
    }, 'integers produced from ranges have augmented methods';
}

# vim: ft=perl6
