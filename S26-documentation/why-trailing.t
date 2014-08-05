use Test;
plan 157;

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

is $=pod.elems, $pod_index;
