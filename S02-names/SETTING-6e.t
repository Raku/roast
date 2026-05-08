# SETTING::OUTER::OUTER is a revision-specific namespace.
use v6.e.PREVIEW;
use MONKEY-SEE-NO-EVAL;
use Test;

# SETTING:: in 6.e resolves to a different point in the static chain than
# in 6.c, so reaching CORE's &not from user code may require zero or more
# ::OUTER hops. This test asserts that *some* SETTING::(OUTER::)* path
# resolves to CORE's negating &not (distinct from the local identity
# shadow below). The number of hops is not part of the assertion: it
# tracks setting-layer arrangement, which is an implementation detail.

plan 4;

sub not($x) { $x } #OK

# Smallest path of shape SETTING::(OUTER::)* whose &not is CORE's negating
# version, not the identity shadow above.
my $path;
for ^20 -> $n {
    my $candidate = 'SETTING' ~ '::OUTER' x $n;
    if (try &::($candidate)::not(False)) === True {
        $path = $candidate;
        last;
    }
}

ok $path.defined,
    'some SETTING::(OUTER::)* path resolves to CORE &not';

ok &::($path)::not(False),
    "::('$path') reaches CORE &not from top-level";

ok EVAL("my \$p = '$path'; \&::(\$p)::not(False)"),
    "::('$path') reaches CORE &not from inside EVAL";

my $f = EVAL('-> $fn { $fn(); }');
ok $f({ &CALLER::($path)::not(False) }),
    "CALLER::('$path') reaches CORE &not from closure called via EVAL";

# vim: expandtab shiftwidth=4
