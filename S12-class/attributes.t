use v6;

use Test;

plan 33;

# L<S12/Fancy method calls/"For a call on your own private method">

class Counter {
    has $!x;
    method init { $!x = 41 }
    method get { $!x }
    method inc { $!x++ }
}

my $c = Counter.new();
dies_ok { $c.x }, 'no public accessor for private attribute';
$c.init();
is($c.get(), 41, 'can assign and get from within the class');
$c.inc();
is($c.get(), 42, 'can auto-increment an attribute');

{
    class WithAlias {
        has $x;
        method set($a) { $x = $a }
        method get { $!x }
    }

    my $wa = WithAlias.new();
    $wa.set(99);
    is($wa.get, 99, 'has with no twigil creates alias');
}

#?niecza skip 'Unhandled parameter twigil !'
{
    class ManyTest {
        has ($a, $b);
        has ($.c, $.d);
        has ($!e, $!f);
        submethod BUILD(:$!a, :$!b, :$!c, :$!d, :$!e, :$!f) { }
        method t1 {
            $a + $b
        }
        method t2 {
            $!a + $!b
        }
        method t3 {
            $!e + $!f
        }
    }

    my $m = ManyTest.new(a => 1, b => 2, c => 3, d => 4, e => 5, f => 6);
    is($m.c, 3, 'list attribute declaration of publics works');
    is($m.d, 4, 'list attribute declaration of publics works');
    is($m.t1, 3, 'list attribute declaration of alias works');
    is($m.t2, 3, 'list attribute declaration of alias works');
    is($m.t3, 11, 'list attribute declaration of privates works');
}

class Foo {
    has %.bar is rw;
    method set_bar {
        %.bar<a> = 'baz';
    }
}
my $foo = Foo.new;
isa_ok($foo.bar, Hash,    'hash attribute initialized');
$foo.set_bar();
is($foo.bar<a>, 'baz',    'hash attribute initialized/works');
my %s = $foo.bar;
is(%s<a>, 'baz',          'hash attribute initialized/works');
$foo.bar<b> = 'wob';
is($foo.bar<b>, 'wob',    'hash attribute initialized/works');

class Bar {
    has @.bar is rw;
    method set_bar {
        @.bar[0] = 100;
        @.bar[1] = 200;
    }
}
my $bar = Bar.new;
isa_ok($bar.bar.WHAT, Array, 'array attribute initialized');
$bar.set_bar();
is($bar.bar[0], 100,       'array attribute initialized/works');
is($bar.bar[1], 200,       'array attribute initialized/works');
my @t = $bar.bar;
is(@t[0], 100,             'array attribute initialized/works');
is(@t[1], 200,             'array attribute initialized/works');
$bar.bar[2] = 300;
is($bar.bar[2], 300,       'array attribute initialized/works');

# RT #73808
#?niecza skip 'Unhandled parameter twigil !'
{
    class RT73808 {
        has ($!a, $!b);
        method foo {
            $!a = 1;
            $!b = 3;
            return $!a + $!b;
        }
    }
    is RT73808.new.foo, 4,
        'Providing a list of attributes to a single "has" works';
}

# RT 81718
eval_dies_ok q[
    class RT81718 {
        has $.bughunt is rw;
        sub bomb { "life is a $.bughunt" }
        method meta_bomb { "the good " ~ bomb() }
    }
], 'no attr access for sub inside class';

# RT 74850
#?niecza skip "Unhandled exception: Unable to resolve method ctxzyg in type Method"
#?rakudo skip "Cannot use .= to initialize an attribute"
{
    class A { };
    class B { has A $.foo .= new };
    isa_ok B.new.foo, A, 'class attribute can be initialized using .=';
}

#RT #115280
{
    eval_lives_ok '(class A { has $.x }).new.x.HOW',
        "HOW on attributes lives, custom class";
    eval_lives_ok '(1/2).numerator.HOW',
        "HOW on attributes lives, builtin";
}

#RT #114234
#?niecza skip '$b declared but not used. FIXME later.'
{
    eval_lives_ok q{
        my class A { state $b; }
    }, "No segfault on state variables";
}

#RT #75010
# Note, all ranges now autotruncate if they run off the end, not just infinite ones
{

    my @y=1,2,3;
    is_deeply( [@y], [ 1, 2, 3 ], 'Plain array' );
    is_deeply( [@y[1 .. +@y]], [ 2, 3 ], 'Array from 2-nd element to end+1' );
    is_deeply( [@y[1 ..^ +@y]], [ 2, 3 ], 'Array from 2-nd element to end' );

    class AB {
        has @.x; 
        method aa { 
            my @y=1,2,3; 
            is_deeply( [@y[1 .. +@y]], [ 2, 3 ], 'Plain array in the method' );
            is_deeply( [@.x], [ 1, 2, 3 ], 'Array from 2-nd element to end+1 in the method' );
            is_deeply( [@.x[1 ..^ +@.x]], [ 2, 3 ], 'Array from 2-nd element to end in the method' );
        }
    };

    my AB $y.=new(:x(1,2,3)); 
    $y.aa;

}

# RT #75858
#?rakudo todo 'where clauses on attributes NYI, RT #122109'
{
    lives_ok { EVAL 'my class RT75858 { has $.x where 1 }' },
        'can use where clause on an attribute';
}

# RT #122109
#?rakudo skip 'where clauses on attributes NYI, RT #122109'
{
    my class RT122109 { has $.x where * > 0 };
    dies_ok { RT122109.new(:x(-42)) },
        'where clause on attributes is taken into account';
}

# vim: ft=perl6
