use Test;

plan 4;

#| More
#| Than
#| One
#| Line
class App {
    #| Does
    #| Stuff
    method do-stuff(
        #| Param
        #| One
        Str $param1,

        #| Param
        #| Two
        Str $param2
    ) {}
}

my $method = App.^find_method('do-stuff');
is ~App.WHY, "More Than One Line", "multiline-leading App.WHY";
is ~$method.WHY, "Does Stuff", "multiline-leading method.WHY";

my @params = $method.signature.params;

is ~@params[1].WHY, 'Param One', "method.signature WHY param one";
is ~@params[2].WHY, 'Param Two', "method.signature WHY param two";

# vim: expandtab shiftwidth=4
