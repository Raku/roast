use v6;

use Test;

plan 7;


#?rakudo todo 'RT #77520 & RT #125155 - Block.assuming'
#
# Block does Callable and http://design.perl6.org/S06.html#Priming says
# Callable things can assume.
is( try { { $^a }.assuming(123)() }, 123, 'Assumptive Blocks' );

multi testsub (Str $x, $y) { "Str" }    #OK not used
multi testsub (Int $x, $y) { "Int" }    #OK not used

is testsub("a_str", 42), "Str", "basic MMD works (1)";
is testsub(23,      42), "Int", "basic MMD works (2)";

is &testsub("a_str", 42), "Str", "basic MMD works with subrefs (1)";
is &testsub(23,      42), "Int", "basic MMD works with subrefs (2)";

#?niecza skip 'Unable to resolve method assuming in class Code'
is &testsub.assuming("a_str")(42), "Str", "basic MMD works with assuming (1)";
#?niecza skip 'Unable to resolve method assuming in class Code'
is &testsub.assuming(23)\   .(42), "Int", "basic MMD works with assuming (2)";

# vim: ft=perl6
