use v6;
use Test;
plan 27;

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


#?rakudo skip 'sub form of mixins'
#?niecza skip 'Cannot compose a type of category class (Any)'
{
    role Answer { has $.answer is rw }
    my $x = 0;
    $x does Answer(42);
    is $x.answer,   42,         'role mix-in with initialization value worked';
    is $x,          0,          'mixing into Int still makes it function as an Int';
}

#?rakudo skip 'sub form of mixins'
#?niecza skip 'Cannot compose a type of category class (Any)'
{
    my $x = 0;
    role A { has $.a is rw }
    role B { has $.b is rw }
    $x does A(1);
    $x does B(2);
    is $x.a,        1,          'mixining in two roles one after the other';
    is $x.b,        2,          'mixining in two roles one after the other';
}


#?rakudo skip 'mixin at the point of declaration is compile time'
#?niecza skip 'Trait does not available on variables'
{
    my @array does R1;
    is @array.test, 42,         'mixing in a role at the point of declaration works';

    my $x;
    BEGIN { $x = @array.test }
    is $x, 42,              'mixing in at point of declaration at compile time';
}

# L<S14/Run-time Mixins/"but only if the role supplies exactly one attribute">

#?rakudo skip 'sub form of mixin'
#?niecza skip 'Cannot compose a type of category class (Any)'
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

    dies_ok { my $x = 4; $x does R4a(3) },
            '"does role(param)" does not work without attribute';
    lives_ok { my $x = 4; $x does R4b(3) },
            '"does role(param)" does work with one attribute';
    dies_ok { my $x = 4; $x does R4c(3) },
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
    lives_ok { 3/2 but role { } }, 'can mix into a Rat';
}

# RT #77184
#?niecza skip 'Twigil ! is only valid on attribute definitions'
{
    lives_ok { role A { my $!foo; }; role B { my $!foo; }; class C does A does B {} }, 'RT #77184'
}

# RT #100782
{
    my $a = 0 but True;
    is +$a, 0, 'RT #100782 1/2';
    is ?$a, Bool::True, 'RT #100782 2/2';
}

# vim: syn=perl6
