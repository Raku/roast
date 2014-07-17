use Test;
plan 53;

#| simple case
class Simple {
#= not so simple now!
}

is Simple.WHY.content,  "simple case\nnot so simple now!";
ok Simple.WHY.WHEREFORE === Simple, 'class WHEREFORE matches';
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
ok foo.WHY.WHEREFORE === foo,  'module WHEREFORE matches';
is foo.WHY.leading,            "a module";
is foo.WHY.trailing,           "moar module stuff";
is foo::bar.WHY.content,       "a package\nmore package stuff";
ok foo::bar.WHY.WHEREFORE === foo::bar, 'inner package WHEREFORE matches';
is foo::bar.WHY.leading,       "a package";
is foo::bar.WHY.trailing,      "more package stuff";
is foo::bar::baz.WHY.content,  "and a class\nmore class stuff";
ok foo::bar::baz.WHY.WHEREFORE === foo::bar::baz, 'inner inner class WHEREFORE matches';
is foo::bar::baz.WHY.leading,  "and a class";
is foo::bar::baz.WHY.trailing, "more class stuff";

#| yellow
sub marine {}
#= submarine
is &marine.WHY.content,  "yellow\nsubmarine";
ok &marine.WHY.WHEREFORE === &marine, 'sub WHEREFORE matches';
is &marine.WHY.leading,  "yellow";
is &marine.WHY.trailing, "submarine";

#| pink
sub panther {} #= panther
is &panther.WHY.content,  "pink\npanther";
ok &panther.WHY.WHEREFORE === &panther, 'sub WHEREFORE matches';
is &panther.WHY.leading,  "pink";
is &panther.WHY.trailing, "panther";

#| a sheep
class Sheep {
#= or is it?
    #| usually white
    has $.wool; #= not very dirty

    #| not too scary
    method roar { 'roar!' } #= ...unless you fear sheep!
}

is Sheep.WHY.content, "a sheep\nor is it?";
ok Sheep.WHY.WHEREFORE === Sheep, 'class WHEREFORE matches';
is Sheep.WHY.leading, "a sheep";
is Sheep.WHY.trailing, "or is it?";

my $wool-attr = Sheep.^attributes.grep({ .name eq '$!wool' })[0];
is $wool-attr.WHY, "usually white\nnot very dirty";
ok $wool-attr.WHY.WHEREFORE === $wool-attr, 'attr WHEREFORE matches';
is $wool-attr.WHY.leading, "usually white";
is $wool-attr.WHY.trailing, "not very dirty";

my $roar-method = Sheep.^find_method('roar');
is $roar-method.WHY.content, "not too scary\n...unless you fear sheep!";
ok $roar-method.WHY.WHEREFORE === $roar-method, 'method WHEREFORE matches';
is $roar-method.WHY.leading,  "not too scary";
is $roar-method.WHY.trailing, "...unless you fear sheep!";

#| trailing space here  
sub third {}
#=    leading space here
is &third.WHY.content,  "trailing space here\nleading space here";
ok &third.WHY.WHEREFORE === &third, 'sub WHEREFORE matches';
is &third.WHY.leading,  "trailing space here";
is &third.WHY.trailing, "leading space here";

sub has-parameter(
    #| before
    Str $param
    #= after
) {}

my $param = &has-parameter.signature.params[0];
is $param.WHY, "before\nafter";
ok $param.WHY.WHEREFORE === $param, 'param WHEREFORE matches';
is $param.WHY.leading,  "before";
is $param.WHY.trailing, "after";

sub has-parameter-as-well(
    #| preceding
    Str $param #= following
) {}

$param = &has-parameter-as-well.signature.params[0];
is $param.WHY, "preceding\nfollowing";
ok $param.WHY.WHEREFORE === $param, 'param WHEREFORE matches';
is $param.WHY.leading,  "preceding";
is $param.WHY.trailing, "following";

sub so-many-params(
    #| next param
    Str $param, #= first param
    Int $other-param
) {}

$param = &so-many-params.signature.params[0];
is $param.WHY, "next param\nfirst param";
ok $param.WHY.WHEREFORE === $param, 'param WHEREFORE matches';
is $param.WHY.leading,  "next param";
is $param.WHY.trailing, "first param";
