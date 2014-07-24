use v6;
use Test;

plan 2;

#| More
#| Than
#| One
#| Line
class App {
    #| Does
    #| Stuff
    method do-stuff() {}
}

is ~App.WHY, "More Than One Line";
is ~App.^find_method('do-stuff').WHY, "Does Stuff";
