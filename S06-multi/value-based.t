use v6;

use Test;

plan 21;

# L<S06/Routine modifiers/>
# L<S06/Parameters and arguments/>

# Simple case.
{
    multi m1("foo") { 1 }
    multi m1("bar") { 2 }

    is m1("foo"), 1,       "literal Str in signature matches value correctly";
    is m1("bar"), 2,       "literal Str in signature matches value correctly";
    dies-ok { m1("baz") }, "dies if no matching value even if type matches";
}

# More complex case. Here we check that the multis get the right narrowness,
# based upon the type of the literal, and are narrower than a candidate of
# the same type because they have constraints.
{
    multi m2(1)      { "a" }
    multi m2(2)      { "b" }
    multi m2(Int $x) { "c" }   #OK not used
    multi m2($x)     { "d" }   #OK not used
    multi m2(-1)     { "e" }

    is m2(1),   "a", 'literal Int in signature matches value correctly';
    is m2(2),   "b", 'literal Int in signature matches value correctly';
    is m2(3),   "c", 'fallback to Int variant which is less narrow than constrained one';
    is m2("x"), "d", 'if not an Int at all, fall back to Any candidate';
    is m2(-1),  "e", 'negative literal Int in signature matches value correctly';
}

# RT #88562
{
    multi m3(0     ,     $       ) { 'a' };
    multi m3(Int $n, Str $a = 'A') { 'b' };  #OK not used

    is m3(2, 'A'), 'b', 'literal Int, anonymous parameters and default values mix';
}

{
    multi sub foo(0, $)               { 'B' };
    multi sub foo(Int $n, Str $a="A") { $a };  #OK not used
    is foo(2,"A"), 'A', 'Literals and optionals mix';
}

# not quite a multi, but also value based
# RT #107348

{
    sub f(True) { 'a' }
    is f(True), 'a', 'can call a sub f(True)  with True as argument';
    is f(False), 'a', 'works with False too, since False ~~ True';
    dies-ok { EVAL 'f(1)' }, 'type constraint is still Bool';
}

# vim: ft=perl6

# RT #127129 and RT #127024 and RT#127025
{
    role A {
        multi method f(1) { 1 }
        multi method f(2) { 2 }
    }
    role B {
        multi method f(3) { 3 }
    }
    role C {
    }
    lives-ok { class C1 does A does C {} },
        "Multi-role mix with value constrained parameter";
    lives-ok { class C2 does A does B {} },
        "Multis from diferent roles with value constrained parameter";

    my $checked = '';
    role D {
        multi method f($ where { $checked ~= "d1"; $_ == 1 }) { 1 }
        multi method f($ where { $checked ~= "d2"; $_ == 2 }) { 2 }
    }
    role E {
        multi method f($ where { $checked ~= "e"; $_ == 3 }) { 3 }
    }
    lives-ok { class C3 does D does C {}; C3.new.f(2) },
        "Multi-role mix with only where clauses different";
    ok $checked ~~ /^d1d2/,
        "Multis from same role declaration order tiebreaker";
    $checked = '';
    lives-ok { class C4 does D does E {}; C4.new.f(3) },
        "Multis from different roles with only where clauses different";
    #?rakudo todo "Wrong tiebreaker order (S12, actually)"
    ok $checked ~~ /^d1d2e/,
        "Multis from different roles declaration order tiebreaker";
    $checked = '';
    lives-ok { class C5 does E does D {}; C4.new.f(3) },
        "Multis from different roles with only where clauses different (2)";
    # Design review needed on this one -- is inclusion order considered as declaration order? 
    #?rakudo todo "Wrong tiebreaker order (S12, actually)"
    ok $checked ~~ /^d1d2e/,
        "Multis from different roles declaration order tiebreaker";
}