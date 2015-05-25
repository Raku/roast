use v6;

use Test;

plan 2;


=begin pod

A class can only derive already declared classes.

=end pod

# L<S12/Classes/"bare class names must be predeclared">

# need eval-lives-ok here because class declarations happen at compile time
eval-lives-ok ' class A {}; class B is A {}; ', "base before derived: lives";
eval-dies-ok ' class D is C {}; class C {}; ', "derived before base: dies";

# vim: ft=perl6
