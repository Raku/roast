use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Assuming;

plan 11;


# RT #77520 & RT #125155
# Block does Callable and http://design.perl6.org/S06.html#Priming says
# Callable things can assume.
# also RT #125207
is( try { { $^a }.assuming(123)() }, 123, 'Assumptive Blocks' );

multi testsub (Str $x, $y) { "Str" }    #OK not used
multi testsub (Int $x, $y) { "Int" }    #OK not used

is testsub("a_str", 42), "Str", "basic MMD works (1)";
is testsub(23,      42), "Int", "basic MMD works (2)";

is &testsub("a_str", 42), "Str", "basic MMD works with subrefs (1)";
is &testsub(23,      42), "Int", "basic MMD works with subrefs (2)";

# RT #125207
is &testsub.assuming("a_str")(42), "Str", "basic MMD works with assuming (1)";
is &testsub.assuming(23)\   .(42), "Int", "basic MMD works with assuming (2)";

# RT #126332
multi rt126332 ($x) { 'a' }
multi rt126332 ($x, $y) { 'b' }
multi rt126332 ($x, $y, $z) { 'c' }
is-primed-call(&rt126332, \(1), $[&rt126332(1)]);
is-primed-call(&rt126332, \(2), $[&rt126332(1,2)], 1);
is-primed-call(&rt126332, \(2,3), $[&rt126332(1,2,3)], 1);
throws-like({EVAL '&rt126332.assuming(1)(2,3,4)'; CATCH { }}, X::Multi::NoMatch);

# vim: ft=perl6
