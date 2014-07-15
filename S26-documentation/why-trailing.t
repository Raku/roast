use Test;
plan 22;

class Simple {
#= simple case
}

is Simple.WHY.content, 'simple case', 'Class comment';
is ~Simple.WHY, 'simple case', 'stringifies correctly';

class Outer {
#= giraffe
    class Inner {
    #= zebra
    }
}

is Outer.WHY.content, 'giraffe', 'Outer class comment';
is Outer::Inner.WHY.content, 'zebra', 'Inner class comment';

module foo {
#= a module
    package bar {
    #= a package
        class baz {
        #= and a class
        }
    }
}

is foo.WHY.content,           'a module', 'module comment';
is foo::bar.WHY.content,      'a package', 'package comment';
is foo::bar::baz.WHY.content, 'and a class', 'module > package > class comment';

sub marine {} #= yellow
is &marine.WHY.content, 'yellow', 'sub comment';

sub panther {}
#= pink
is &panther.WHY.content, 'pink', 'sub comment (the remix!)';

class Sheep {
#= a sheep
    has $.wool; #= usually white

    method roar { 'roar!' }
    #= not too scary
}

is Sheep.WHY.content, 'a sheep', 'class comment (again)';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, 'usually white', 'attribute comment';
is Sheep.^find_method('roar').WHY.content, 'not too scary', 'method comment';

sub routine {}
is &routine.WHY.defined, False, 'lack of sub comment';

our sub oursub {}
#= our works too
is &oursub.WHY, 'our works too', 'works for our subs';

# two subs in a row

sub one {}
#= one

sub two {}
#= two
is &one.WHY.content, 'one', 'another sub comment';
is &two.WHY.content, 'two', 'yet another sub comment';

sub first {}
#= that will break

sub second {}
#= that will break

is &first.WHY.content, 'that will break', 'even more sub comments!';
is &second.WHY.content, 'that will break', 'when will the sub comments end?!';

sub third {}
#=      leading space here
is &third.WHY.content, 'leading space here', 'sub comment - leading space';

sub has-parameter(
    Str $param
    #= documented
) {}

is &has-parameter.signature.params[0].WHY, 'documented', 'parameter comment';

sub has-parameter-as-well(
    Str $param #= documented as well
) {}

is &has-parameter-as-well.signature.params[0].WHY, 'documented as well', 'parameter comment - same line';

sub so-many-params(
    Str $param, #= first param
    Int $other-param
) {}

is &so-many-params.signature.params[0].WHY, 'first param', 'parameter comment - same line, but after comma';
