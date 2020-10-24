use v6.d;

use Test;

plan 31;

# L<S12/"Multisubs and Multimethods">
# L<S12/"Trusts">

class Foo {
    multi method bar() {
        return "Foo.bar() called with no args";
    }

    multi method bar(Str $str) {
        return "Foo.bar() called with Str : $str";
    }

    multi method bar(Int $int) {
        return "Foo.bar() called with Int : $int";
    }

    multi method bar(Numeric $num) {
        return "Foo.bar() called with Numeric : $num";
    }

    multi method baz($f) {
        return "Foo.baz() called with parm : $f";
    }
}


my $foo = Foo.new();
is($foo.bar(), 'Foo.bar() called with no args', '... multi-method dispatched on no args');

is($foo.bar("Hello"), 'Foo.bar() called with Str : Hello', '... multi-method dispatched on Str');

is($foo.bar(5), 'Foo.bar() called with Int : 5', '... multi-method dispatched on Int');
is($foo.bar(4.2), 'Foo.bar() called with Numeric : 4.2', '... multi-method dispatched on Numeric');

throws-like { $foo.baz() }, X::Multi::NoMatch,
    "Call with wrong nnumber of args results in no matching candidate exception";

class Foo2 {
    multi method a($d) {   #OK not used
        "Any-method in Foo";
    }
}
class Bar is Foo2 {
    multi method a(Int $d) {   #OK not used
        "Int-method in Bar";
    }
}

is Bar.new.a("not an Int"), 'Any-method in Foo';

# RT #67024
{
    try { EVAL 'class RT67024 { method a(){0}; method a($x){1} }' };
    ok  $!  ~~ Exception, 'redefinition of non-multi method (RT #67024)';
    ok "$!" ~~ /multi/, 'error message mentions multi-ness';
}

# RT #69192
# RT #124848'
{
    role R5 {
        multi method rt69192()       { push @.order, 'empty' }
        multi method rt69192(Str $a) { push @.order, 'Str'   }   #OK not used
    }
    role R6 {
        multi method rt69192(Numeric $a) { push @.order, 'Numeric'   }   #OK not used
    }
    class RT69192 { has @.order }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        $bot.*rt69192;
        is $bot.order, <empty>, 'multi method called once on empty signature';
    }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        $bot.*rt69192('RT #69192');
        is $bot.order, <Str>, 'multi method called once on Str signature';
    }

    {
        my RT69192 $bot .= new();
        $bot does (R5, R6);
        $bot.*rt69192( 69192 );
        is $bot.order, <Numeric>, 'multi method called once on Numeric signature';
    }
}

{
    role RoleS {
        multi method d( Str $x ) { 'string' }   #OK not used
    }
    role RoleI {
        multi method d( Int $x ) { 'integer' }   #OK not used
    }
    class M does RoleS does RoleI {
        multi method d( Any $x ) { 'any' }   #OK not used
    }

    my M $m .= new;

    is $m.d( 876 ), 'integer', 'dispatch to one role';
    is $m.d( '7' ), 'string',  'dispatch to other role';
    is $m.d( 1.2 ), 'any',     'dispatch to the class with the roles';

    my @multi_method = $m.^methods.grep({ .gist eq 'd' });
    is @multi_method.elems, 1, '.^methods returns one element for a multi';

    my $routine = @multi_method[0];
    ok $routine ~~ Routine, 'multi method from ^methods is a Routine';
    my @candies = $routine.candidates;
    is @candies.elems, 3, 'got three candidates for multi method';

    ok @candies[0] ~~ Method, 'candidate 0 is a method';
    ok @candies[1] ~~ Method, 'candidate 1 is a method';
    ok @candies[2] ~~ Method, 'candidate 2 is a method';
}

{
    class BrokenTie {
        multi method has_tie(Int $x) { 'tie1' };   #OK not used
        multi method has_tie(Int $y) { 'tie2' };   #OK not used
    }

    dies-ok { BrokenTie.has_tie( 42 ) }, 'call to tied method dies';

    class WorkingTie is BrokenTie {
        multi method has_tie(Int $z) { 'tie3' };   #OK not used
        multi method has_tie(Str $s) { 'tie4' };   #OK not used
    }

    is WorkingTie.has_tie( 42 ), 'tie3', 'broken class fixed by subclass (1)';
    is WorkingTie.has_tie( 'x' ), 'tie4', 'broken class fixed by subclass (2)';

    my $error;
    try {
        WorkingTie.new.has_tie([]);
    }
    $error = "$!";
    ok $error ~~ /<< 'has_tie' >>/,
        'error message for failed dispatch contains method name';
    ok $error ~~ /<< 'WorkingTie' >>/,
        'error message for failed dispatch contains invocant type';
}

# RT #68996
{
    class A {
        has $.foo = "bar";
        multi method foo(Str $test) {
            return $test;
        }
    };

    my $a = A.new;

    is $a.foo("oh hai"), "oh hai",
        'foo() method works when $.foo attribute is present';

    dies-ok { $a.foo },
        '$.foo attribute has no accessor when foo() method is present';
}

# RT #57788
{
    throws-like 'class RT57788 { method m() { }; method m() { } }', Exception;
}

{
    class B {
        multi method foo() { }
        multi method bar() { }
    }

    lives-ok { B.new.foo() },
        'multis with different names but same signatures are not ambiguous';
}

# RT #74646
{
    my class A {
        multi submethod foo(Str $a) { "specific" }
    }
    my class B is A {}
    is A.new.foo("OH HAI"), 'specific', 'multi submethod can be called on exact instance';
    throws-like { B.new.foo("OH HAI") }, X::Method::NotFound, 'multi submethod is not inherited';
}

# vim: ft=perl6
