use Test;
plan 38;

#| simple case
class Simple {
}

is Simple.WHY.content, 'simple case';
is Simple.WHY.leading, 'simple case';
is ~Simple.WHY, 'simple case', 'stringifies correctly';

#| giraffe
class Outer {
    #| zebra
    class Inner {
    }
}

is Outer.WHY.content, 'giraffe';
is Outer.WHY.leading, 'giraffe';
is Outer::Inner.WHY.content, 'zebra';
is Outer::Inner.WHY.leading, 'zebra';

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
is foo::bar.WHY.content,      'a package';
is foo::bar.WHY.leading,      'a package';
is foo::bar::baz.WHY.content, 'and a class';
is foo::bar::baz.WHY.leading, 'and a class';

#| yellow
sub marine {}
is &marine.WHY.content, 'yellow';
is &marine.WHY.leading, 'yellow';

#| pink
sub panther {}
is &panther.WHY.content, 'pink';
is &panther.WHY.leading, 'pink';

#| a sheep
class Sheep {
    #| usually white
    has $.wool;

    #| not too scary
    method roar { 'roar!' }
}

is Sheep.WHY.content, 'a sheep';
is Sheep.WHY.leading, 'a sheep';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, 'usually white';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.leading, 'usually white';
is Sheep.^find_method('roar').WHY.content, 'not too scary';
is Sheep.^find_method('roar').WHY.leading, 'not too scary';

sub routine {}
is &routine.WHY.defined, False;

#| our works too
our sub oursub {}
is &oursub.WHY, 'our works too', 'works for our subs';
is &oursub.WHY.leading, 'our works too', 'works for our subs';

# two subs in a row

#| one
sub one {}

#| two
sub two {}
is &one.WHY.content, 'one';
is &one.WHY.leading, 'one';
is &two.WHY.content, 'two';
is &two.WHY.leading, 'two';

#| that will break
sub first {}

#| that will break
sub second {}

is &first.WHY.content, 'that will break';
is &first.WHY.leading, 'that will break';
is &second.WHY.content, 'that will break';
is &second.WHY.leading, 'that will break';

#| trailing space here  
sub third {}
is &third.WHY.content, 'trailing space here';
is &third.WHY.leading, 'trailing space here';

sub has-parameter(
    #| documented
    Str $param
) {}

is &has-parameter.signature.params[0].WHY, 'documented';
is &has-parameter.signature.params[0].WHY.leading, 'documented';
