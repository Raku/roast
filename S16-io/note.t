use v6;

# L<S32::IO/IO/=item note>

# doesn't use Test.pm and plan() intentionally

say "1..7";

# We can't write TAP output to STDERR
$*ERR = $*OUT;

# Tests for note
{
    note "ok 1 - basic form of note";
}

{
    note "o", "k 2 - note with multiple parame", "ters (1)";

    my @array = ("o", "k 3 - say with multiple parameters (2)");
    note @array;
}

{
    my $arrayref = <<'ok 4 - ' note stringifies its args>>;
    note $arrayref;
}

{
    "ok 5 - method form of note".note;
}


"ok 6 - Mu.note\n".note;

grammar A {
    token TOP { .+ };
}

A.parse("ok 7 - Match.note\n").Str.note;

# vim: ft=perl6
