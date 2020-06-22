use v6;
use Test;
use lib $?FILE.IO.parent(3).add: 'packages/Test-Helpers';
use Test::Util;

plan 3;

# https://github.com/Raku/old-issue-tracker/issues/5649
# We don't yet choose to set a maximum number of combiners, or a minimum that
# Raku implementations must support. However, we should be sure that even if
# a ridiculously huge number is given, it either works or throws a catchable
# exception. This makes sure at the very least we do not SEGV in such cases,
# which is not acceptable behavior.
lives-ok { try 7 ~ "\x[308]" x 150_000 },
    'No VM crash on enormous number of combiners';

# https://github.com/Raku/old-issue-tracker/issues/5260
#?rakudo.jvm todo 'repeat count (4294967295) cannot be greater than max allowed number of graphemes 2147483647'
eval-lives-ok 'my str $a = "a" x 2**32-1', 'native strings can be as large as regular strings';


# https://github.com/Raku/old-issue-tracker/issues/2593
group-of 8 => 'role multi tiebreaking (TEST USES UNSUPPORTED FEATURES)' => {
    # NOTE: side-effects from `where` clauses are not supported on language level,
    # and so there's a large chance this test will not work on some implementations
    # or will stop working on currrent implementations when better optimizations
    # are in place. TODO XXX: think of a better way to write this test, without
    # using unsupported features, and place it into the main spec.

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
        # NOTE: side-effects from `where` clauses are not supported on language level
        multi method f($ where { $checked ~= "d1"; $_ == 1 }) { 1 }
        # NOTE: side-effects from `where` clauses are not supported on language level
        multi method f($ where { $checked ~= "d2"; $_ == 2 }) { 2 }
    }
    role E {
        # NOTE: side-effects from `where` clauses are not supported on language level
        multi method f($ where { $checked ~= "e"; $_ == 3 }) { 3 }
    }
    lives-ok { class C3 does D does C {}; C3.new.f(2) },
        "Multi-role mix with only where clauses different";
    # NOTE: side-effects from `where` clauses are not supported on language level
    ok $checked ~~ /^d1d2/,
        "Multis from same role declaration order tiebreaker (TEST USES UNSUPPORTED FEATURES)";
    $checked = '';
    lives-ok { class C4 does D does E {}; C4.new.f(3) },
        "Multis from different roles with only where clauses different";
    # NOTE: side-effects from `where` clauses are not supported on language level
    #?rakudo todo "Wrong tiebreaker order (S12, actually)"
    ok $checked ~~ /^d1d2e/,
        "Multis from different roles declaration order tiebreaker (TEST USES UNSUPPORTED FEATURES)";
    $checked = '';
    lives-ok { class C5 does E does D {}; C4.new.f(3) },
        "Multis from different roles with only where clauses different (2)";
    # Design review needed on this one -- is inclusion order considered as declaration order?
    # NOTE: side-effects from `where` clauses are not supported on language level
    #?rakudo todo "Wrong tiebreaker order (S12, actually)"
    ok $checked ~~ /^d1d2e/,
        "Multis from different roles declaration order tiebreaker (TEST USES UNSUPPORTED FEATURES)";
}

# vim: expandtab shiftwidth=4
