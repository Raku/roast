use v6;

use Test;

plan 2;

=begin pod

A class can only derive already declared classes.

=end pod

lives_ok { class A {}; class B is A {}; }, "base before derived: lives";
eval_dies_ok { class D is C {}; class C {}; }, "derived before base: dies";
