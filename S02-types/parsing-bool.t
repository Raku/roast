use Test;

plan 4;

# L<S03/Loose or precedence/"infix:<or>, short-circuit inclusive or">
# L<S02/Immutable types/"Raku boolean">

is (try { 42 or Bool::False }), 42, "Bool::False as RHS";
is (try { Bool::False or 42 }), 42, "Bool::False as LHS";

is (try { 42 or False }), 42, "False as RHS";
is (try { False or 42 }), 42, "False as LHS";

# vim: expandtab shiftwidth=4
