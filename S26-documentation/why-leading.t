use Test;
plan 79;

#| simple case
class Simple {
}

is Simple.WHY.content, 'simple case';
ok Simple.WHY.WHEREFORE === Simple, 'class WHEREFORE matches';
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
ok Outer.WHY.WHEREFORE === Outer, 'outer class WHEREFORE matches';
is Outer.WHY.leading, 'giraffe';
ok !Outer.WHY.trailing.defined;
is Outer::Inner.WHY.content, 'zebra';
ok Outer::Inner.WHY.WHEREFORE === Outer::Inner, 'inner class WHEREFORE matches';
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
ok foo.WHY.WHEREFORE === foo, 'module WHEREFORE matches';
is foo.WHY.leading,           'a module';
ok !foo.WHY.trailing.defined;
is foo::bar.WHY.content,      'a package';
ok foo::bar.WHY.WHEREFORE === foo::bar, 'inner package WHEREFORE matches';
is foo::bar.WHY.leading,      'a package';
ok !foo::bar.WHY.trailing.defined;
is foo::bar::baz.WHY.content, 'and a class';
ok foo::bar::baz.WHY.WHEREFORE === foo::bar::baz, 'inner inner class WHEREFORE matches';
is foo::bar::baz.WHY.leading, 'and a class';
ok !foo::bar::baz.WHY.trailing.defined;

#| yellow
sub marine {}
is &marine.WHY.content, 'yellow';
ok &marine.WHY.WHEREFORE === &marine, 'sub WHEREFORE matches';
is &marine.WHY.leading, 'yellow';
ok !&marine.WHY.trailing.defined;

#| pink
sub panther {}
is &panther.WHY.content, 'pink';
ok &panther.WHY.WHEREFORE === &panther, 'sub WHEREFORE matches';
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
ok Sheep.WHY.WHEREFORE === Sheep, 'class WHEREFORE matches';
is Sheep.WHY.leading, 'a sheep';
ok !Sheep.WHY.trailing.defined;
my $wool-attr = Sheep.^attributes.grep({ .name eq '$!wool' })[0];
ok $wool-attr.WHY.WHEREFORE === $wool-attr, 'attr WHEREFORE matches';
is $wool-attr.WHY, 'usually white';
is $wool-attr.WHY.leading, 'usually white';
ok !$wool-attr.WHY.trailing.defined;
my $roar-method = Sheep.^find_method('roar');
is $roar-method.WHY.content, 'not too scary';
ok $roar-method.WHY.WHEREFORE === $roar-method, 'method WHEREFORE matches';
is $roar-method.WHY.leading, 'not too scary';
ok !$roar-method.WHY.trailing.defined;

sub routine {}
is &routine.WHY.defined, False;

#| our works too
our sub oursub {}
is &oursub.WHY, 'our works too', 'works for our subs';
ok &oursub.WHY.WHEREFORE === &oursub, 'our sub WHEREFORE matches';
is &oursub.WHY.leading, 'our works too', 'works for our subs';
ok !&oursub.WHY.trailing.defined;

# two subs in a row

#| one
sub one {}

#| two
sub two {}
is &one.WHY.content, 'one';
ok &one.WHY.WHEREFORE === &one, 'sub WHEREFORE matches';
is &one.WHY.leading, 'one';
ok !&one.WHY.trailing.defined;
is &two.WHY.content, 'two';
ok &two.WHY.WHEREFORE === &two, 'sub WHEREFORE matches';
is &two.WHY.leading, 'two';
ok !&two.WHY.trailing.defined;

#| that will break
sub first {}

#| that will break
sub second {}

is &first.WHY.content, 'that will break';
ok &first.WHY.WHEREFORE === &first, 'sub WHEREFORE matches';
is &first.WHY.leading, 'that will break';
ok !&first.WHY.trailing.defined;
is &second.WHY.content, 'that will break';
ok &second.WHY.WHEREFORE === &second, 'sub WHEREFORE matches';
is &second.WHY.leading, 'that will break';
ok !&second.WHY.trailing.defined;

#| trailing space here  
sub third {}
is &third.WHY.content, 'trailing space here';
ok &third.WHY.WHEREFORE === &third, 'sub WHEREFORE matches';
is &third.WHY.leading, 'trailing space here';
ok !&third.WHY.trailing.defined;

sub has-parameter(
    #| documented
    Str $param
) {}

is &has-parameter.signature.params[0].WHY, 'documented';
ok &has-parameter.signature.params[0].WHY.WHEREFORE === &has-parameter.signature.params[0], 'param WHEREFORE matches';
is &has-parameter.signature.params[0].WHY.leading, 'documented';
ok !&has-parameter.signature.params[0].WHY.trailing.defined;

sub has-two-params(
    #| documented
    Str $param,
    Int $second
) {}

is &has-two-params.signature.params[0].WHY, 'documented';
ok &has-two-params.signature.params[0].WHY.WHEREFORE === &has-two-params.signature.params[0], 'param WHEREFORE matches';
is &has-two-params.signature.params[0].WHY.leading, 'documented';
ok !&has-two-params.signature.params[0].WHY.trailing.defined;
ok !&has-two-params.signature.params[1].WHY.defined or diag(&has-two-params.signature.params[1].WHY.content);
