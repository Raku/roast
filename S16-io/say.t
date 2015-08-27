use v6;

# L<S32::IO/IO/=item say>

# doesn't use Test.pm and plan() intentionally

say "1..10";

# Tests for say
{
    say "ok 1 - basic form of say";
}

{
    say "o", "k 2 - say with multiple parame", "ters (1)";

    my @array = ("o", "k 3 - say with multiple parameters (2)");
    say @array;
}

{
    my $arrayref = <ok 4 - say stringifies its args>;
    say $arrayref.gist;
}

{
    my @a = <ok 5 - say stringifies its args>;
    @a[*-1] ~= "\n";
    my @b = <ok 6 - say stringifies its args>;
    say @a, @b;
}

{
    "ok 7 - method form of say".say;
}

$*OUT.say('ok 8 - $*OUT.say(...)');

"ok 9 - Mu.print\n".print;

grammar A {
    token TOP { .+ };
}

A.parse("ok 10 - Match.print\n").print;

# vim: ft=perl6
