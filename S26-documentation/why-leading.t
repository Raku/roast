use Test;
plan 56;

#| simple case
class Simple {
}

is Simple.WHY.content, 'simple case';
is Simple.WHY.leading, 'simple case';
ok !Simple.WHY.trailing.defined;
is ~Simple.WHY, 'simple case', 'stringifies correctly';

#| giraffe
class Outer {
    #| zebra
    class Inner {
    }
}

is Outer.WHY.content, 'giraffe';
is Outer.WHY.leading, 'giraffe';
ok !Outer.WHY.trailing.defined;
is Outer::Inner.WHY.content, 'zebra';
is Outer::Inner.WHY.leading, 'zebra';
ok !Outer::Inner.WHY.trailing.defined;

#| a module
module foo {
    #| a package
    package bar {
        #| and a class
        class baz {
        }
    }
}

is foo.WHY.content,           'a module';
is foo.WHY.leading,           'a module';
ok !foo.WHY.trailing.defined;
is foo::bar.WHY.content,      'a package';
is foo::bar.WHY.leading,      'a package';
ok !foo::bar.WHY.trailing.defined;
is foo::bar::baz.WHY.content, 'and a class';
is foo::bar::baz.WHY.leading, 'and a class';
ok !foo::bar::baz.WHY.trailing.defined;

#| yellow
sub marine {}
is &marine.WHY.content, 'yellow';
is &marine.WHY.leading, 'yellow';
ok !&marine.WHY.trailing.defined;

#| pink
sub panther {}
is &panther.WHY.content, 'pink';
is &panther.WHY.leading, 'pink';
ok !&panther.WHY.trailing.defined;

#| a sheep
class Sheep {
    #| usually white
    has $.wool;

    #| not too scary
    method roar { 'roar!' }
}

is Sheep.WHY.content, 'a sheep';
is Sheep.WHY.leading, 'a sheep';
ok !Sheep.WHY.trailing.defined;
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, 'usually white';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.leading, 'usually white';
ok !Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.trailing.defined;
is Sheep.^find_method('roar').WHY.content, 'not too scary';
is Sheep.^find_method('roar').WHY.leading, 'not too scary';
ok !Sheep.^find_method('roar').WHY.trailing.defined;

sub routine {}
is &routine.WHY.defined, False;

#| our works too
our sub oursub {}
is &oursub.WHY, 'our works too', 'works for our subs';
is &oursub.WHY.leading, 'our works too', 'works for our subs';
ok !&oursub.WHY.trailing.defined;

# two subs in a row

#| one
sub one {}

#| two
sub two {}
is &one.WHY.content, 'one';
is &one.WHY.leading, 'one';
ok !&one.WHY.trailing.defined;
is &two.WHY.content, 'two';
is &two.WHY.leading, 'two';
ok !&two.WHY.trailing.defined;

#| that will break
sub first {}

#| that will break
sub second {}

is &first.WHY.content, 'that will break';
is &first.WHY.leading, 'that will break';
ok !&first.WHY.trailing.defined;
is &second.WHY.content, 'that will break';
is &second.WHY.leading, 'that will break';
ok !&second.WHY.trailing.defined;

#| trailing space here  
sub third {}
is &third.WHY.content, 'trailing space here';
is &third.WHY.leading, 'trailing space here';
ok !&third.WHY.trailing.defined;

sub has-parameter(
    #| documented
    Str $param
) {}

is &has-parameter.signature.params[0].WHY, 'documented';
is &has-parameter.signature.params[0].WHY.leading, 'documented';
ok !&has-parameter.signature.params[0].WHY.trailing.defined;
