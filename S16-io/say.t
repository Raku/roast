use v6;

# L<S32::IO/IO/=item say>

# doesn't use Test.pm and plan() intentionally

say "1..8";

# Tests for say
{
    say "ok 1 - basic form of say";
}

{
    say "o", "k 2 - say with multiple parame", "ters (1)";

    my @array = ("o", "k 3 - say with multiple parameters (2)");
    say |@array;
}

{
    my $arrayref = <ok 4 - say stringifies its args>;
    say $arrayref;
}

{
    "ok 5 - method form of say".say;
}

$*OUT.say('ok 6 - $*OUT.say(...)');

"ok 7 - Mu.print\n".print;

grammar A {
    token TOP { .+ };
}

A.parse("ok 8 - Match.print\n").print;

# vim: ft=perl6
