use Test;
plan 298;

my $pod_index = 0;

sub test-trailing($thing, $value) {
    is $thing.WHY.?contents, $value, $value  ~ ' - contents';
    ok $thing.WHY.?WHEREFORE === $thing, $value ~ ' - WHEREFORE';
    is $thing.WHY.?trailing, $value, $value ~ ' - trailing';
    ok !$thing.WHY.?leading.defined, $value ~ ' - no leading';
    is ~$thing.WHY, $value, $value ~ ' - stringifies correctly';

    ok $=pod[$pod_index].?WHEREFORE === $thing, "\$=pod $value - WHEREFORE";
    is ~$=pod[$pod_index], $value, "\$=pod $value";
    $pod_index++;
}

class Simple {
#= simple case
}

test-trailing(Simple, "simple case");

class Outer {
#= giraffe
    class Inner {
    #= zebra
    }
}

test-trailing(Outer, 'giraffe');
test-trailing(Outer::Inner, 'zebra');

module foo {
#= a module
    package bar {
    #= a package
        class baz {
        #= and a class
        }
    }
}

test-trailing(foo, 'a module');
test-trailing(foo::bar, 'a package');
test-trailing(foo::bar::baz, 'and a class');

sub marine {} #= yellow

test-trailing(&marine, 'yellow');

sub panther {}
#= pink

test-trailing(&panther, 'pink');

class Sheep {
#= a sheep
    has $.wool; #= usually white

    method roar { 'roar!' }
    #= not too scary
}

{
    my $wool-attr = Sheep.^attributes.grep({ .name eq '$!wool' })[0];
    my $roar-method = Sheep.^find_method('roar');
    test-trailing(Sheep, 'a sheep');
    test-trailing($wool-attr, 'usually white');
    test-trailing($roar-method, 'not too scary');
}

sub routine {}
is &routine.WHY.defined, False, 'lack of sub comment';

our sub oursub {}
#= our works too

test-trailing(&oursub, 'our works too');

# two subs in a row

sub one {}
#= one

sub two {}
#= two

test-trailing(&one, 'one');
test-trailing(&two, 'two');

sub first {}
#= that will break

sub second {}
#= that will break

test-trailing(&first, 'that will break');
test-trailing(&second, 'that will break');

sub third {}
#=      leading space here

test-trailing(&third, 'leading space here');

sub has-parameter(
    Str $param
    #= documented
) {}

{
    my @params = &has-parameter.signature.params;
    test-trailing(@params[0], 'documented');
}

sub has-parameter-as-well(
    Str $param #= documented as well
) {}

{
    my @params = &has-parameter-as-well.signature.params;
    test-trailing(@params[0], 'documented as well');
}

sub so-many-params(
    Str $param, #= first param
    Int $other-param
) {}

{
    my @params = &so-many-params.signature.params;
    test-trailing(@params[0], 'first param');
    ok !@params[1].WHY.defined, 'the second parameter has no comments' 
        or diag(@params[1].WHY.contents);
}


sub has-anon-param(
    Str $
    #= trailing
) {}

{
    my @params = &has-anon-param.signature.params;
    test-trailing(@params[0], 'trailing');
}


class DoesntMatter {
    method m(
        ::?CLASS $this:
        #= invocant comment
        $arg
    ) {}
}

{
    my @params = DoesntMatter.^find_method('m').signature.params;
    test-trailing(@params[0], 'invocant comment');
}

role Boxer {
#= Are you talking to me?
    method actor { }
    #= Robert De Niro
}

{
    my $method = Boxer.^find_method('actor');
    test-trailing(Boxer, 'Are you talking to me?');
    test-trailing($method, 'Robert De Niro');
}

class C {
    submethod BUILD { }
    #= Bob
}

{
    my $submethod = C.^find_method("BUILD");
    test-trailing($submethod, 'Bob');
}

grammar G {
#= grammar
    rule R { <?> }
    #= rule
    token T { <?> }
    #= token
    regex X { <?> }
    #= regex
}

{
    my $rule = G.^find_method("R");
    my $token = G.^find_method("T");
    my $regex = G.^find_method("X");
    test-trailing(G, 'grammar');
    test-trailing($rule, 'rule');
    test-trailing($token, 'token');
    test-trailing($regex, 'regex');
}

proto sub foo() { }
#= solo

test-trailing(&foo, 'solo');

multi sub bar() { }
#= no proto

ok !&bar.WHY.defined;
test-trailing(&bar.candidates[0], 'no proto');

multi sub baz() { }
#= variant A
multi sub baz(Int) { }
#= variant B

{
    my @candidates = &baz.candidates;
    test-trailing(@candidates[0], 'variant A');
    test-trailing(@candidates[1], 'variant B');
}

proto sub greeble {*}
#= proto
multi sub greeble(Int) { }
#= alpha
multi sub greeble(Str) { }
#= beta

{
    my @candidates = &greeble.candidates;
    test-trailing(&greeble, 'proto');
    test-trailing(@candidates[0], 'alpha');
    test-trailing(@candidates[1], 'beta');
}

macro four { quasi { 2+2 } }
#= I like numbers

test-trailing(&four, 'I like numbers');

only the-lonely {}
#= Orbison

test-trailing(&the-lonely, 'Orbison');

my $anon-sub = anon Str sub {};
#= Anonymous

test-trailing($anon-sub, 'Anonymous');

enum Colors < Red Green Blue >;
#= Enumeration

test-trailing(Colors, 'Enumeration');

subset EvenNum of Num where { $^n % 2 == 0 };
#= Even

test-trailing(EvenNum, 'Even');

skip 'declaration comments are NYI on constants', 7;
#`(
constant $pi = 3.14159;
#= A cool constant

test-trailing($pi.VAR, 'A cool constant');
)

is $=pod.elems, $pod_index;
