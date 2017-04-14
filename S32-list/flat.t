use v6;
use Test;

# Tests for `flat` routine

sub make-test-data {
    # We use a sub so we could have non-cached Seqs and test both method and
    # sub forms of .flat with the data.
    gather {
        take $_ => (1, 2, 3).Seq for (1…3), (1, (2, (3,))).Seq, (1, 2, 3),
            (1, (2, (3,))), 1..3, (1, 2..3);

        take $_ => .Seq
            for (1, 2, 3), (1, $(2, $(3,))), [<a b c>], ['a', ['b', ['c']]],
            (class { method Str { 'foo' } }.new,), (Complex, $(Any, $(Int,)));
    }
}

plan 4 + 2*make-test-data;

for make-test-data() -> (:key($got), :value($expected)) {
    is-deeply $got.flat,  $expected, "$got.perl() (method form)";
}

for make-test-data() -> (:key($got), :value($expected)) {
    is-deeply flat($got), $expected, "$got.perl() (sub form)";
}

is-deeply ((1, 2, 3), 4..*).flat[^20], (1..*)[^20],
    'can flatten stuff with lazy stuff inside of it (method form)';

is-deeply flat((1, 2, 3), 4..*)[^20], (1..*)[^20],
    'can flatten stuff with lazy stuff inside of it (sub form)';

is-deeply (1..*).flat.is-lazy, True, 'flat propagates .is-lazy (method form)';
is-deeply flat(1..*).is-lazy,  True, 'flat propagates .is-lazy (subform)';

# vim: ft=perl6
