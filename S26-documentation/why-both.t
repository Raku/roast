use Test;
plan 14;

#| simple case
class Simple {
#= not so simple now!
}

is Simple.WHY.content, "simple case\nnot so simple now!";
is ~Simple.WHY, "simple case\nnot so simple now!", 'stringifies correctly';

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

is foo.WHY.content,           "a module\nmoar module stuff";
is foo::bar.WHY.content,      "a package\nmore package stuff";
is foo::bar::baz.WHY.content, "and a class\nmore class stuff";

#| yellow
sub marine {}
#= submarine
is &marine.WHY.content, "yellow\nsubmarine";

#| pink
sub panther {} #= panther
is &panther.WHY.content, "pink\npanther";

#| a sheep
class Sheep {
    #| usually white
    has $.wool;

    #| not too scary
    method roar { 'roar!' }
}

is Sheep.WHY.content, 'a sheep';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, 'usually white';
is Sheep.^find_method('roar').WHY.content, 'not too scary';

#| trailing space here  
sub third {}
#=    leading space here
is &third.WHY.content, "trailing space here\nleading space here";

sub has-parameter(
    #| before
    Str $param
    #= after
) {}

is &has-parameter.signature.params[0].WHY, "before\nafter";

sub has-parameter-as-well(
    #| preceding
    Str $param #= following
) {}

is &has-parameter-as-well.signature.params[0].WHY, "preceding\nfollowing";

sub so-many-params(
    #| next param
    Str $param, #= first param
    Int $other-param
) {}

is &so-many-params.signature.params[0].WHY, "next param\nfirst param";
