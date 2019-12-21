use v6;
use Test;
plan 356;

my $pod_index = 0;

# Test that we get the values we expect from WHY.contents, WHY.leading,
# WHY.trailing, and that WHY.WHEREFORE is the appropriate thing
# Also checks the $=pod object is set appropriately.
# XXX we need to be able to affect the test level (like Test::Builder::Level
#     in Perl) so that failures point at the caller
sub test-leading($thing, $value) {
    is $thing.WHY.?contents, $value, $value  ~ ' - contents';
    is $thing.WHY.?WHEREFORE.^name, $thing.^name, $value ~ ' - WHEREFORE';
    is $thing.WHY.?leading, $value, $value ~ ' - leading';
    ok !$thing.WHY.?trailing.defined, $value ~ ' - no trailing';
    is ~$thing.WHY, $value, $value ~ ' - stringifies correctly';

    is $=pod[$pod_index].?WHEREFORE.^name, $thing.^name, "\$=pod $value - WHEREFORE";
    is ~$=pod[$pod_index], $value, "\$=pod $value";
    $pod_index++;
}


#| simple case
class Simple { }

test-leading(Simple, "simple case");

#| multi
#| line
class MultiLine { }

test-leading(MultiLine, "multi line");

#| giraffe
class Outer {
    #| zebra
    class Inner {
    }
}

test-leading(Outer, 'giraffe');
test-leading(Outer::Inner, 'zebra');

#| a module
module foo {
    #| a package
    package bar {
        #| and a class
        class baz {
        }
    }
}

test-leading(foo, 'a module');
test-leading(foo::bar, 'a package');
test-leading(foo::bar::baz, 'and a class');

#| yellow
sub marine {}

test-leading(&marine, 'yellow');

#| pink
sub panther {}

test-leading(&panther, 'pink');

#| a sheep
class Sheep {
    #| usually white
    has $.wool;

    #| not too scary
    method roar { 'roar!' }
}

my $wool-attr = Sheep.^attributes.grep({ .name eq '$!wool' })[0];
my $roar-method = Sheep.^lookup('roar');

test-leading(Sheep,'a sheep');
test-leading($wool-attr, 'usually white');
test-leading($roar-method, 'not too scary');

sub routine {}
is &routine.WHY.defined, False;

#| our works too
our sub oursub {}

test-leading(&oursub, 'our works too');

# two subs in a row

#| one
sub one {}

#| two
sub two {}

test-leading(&one, 'one');
test-leading(&two, 'two');


#| that will break
sub first {}

#| that will break
sub second {}

test-leading(&first, "that will break");
test-leading(&second, "that will break");

#| trailing space here
sub third {}

test-leading(&third, "trailing space here");

sub has-parameter(
    #| documented
    Str $param
) {}

{
    my @params = &has-parameter.signature.params;
    test-leading(@params[0], 'documented');
}

sub has-two-params(
    #| documented
    Str $param,
    Int $second
) {}

{
    my @params = &has-two-params.signature.params;
    test-leading(@params[0], 'documented');
    ok !@params[1].WHY.defined, 'Second param should not be documented' or
        diag(@params[1].WHY.contents);
}

sub both-documented(
    #| documented
    Str $param,
    #| I too, am documented
    Int $second
) {}

{
    my @params = &both-documented.signature.params;
    test-leading(@params[0], 'documented');
    test-leading(@params[1], 'I too, am documented');
}

sub has-anon-param(
    #| leading
    Str $
) {}

{
    my @params = &has-anon-param.signature.params;
    test-leading(@params[0], 'leading');
}

class DoesntMatter {
    method m(
        #| invocant comment
        ::?CLASS $this:
        $arg
    ) {}
}

{
    my @params = DoesntMatter.^lookup('m').signature.params;
    test-leading(@params[0], 'invocant comment');
}

#| Are you talking to me?
role Boxer {
    #| Robert De Niro
    method actor { }
}

{
    my $method = Boxer.^lookup('actor');
    ok !Boxer.WHY.defined, q{Role group's WHY should not be defined};
    test-leading(Boxer.HOW.candidates(Boxer)[0], 'Are you talking to me?');
    test-leading($method, 'Robert De Niro');
}

class C {
    #| Bob
    submethod BUILD { }

    #| Takes a single argument
    proto method meth($) {}

    #| Single Int argument
    multi method meth(Int $int-arg) {}

    #| Single Str argument
    multi method meth(Str $str-arg) {}
}

{
    my $submethod = C.^lookup("BUILD");
    test-leading($submethod, 'Bob');

    my $meth = C.^lookup('meth');

    test-leading($meth, 'Takes a single argument');
    test-leading($meth.candidates[0], 'Single Int argument');
    test-leading($meth.candidates[1], 'Single Str argument');
}

#| grammar
grammar G {
    #| rule
    rule R { <?> }
    #| token
    token T { <?> }
    #| regex
    regex X { <?> }
}

{
    my $rule = G.^lookup("R");
    my $token = G.^lookup("T");
    my $regex = G.^lookup("X");
    test-leading(G, 'grammar');
    test-leading($rule, 'rule');
    test-leading($token, 'token');
    test-leading($regex, 'regex');
}

#| solo
proto sub foo() { }

test-leading(&foo, 'solo');

#| no proto
multi sub bar() { }

ok !&bar.WHY.defined;
test-leading(&bar.candidates[0], 'no proto');

#| variant A
multi sub baz() { }
#| variant B
multi sub baz(Int) { }

{
    my @candidates = &baz.candidates;
    test-leading(@candidates[0], 'variant A');
    test-leading(@candidates[1], 'variant B');
}

#| proto
proto sub greeble {*}
#| alpha
multi sub greeble(Int) { }
#| beta
multi sub greeble(Str) { }

{
    my @candidates = &greeble.candidates;
    test-leading(&greeble, 'proto');
    test-leading(@candidates[0], 'alpha');
    test-leading(@candidates[1], 'beta');
}

use experimental :macros;
#| I like numbers
macro four { quasi { 2+2 } }

test-leading(&four, 'I like numbers');

#| Roy
only the-lonely {}

test-leading(&the-lonely, 'Roy');

#| Anonymous
my $anon-sub = anon Str sub {};

test-leading($anon-sub, 'Anonymous');

#| Enumeration
enum Colors < Red Green Blue >;

test-leading(Colors, 'Enumeration');

#| Even
subset EvenNum of Num where { $^n % 2 == 0 }

test-leading(EvenNum, 'Even');

skip 'declaration comments are NYI on constants', 7;
#`(
#| A cool constant
constant $pi = 3.14159;

test-leading($pi.VAR, 'A cool constant');
)

skip 'declaration comments are NYI on variables', 7;
#`(
#| Very fancy!
our $fancy-var = 17;

test-leading($fancy-var.VAR, 'Very fancy!');
)

#| where constraints shouldn't prevent declarative comments
sub has-where(Int $n where * > 10) {}

test-leading(&has-where, "where constraints shouldn't prevent declarative comments");

#| this is a block
my $block = {;
};

test-leading($block, 'this is a block');
is $=pod.elems, $pod_index;

# R#3242
lives-ok { "#| foo\n#|\n#| bar".EVAL }, 'can we have an empty #|';
