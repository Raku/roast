use Test;
plan 277;

my $pod_index = 0;

sub test-both($thing, $leading, $trailing) {
    my $combined = "$leading\n$trailing";
    my $name     = "$leading\\n$trailing";

    is $thing.WHY.?contents, $combined, $name  ~ ' - contents';
    ok $thing.WHY.?WHEREFORE === $thing, $name ~ ' - WHEREFORE';
    is $thing.WHY.?leading, $leading, $name ~ ' - trailing';
    is $thing.WHY.?trailing, $trailing, $name ~ ' - trailing';
    is ~$thing.WHY, $combined, $name ~ ' - stringifies correctly';

    ok $=pod[$pod_index].?WHEREFORE === $thing, "\$=pod $name - WHEREFORE";
    is ~$=pod[$pod_index], $combined, "\$=pod $name";
    $pod_index++;
}

#| simple case
class Simple {
#= not so simple now!
}

test-both(Simple, 'simple case', 'not so simple now!');

#| a module
module foo {
#= moar module stuff
    #| a package
    package bar {
    #= more package stuff
        #| and a class
        class baz {
        #= more class stuff
        }
    }
}

test-both(foo, 'a module', 'moar module stuff');
test-both(foo::bar, 'a package', 'more package stuff');
test-both(foo::bar::baz, 'and a class', 'more class stuff');

#| yellow
sub marine {}
#= submarine

test-both(&marine, 'yellow', 'submarine');

#| pink
sub panther {} #= panther

test-both(&panther, 'pink', 'panther');

#| a sheep
class Sheep {
#= or is it?
    #| usually white
    has $.wool; #= not very dirty

    #| not too scary
    method roar { 'roar!' } #= ...unless you fear sheep!
}

test-both(Sheep, 'a sheep', 'or is it?');

my $wool-attr = Sheep.^attributes.grep({ .name eq '$!wool' })[0];

test-both($wool-attr, 'usually white', 'not very dirty');

my $roar-method = Sheep.^find_method('roar');

test-both($roar-method, 'not too scary', '...unless you fear sheep!');

#| trailing space here  
sub third {}
#=    leading space here

test-both(&third, 'trailing space here', 'leading space here');

sub has-parameter(
    #| before
    Str $param
    #= after
) {}

my $param = &has-parameter.signature.params[0];

test-both($param, 'before', 'after');

sub has-parameter-as-well(
    #| preceding
    Str $param #= following
) {}

$param = &has-parameter-as-well.signature.params[0];

test-both($param, 'preceding', 'following');

sub so-many-params(
    #| next param
    Str $param, #= first param
    Int $other-param
) {}

$param = &so-many-params.signature.params[0];
test-both($param, 'next param', 'first param');

$param = &so-many-params.signature.params[1];
ok !$param.WHY.defined, 'the second parameter has no comments' or diag($param.WHY.contents);

sub has-anon-param(
    #| leading
    Str $
    #= trailing
) {}

$param = &has-anon-param.signature.params[0];

test-both($param, 'leading', 'trailing');

class DoesntMatter {
    method m(
        #| invocant comment
        ::?CLASS $this:
        #= another invocant comment
        $arg
    ) {}
}

$param = DoesntMatter.^find_method('m').signature.params[0];
test-both($param, 'invocant comment', 'another invocant comment');

#| Are you talking to me?
role Boxer {
#= I said, are you talking to me?
    #| Robert De Niro
    method actor { }
    #= he's an actor
}

{
    my $method = Boxer.^find_method('actor');
    ok !Boxer.WHY.defined, q{Role group's WHY should not be defined};
    test-both(Boxer.HOW.candidates(Boxer)[0], 'Are you talking to me?', 'I said, are you talking to me?');
    test-both($method, 'Robert De Niro', q{he's an actor});
}

class C {
    #| Bob
    submethod BUILD { }
    #= Frank

    #| Takes a
    proto method meth($) {}
    #= single argument

    #| Single Int
    multi method meth(Int $int-arg) {}
    #= argument

    #| Single
    multi method meth(Str $str-arg) {}
    #= Str argument
}

{
    my $submethod = C.^find_method("BUILD");
    test-both($submethod, 'Bob', 'Frank');

    my $meth = C.^find_method('meth');

    test-both($meth, 'Takes a', 'single argument');
    test-both($meth.candidates[0], 'Single Int', 'argument');
    test-both($meth.candidates[1], 'Single', 'Str argument');
}

#| grammar
grammar G {
#= more grammar
    #| rule
    rule R { <?> }
    #= reading

    #| token
    token T { <?> }
    #= writing

    #| regex
    regex X { <?> }
    #= arithmetic
}

{
    my $rule = G.^find_method("R");
    my $token = G.^find_method("T");
    my $regex = G.^find_method("X");
    test-both(G, 'grammar', 'more grammar');
    test-both($rule, 'rule', 'reading');
    test-both($token, 'token', 'writing');
    test-both($regex, 'regex', 'arithmetic');
}

#| solo
proto sub foo() { }
#= mio

test-both(&foo, 'solo', 'mio');

#| no proto
multi sub bar() { }
#= pro bono

ok !&bar.WHY.defined;
test-both(&bar.candidates[0], 'no proto', 'pro bono');

#| variant A
multi sub baz() { }
#= variation

#| variant B
multi sub baz(Int) { }
#= station

{
    my @candidates = &baz.candidates;
    test-both(@candidates[0], 'variant A', 'variation');
    test-both(@candidates[1], 'variant B', 'station');
}

#| proto
proto sub greeble {*}
#= type

#| alpha
multi sub greeble(Int) { }
#= centauri

#| beta
multi sub greeble(Str) { }
#= male

{
    my @candidates = &greeble.candidates;
    test-both(&greeble, 'proto', 'type');
    test-both(@candidates[0], 'alpha', 'centauri');
    test-both(@candidates[1], 'beta', 'male');
}

#| I like
macro four { quasi { 2+2 } }
#= numbers

test-both(&four, 'I like', 'numbers');

#| Roy
only the-lonely {}
#= Orbison

test-both(&the-lonely, 'Roy', 'Orbison');

#| Anonymous
my $anon-sub = anon Str sub {};
#= Sub

test-both($anon-sub, 'Anonymous', 'Sub');

#| Enumer
enum Colors < Red Green Blue >;
#= ation

test-both(Colors, 'Enumer', 'ation');

#| Even
subset EvenNum of Num where { $^n % 2 == 0 };
#= Numbers

test-both(EvenNum, 'Even', 'Numbers');

skip 'declaration comments are NYI on constants', 7;
#`(
#| A cool
constant $pi = 3.14159;
#= constant

test-both($pi.VAR, 'A cool', 'constant');
)

skip 'declaration comments are NYI on variables', 7;
#`(
#| Very
our $fancy-var = 17;
#= fancy!

test-both($fancy-var.VAR, 'Very', 'fancy!');
)

is $=pod.elems, $pod_index;
