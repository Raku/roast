use Test;

plan 2;

class App {
#= More
#= Than
#= One
#= Line
    method do-stuff() {}
    #= Does
    #= Stuff
}

is ~App.WHY, "More Than One Line";
is ~App.^find_method('do-stuff').WHY, "Does Stuff";

# vim: expandtab shiftwidth=4
