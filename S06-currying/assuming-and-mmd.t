use v6;

use Test;

plan 6;

multi testsub (Str $x, $y) { "Str" }
multi testsub (Int $x, $y) { "Int" }

is testsub("a_str", 42), "Str", "basic MMD works (1)";
is testsub(23,      42), "Int", "basic MMD works (2)";

is &testsub("a_str", 42), "Str", "basic MMD works with subrefs (1)";
is &testsub(23,      42), "Int", "basic MMD works with subrefs (2)";

#?pugs todo 'bug'
is &testsub.assuming(x => "a_str")(42), "Str", "basic MMD works with assuming (1)";
is &testsub.assuming(x => 23)\   .(42), "Int", "basic MMD works with assuming (2)";
