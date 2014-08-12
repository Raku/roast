use Test;
plan 106;

my $pod_index = 0;

sub test-both($thing, $leading, $trailing) {
    my $combined = "$leading\n$trailing";
    my $name     = "$leading\\n$trailing";

    is $thing.WHY.?contents, $combined, $name  ~ ' - contents';
    ok $thing.WHY.?WHEREFORE === $thing, $name ~ ' - WHEREFORE';
    is $thing.WHY.?leading, $leading, $name ~ ' - trailing';
    is $thing.WHY.?trailing, $trailing, $name ~ ' - trailing';
    is ~$thing.WHY, $combined, $name ~ ' - stringifies correctly';

    skip 'known to be b0rked', 2;
    #ok $=pod[$pod_index].?WHEREFORE === $thing, "\$=pod $name - WHEREFORE";
    #is ~$=pod[$pod_index], $combined, "\$=pod $name";
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
