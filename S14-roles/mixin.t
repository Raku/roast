use v6;
use Test;
plan 50;

# L<S14/Run-time Mixins/>

role R1 { method test { 42 } }
class C1 { }

my $x = C1.new();
$x does R1;
is $x.test,     42,         'method from a role can be mixed in';
is $x.?test,    42,         '.? form of call works on a mixed-in role';
#?niecza skip 'NYI dottyop form .+'
is $x.+test,    42,         '.+ form of call works on a mixed-in role';
#?niecza skip 'NYI dottyop form .*'
is $x.*test,    42,         '.* form of call works on a mixed-in role';


role R2 { method test { 42 } }
class C2 { has $.x }
my $y = C2.new(x => 100);
is $y.x,        100,        'initialization sanity check';
$y does R2;
is $y.test,     42,         'method from role was mixed in';
is $y.x,        100,        'mixing in did not destroy old value';


role R3 { has $.answer is rw }
class C3 { has $.x }
$y = C3.new(x => 100);
$y does R3;
$y.answer = 42;
is $y.x,        100,        'mixing in with attributes did not destroy existing ones';
is $y.answer,   42,         'mixed in new attributes';


$y = C3.new(x => 100);
$y does (R2, R3);
$y.answer = 13;
is $y.x,        100,        'multi-role mixin preserved existing values';
is $y.answer,   13,         'attribute from multi-role mixing OK';
is $y.test,     42,         'method from other role was OK too';


{
    role Answer { has $.answer is rw }
    my $x = 0 but Answer(42);
    is $x.answer,   42,         'role mix-in with initialization value worked';
    is $x,          0,          'mixing into Int still makes it function as an Int';
}


{
    my $x = C1.new();
    role A { has $.a is rw }
    role B { has $.b is rw }
    $x does A(1);
    $x does B(2);
    is $x.a,        1,          'mixining in two roles one after the other';
    is $x.b,        2,          'mixining in two roles one after the other';
}

#?niecza skip 'Trait does not available on variables'
{
    my @array does R1;
    is @array.test, 42,         'mixing in a role at the point of declaration works';

    my $x;
    BEGIN { $x = @array.test }
    is $x, 42,              'mixing in at point of declaration at compile time';
}

# L<S14/Run-time Mixins/"but only if the role supplies exactly one attribute">

{
    role R4a {
        # no attribute here
    }
    role R4b {
        has $.x is rw;
    }
    role R4c {
        has $.x;
        has $.y;
    }

    dies-ok { my $x = {}; $x does R4a(3) },
            '"does role(param)" does not work without attribute';
    lives-ok { my $x = {}; $x does R4b(3) },
            '"does role(param)" does work with one attribute';
    dies-ok { my $x = {}; $x does R4c(3) },
            '"does role(param)" does not work with two attributes';
    is ([] does R4b("foo")).x, 'foo',
       'can mix R4b into an Array, and access the attribute';
}

# RT #69654
#?niecza skip 'Unable to resolve method methods in class ClassHOW'
{
    role ProvidesFoo { method foo { } }
    class NoFoo { };
    is (NoFoo.new does ProvidesFoo).^methods(:local)>>.name, 'foo',
        'mixin with "does" lists method during introspection';
}

# RT #99986
{
    lives-ok { 3/2 but role { } }, 'can mix into a Rat';
}

# RT #77184
{
    throws-like { EVAL q[{ role A { my $!foo; }; role B { my $!foo; }; class C does A does B {} }] },
       X::Syntax::Variable::Twigil, twigil => '!', scope => 'my',
       'RT #77184'
}

# RT #100782
{
    my $a = 0 but True;
    is +$a, 0, 'RT #100782 1/2';
    #?rakudo.jvm todo 'RT #100782'
    is ?$a, Bool::True, 'RT #100782 2/2';
}

# RT #115390
{
    my $rt115390 = 0;
    for 1..1000 -> $i {
        $rt115390 += $i.perl;
        my $error = (my $val = (^10).pick(3).min but !$rt115390);
        1
    }
    is $rt115390, 500500,
        'no crash with mixin in loop when it is not the last statement in loop';
}

# RT #79866
{
    my $x = 42 but role { method CALL-ME($arg) { self * $arg[0] } };
    is $x(13), 546, 'can mix a &.() method into an Int';
}

# RT #79868
is (class { } but role { method answer() { 42 } }).answer, 42,
    'can mix a role into a type object';

# RT #101022
lives-ok {(True but role {}).gist}, 'can mix into True';

# RT #73990
#?niecza skip "Can only provide exactly one initial value to a mixin"
{
    my $tracker = '';
    for 1..3 {
        $tracker ~= 'before';
        1 but last;
        $tracker ~= 'after';
    }
    is $tracker, 'before', '"1 but last" does the same as "last"';

    sub f() { role { method answer { 42 } } };
    is (1 but f).answer, 42, '<literal> but <zero-arg call> works';

}

# RT #119371
{
    use experimental :macros;
    throws-like q[role popo { macro marco { $^a but popo }; marco popo; }],
        X::Role::Parametric::NoSuchCandidate,
        role    => { .^name eq 'popo' }
        ;
}

# RT #114668
{
    my role B { method Str() { 'bar' } }
    ok ({ a => 42 } but B) ~~ B, 'Mix-in to item hash works (1)';
    is ({ a => 42 } but B).Str, 'bar', 'Mix-in to item hash works (2)'
}

# RT #122756
{
    my role B { }
    ok ([] but B) ~~ B, 'Mix-in to item array works';
}

# RT #124121
{
    my $x;
    lives-ok { $x = True but [1, 2] }, 'but with array literal on RHS works';
    is $x.Array, [1, 2], 'but with array literal provides a .Array method';
}
{
    my $x;
    lives-ok { $x = True but (1, 2).list }, 'but with (1, 2).list on RHS works';
    is $x.List, (1, 2).list, 'but with (1, 2).list provides a .List method';
}
{
    my $x;
    lives-ok { $x = True but (1, "x") }, 'but with (1, "2") on RHS works';
    is $x.Int, 1, 'but with (1, "x") provides a .Int method returning 1';
    #?rakudo.jvm todo "got '1' instead of 'x'"
    is $x.Str, "x", 'but with (1, "x") provides a .Str method returning "x"';
}
throws-like 'True but (1, 1)', Exception, gist => { $^g ~~ /'Int'/ && $g ~~ /resolved/ },
    'True but (1, 1) gets Int conflict to resolve due to generating two Int methods';

# RT #119925
{
    is (gather {} but role {})[0], Nil,
        'mixing roles into lazy lists does not fail (1)';
    is ((^Inf) but role {})[2], 2,
        'mixing roles into lazy lists does not fail (2)';
}

# RT #122030
{
    ok (Any but role { }) !=== (Any but role { }), 'anonymous roles are distinct';
}

# RT #127660
{
    my $m = Any but role { method Bool { True } }
    is $m || 42, $m, 'method Bool in mixin is used';
    my $sm = Any but role { submethod Bool { True } }
    is $sm || 42, $sm, 'submethod Bool in mixin is used';
}

# vim: syn=perl6
