use Test;
plan 62;

class Simple {
#= simple case
}

is Simple.WHY.content, 'simple case', 'Class comment';
is Simple.WHY.trailing, 'simple case', 'Class comment';
ok !Simple.WHY.leading.defined;
is ~Simple.WHY, 'simple case', 'stringifies correctly';

class Outer {
#= giraffe
    class Inner {
    #= zebra
    }
}

is Outer.WHY.content, 'giraffe', 'Outer class comment';
is Outer.WHY.trailing, 'giraffe', 'Outer class comment';
ok !Outer.WHY.leading.defined;
is Outer::Inner.WHY.content, 'zebra', 'Inner class comment';
is Outer::Inner.WHY.trailing, 'zebra', 'Inner class comment';
ok !Outer::Inner.WHY.leading.defined;

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
is foo.WHY.trailing,           'a module', 'module comment';
ok !foo.WHY.leading.defined;
is foo::bar.WHY.content,      'a package', 'package comment';
is foo::bar.WHY.trailing,      'a package', 'package comment';
ok !foo::bar.WHY.leading.defined;
is foo::bar::baz.WHY.content, 'and a class', 'module > package > class comment';
is foo::bar::baz.WHY.trailing, 'and a class', 'module > package > class comment';
ok !foo::bar::baz.WHY.leading.defined;

sub marine {} #= yellow
is &marine.WHY.content, 'yellow', 'sub comment';
is &marine.WHY.trailing, 'yellow', 'sub comment';
ok !&marine.WHY.leading.defined;

sub panther {}
#= pink
is &panther.WHY.content, 'pink', 'sub comment (the remix!)';
is &panther.WHY.trailing, 'pink', 'sub comment (the remix!)';
ok !&panther.WHY.leading.defined;

class Sheep {
#= a sheep
    has $.wool; #= usually white

    method roar { 'roar!' }
    #= not too scary
}

is Sheep.WHY.content, 'a sheep', 'class comment (again)';
is Sheep.WHY.trailing, 'a sheep', 'class comment (again)';
ok !Sheep.WHY.leading.defined;
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, 'usually white', 'attribute comment';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.trailing, 'usually white', 'attribute comment';
ok !Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.leading.defined;
is Sheep.^find_method('roar').WHY.content, 'not too scary', 'method comment';
is Sheep.^find_method('roar').WHY.trailing, 'not too scary', 'method comment';
ok !Sheep.^find_method('roar').WHY.leading.defined;

sub routine {}
is &routine.WHY.defined, False, 'lack of sub comment';

our sub oursub {}
#= our works too
is &oursub.WHY, 'our works too', 'works for our subs';
is &oursub.WHY.trailing, 'our works too', 'works for our subs';
ok !&oursub.WHY.leading.defined;

# two subs in a row

sub one {}
#= one

sub two {}
#= two
is &one.WHY.content, 'one', 'another sub comment';
is &one.WHY.trailing, 'one', 'another sub comment';
ok !&one.WHY.leading.defined;
is &two.WHY.content, 'two', 'yet another sub comment';
is &two.WHY.trailing, 'two', 'yet another sub comment';
ok !&two.WHY.leading.defined;

sub first {}
#= that will break

sub second {}
#= that will break

is &first.WHY.content, 'that will break', 'even more sub comments!';
is &first.WHY.trailing, 'that will break', 'even more sub comments!';
ok !&first.WHY.leading.defined;
is &second.WHY.content, 'that will break', 'when will the sub comments end?!';
is &second.WHY.trailing, 'that will break', 'when will the sub comments end?!';
ok !&second.WHY.leading.defined;

sub third {}
#=      leading space here
is &third.WHY.content, 'leading space here', 'sub comment - leading space';
is &third.WHY.trailing, 'leading space here', 'sub comment - leading space';
ok !&third.WHY.leading.defined;

sub has-parameter(
    Str $param
    #= documented
) {}

is &has-parameter.signature.params[0].WHY, 'documented', 'parameter comment';
is &has-parameter.signature.params[0].WHY.trailing, 'documented', 'parameter comment';
ok !&has-parameter.signature.params[0].WHY.leading.defined;

sub has-parameter-as-well(
    Str $param #= documented as well
) {}

is &has-parameter-as-well.signature.params[0].WHY, 'documented as well', 'parameter comment - same line';
is &has-parameter-as-well.signature.params[0].WHY.trailing, 'documented as well', 'parameter comment - same line';
ok !&has-parameter-as-well.signature.params[0].WHY.leading.defined;

sub so-many-params(
    Str $param, #= first param
    Int $other-param
) {}

is &so-many-params.signature.params[0].WHY, 'first param', 'parameter comment - same line, but after comma';
is &so-many-params.signature.params[0].WHY.trailing, 'first param', 'parameter comment - same line, but after comma';
ok !&so-many-params.signature.params[0].WHY.leading.defined;
