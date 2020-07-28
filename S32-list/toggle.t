use v6;
use Test;

# Tests for .toggle method
plan 4;

subtest 'general' => {
    plan +my @types := ^10, (0, 1, 2, 3, 4, 5, 6, 7, 8, 9), [^10];
    for @types -> \t {
        subtest t.^name => {
            is-deeply t.toggle,      ^10 .Seq, 'no args';
            is-deeply t.toggle(:off),  ().Seq, 'no args (:off)';
            is-deeply t.toggle(?*),    ().Seq, '1 callable (toggles on first value)';
            is-deeply t.toggle(!*),  (0,).Seq, '1 callable (toggles on later value)';
            is-deeply t.toggle(:off, ?*), (^9+1).Seq, '1 callable (:off, toggles on first value)';
            is-deeply t.toggle(:off, !*), ^10 .Seq, '1 callable (:off, toggles on later value)';

            # 0 => off, toggle; 1..3 => off, 4 => on, toggle, 5 => off, toggle,
            # 6 => on, toggle, 7 => off, toggle, 8..* => off
            is-deeply t.toggle(?*, * > 3, !*, * < 7, !*),       (4, 6).Seq, 'multi-callable';
            # 0 => off, 1 => on, toggle; 2 => off, toggle, 3..* => off
            is-deeply t.toggle(:off, ?*, * > 3, !*, * < 7, !*), 1.Seq, 'multi-callable (:off)';
        }
    }
}

subtest 'chaining' => {
    plan 3;
    is-deeply ^10 .toggle(* < 8).toggle(:off, * > 5), (6, 7).Seq, 'on, off';
    is-deeply ^10 .skip(3).toggle(* < 8).grep(* < 7).toggle(:off, * > 5), (6,).Seq, 'skip, on, grep, off';

    my $s := ^60; for ^50+10 -> \v { $s := $s.toggle: * < v };
    is-deeply $s.List, ^10 .List, '50-toggle chain';
}

subtest 'empty sources' => {
    my @tests = $, (), [], Map.new, %(), set(), mix();
    @tests[0] := Empty; # can't just list it normally above; it will vanish
    plan +@tests;
    for @tests -> \v {
        subtest v<>.perl => {
            plan 6;
            is-deeply v.toggle,           ().Seq, 'no args';
            is-deeply v.toggle(:off),     ().Seq, 'no args (:off)';
            is-deeply v.toggle(?*),       ().Seq, '1 callable (toggles on first value)';
            is-deeply v.toggle(!*),       ().Seq, '1 callable (toggles on later value)';
            is-deeply v.toggle(:off, ?*), ().Seq, '1 callable (:off, toggles on first value)';
            is-deeply v.toggle(:off, !*), ().Seq, '1 callable (:off, toggles on later value)';
        }
    }
}

subtest 'Non-Iterable objects' => {
    is-deeply 42.toggle,               42.Seq, 'no args';
    is-deeply 42.toggle(:off),         ().Seq, 'no args (:off)';
    is-deeply 42.toggle(?*),           42.Seq, 'truthy callable';
    is-deeply 42.toggle(?*, :off),     42.Seq, 'truthy callable (:off)';
    is-deeply 42.toggle(!*),           ().Seq, 'falsy callable';
    is-deeply 42.toggle(?*, !*),       42.Seq, 'multiple callables';
    is-deeply 42.toggle(:off, ?*, !*), 42.Seq, 'multiple callables (:off)';
}

# vim: expandtab shiftwidth=4
