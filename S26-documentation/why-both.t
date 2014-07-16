use Test;
plan 36;

#| simple case
class Simple {
#= not so simple now!
}

is Simple.WHY.content,  "simple case\nnot so simple now!";
is Simple.WHY.leading,  "simple case";
is Simple.WHY.trailing, "not so simple now!";
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

is foo.WHY.content,            "a module\nmoar module stuff";
is foo.WHY.leading,            "a module";
is foo.WHY.trailing,           "moar module stuff";
is foo::bar.WHY.content,       "a package\nmore package stuff";
is foo::bar.WHY.leading,       "a package";
is foo::bar.WHY.trailing,      "more package stuff";
is foo::bar::baz.WHY.content,  "and a class\nmore class stuff";
is foo::bar::baz.WHY.leading,  "and a class";
is foo::bar::baz.WHY.trailing, "more class stuff";

#| yellow
sub marine {}
#= submarine
is &marine.WHY.content,  "yellow\nsubmarine";
is &marine.WHY.leading,  "yellow";
is &marine.WHY.trailing, "submarine";

#| pink
sub panther {} #= panther
is &panther.WHY.content,  "pink\npanther";
is &panther.WHY.leading,  "pink";
is &panther.WHY.trailing, "panther";

#| a sheep
class Sheep {
    #| usually white
    has $.wool; #= not very dirty

    #| not too scary
    method roar { 'roar!' }
}

is Sheep.WHY.content, 'a sheep';
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY, "usually white\nnot very dirty";
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.leading, "usually white";
is Sheep.^attributes.grep({ .name eq '$!wool' })[0].WHY.trailing, "not very dirty";
is Sheep.^find_method('roar').WHY.content, 'not too scary';

#| trailing space here  
sub third {}
#=    leading space here
is &third.WHY.content,  "trailing space here\nleading space here";
is &third.WHY.leading,  "trailing space here";
is &third.WHY.trailing, "leading space here";

sub has-parameter(
    #| before
    Str $param
    #= after
) {}

is &has-parameter.signature.params[0].WHY, "before\nafter";
is &has-parameter.signature.params[0].WHY.leading,  "before";
is &has-parameter.signature.params[0].WHY.trailing, "after";

sub has-parameter-as-well(
    #| preceding
    Str $param #= following
) {}

is &has-parameter-as-well.signature.params[0].WHY, "preceding\nfollowing";
is &has-parameter-as-well.signature.params[0].WHY.leading,  "preceding";
is &has-parameter-as-well.signature.params[0].WHY.trailing, "following";

sub so-many-params(
    #| next param
    Str $param, #= first param
    Int $other-param
) {}

is &so-many-params.signature.params[0].WHY, "next param\nfirst param";
is &so-many-params.signature.params[0].WHY.leading,  "next param";
is &so-many-params.signature.params[0].WHY.trailing, "first param";
