use v6;

use Test;

plan 14;

# L<S12/"Open vs Closed Classes"/"Otherwise you'll get a class redefinition error.">


use MONKEY-TYPING;
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

    dies-ok { EVAL('augment class NonExistent { }') },
        'augment on non-existent class dies';
}

# https://github.com/Raku/old-issue-tracker/issues/1746
{
    my class LexFoo { };
    augment class LexFoo { method b { 'called LexFoo.b' } };
    is LexFoo.b, 'called LexFoo.b', 'can augment lexical class';
}

# https://github.com/Raku/old-issue-tracker/issues/1876
{
    augment class Hash {
        method foo() { self.keys };
    }
    is { a => 1 }.foo, 'a', 'can augment Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/1073
throws-like q[
    class MethodClash { method foo() { 3 } };
    augment class MethodClash { method foo() { 3 } };
], X::Syntax::Augment::WithoutMonkeyTyping, 'cannot override a method by monkey-typing';

# https://github.com/Raku/old-issue-tracker/issues/1950
eval-lives-ok q[
    use MONKEY-TYPING;
    role Bar { has $.counter; }
    class Pub does Bar { has $.saloon; }
    augment class Pub { method snug() { } }
], 'augmenting a class which has a role composed works';


#?rakudo skip 'redeclaration of symbol Bar'
{
    use MONKEY-TYPING;
    class Bar {
        method c {'called Bar.c'}
    }
    supersede class Bar {
        method d {'called Bar.d'}
    }

    my $o = Bar.new;
    throws-like '$o.c', Exception, 'overridden method is gone completely';
    is($o.d, 'called Bar.d', 'new method is present instead');
}

# https://github.com/Raku/old-issue-tracker/issues/1792
{
    lives-ok {
        class A { multi method a() { }};
        augment class A { multi method a() { } }
    }, 'cannot add multis with augment'
}

# https://github.com/Raku/old-issue-tracker/issues/1447
# some integers produces from ranges didn't have 
# methods that augment added. Weird.

{
    augment class Int {
        method prime { True };
    }
    my $primes = 0;
    lives-ok {
        for 1..5 {
            $primes++ if .prime;
        }
    }, 'integers produced from ranges have augmented methods';
}

# https://github.com/Raku/old-issue-tracker/issues/3080
{
    try EVAL 'class F { also is F; }';
    ok ~$! ~~ / 'cannot inherit from itself' /, "used to crash rakudo";
}

# https://github.com/Raku/old-issue-tracker/issues/3081
{
    try EVAL 'class ::F { ... }; class F is ::F';
    ok ~$! ~~ / 'cannot inherit from itself' /, "used to crash rakudo";
}

eval-lives-ok 'class A { class B {} }; use MONKEY; augment class A { augment class B { } }',
    'Augmenting a nested package lives';

# vim: expandtab shiftwidth=4
