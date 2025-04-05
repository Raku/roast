use Test;
plan 54;

my $pod_index = 0;

#?DOES 1
sub test-trailing($thing, $value) is test-assertion {
    subtest $thing.^name => {
        plan 8;
        #?rakudo todo 'https://github.com/rakudo/rakudo/issues/4866'
        is $=pod[$pod_index].?WHEREFORE.^name, $thing.^name, ' - $=pod $value WHEREFORE (pre WHY)';
        is $thing.WHY.?contents, $value, $value  ~ ' - contents';
        is $thing.WHY.?WHEREFORE.^name, $thing.^name, $value ~ ' - WHEREFORE';
        is $thing.WHY.?trailing, $value, $value ~ ' - trailing';
        ok !$thing.WHY.?leading.defined, $value ~ ' - no leading';
        is ~$thing.WHY, $value, $value ~ ' - stringifies correctly';

        is $=pod[$pod_index].?WHEREFORE.^name, $thing.^name, "\$=pod $value - WHEREFORE";
        is ~$=pod[$pod_index], $value, "\$=pod $value";
        $pod_index++;
    }
}

class Simple {
#= simple case
}

test-trailing(Simple, "simple case");

class MultiLine { }
#= multi
#= line

test-trailing(MultiLine, "multi line");

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
    has $.sound is rw = "baa"; #= usually quiet

    method roar { 'roar!' }
    #= not too scary
}

{
    my $wool-attr   = Sheep.^attributes.first: *.name eq '$!wool';
    my $sound-attr  = Sheep.^attributes.first: *.name eq '$!sound';
    my $roar-method = Sheep.^lookup('roar');
    test-trailing(Sheep, 'a sheep');
    test-trailing($wool-attr, 'usually white');
    test-trailing($sound-attr, 'usually quiet');
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
    Str $foo, #= second param
    Int $other-param
) {}

{
    my @params = &so-many-params.signature.params;
    test-trailing(@params[0], 'first param');
    test-trailing(@params[1], 'second param');
    ok !@params[2].WHY.defined, 'the third parameter has no comments'
        or diag(@params[2].WHY.contents);
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
    my @params = DoesntMatter.^lookup('m').signature.params;
    test-trailing(@params[0], 'invocant comment');
}

role Boxer {
#= Are you talking to me?
    method actor { }
    #= Robert De Niro
}

{
    my $method = Boxer.^lookup('actor');
    test-trailing(Boxer.HOW.candidates(Boxer)[0], 'Are you talking to me?');
    test-trailing($method, 'Robert De Niro');
}

class C {
    submethod BUILD
    #= Bob
    { }

    proto method meth
    #= Takes a single argument
    ($) {}

    multi method meth
    #= Single Int argument
    (Int $int-arg) {}

    multi method meth
    #= Single Str argument
    (Str $str-arg) {}
}

{
    my $submethod = C.^lookup("BUILD");
    test-trailing($submethod, 'Bob');

    my $meth = C.^lookup('meth');

    test-trailing($meth, 'Takes a single argument');
    test-trailing($meth.candidates[0], 'Single Int argument');
    test-trailing($meth.candidates[1], 'Single Str argument');
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
    my $rule = G.^lookup("R");
    my $token = G.^lookup("T");
    my $regex = G.^lookup("X");
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

skip 'declaration comments are NYI on constants', 1;
#`(
constant $pi = 3.14159;
#= A cool constant

test-trailing($pi.VAR, 'A cool constant');
)

skip 'declaration comments are NYI on variables', 1;
#`(
our $fancy-var = 17;
#= Very fancy!

test-trailing($fancy-var.VAR, 'Very fancy!');
)

# https://github.com/Raku/old-issue-tracker/issues/4266
sub has-where
#= where constraints shouldn't prevent declarative comments
(Int $n where * > 10) {}

test-trailing(&has-where, "where constraints shouldn't prevent declarative comments");

my $block = {;
#= this is a block
};

test-trailing($block, 'this is a block');

is $=pod.elems, $pod_index;

# vim: expandtab shiftwidth=4
