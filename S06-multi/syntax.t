use v6;

use Test;

plan 17;

# L<S06/Routine modifiers/>
# L<S06/Parameters and arguments/>

# multi sub with signature
multi sub foo() { "empty" }
multi sub foo($a) { "one" }
is(foo(), "empty", "multi sub with empty signature");
is(foo(42), "one", "multi sub with parameter list");

# multi sub without signature
multi sub bar { "empty" }
multi sub bar($a) { "one" }
is(bar(), "empty", "multi sub with no signature");
is(bar(42), "one", "multi sub with parameter list");

# multi without a routine type
multi baz { "empty" }
multi baz($a) { "one" }
is(baz(), "empty", "multi with no signature");
is(baz(42), "one", "multi with parameter list");

# multi with some parameters not counting in dispatch (;;) - note that if the
# second paramter is counted as part of the dispatch, then invoking with 2
# ints means they are tied candidates as one isn't narrower than the other.
# (Note Int is narrower than Num - any two types where one is narrower than
# the other will do it, though.)
multi foo(Int $a, Num $b) { 1 }
multi foo(Num $a, Int $b) { 2 }
multi bar(Int $a;; Num $b) { 1 }
multi bar(Num $a;; Int $b) { 2 }
my $lived = 0;
try { foo(1,1); $lived = 1 }
is($lived, 0, "dispatch tied as expected");
is(bar(1,1), 1, "not tied as only first type in the dispatch");

# not allowed to declare anonymous routines with only, multi or proto.
eval_dies_ok 'only sub {}', 'anonymous only sub is an error';
eval_dies_ok 'multi sub {}', 'anonymous multi sub is an error';
eval_dies_ok 'proto sub {}', 'anonymous proto sub is an error';
eval_dies_ok 'only {}', 'anonymous only is an error';
eval_dies_ok 'multi {}', 'anonymous multi is an error';
eval_dies_ok 'proto {}', 'anonymous proto is an error';
eval_dies_ok 'class A { only method {} }', 'anonymous only method is an error';
eval_dies_ok 'class B { multi method {} }', 'anonymous multi method is an error';
eval_dies_ok 'class C { proto method {} }', 'anonymous proto method is an error';
