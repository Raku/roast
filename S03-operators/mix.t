use v6;
use Test;

plan 8;

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok mix(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean mix - with 50k elems and lives";

{

    my $b     = (e => 1.1).Mix;
    my $bub   = (n => 2.2, e => 2.2, d => 2.2).Mix;
    my $buper = (n => 2.2, e => 4.4, d => 2.2, y => 2.2).Mix;

    ok $b ⊂ $bub, "⊂ - {$b.gist} is a strict submix of {$bub.gist}";
    nok $bub ⊄ $buper, "⊄ - {$bub.gist} is a strict submix of {$buper.gist}";
    ok $bub ⊃ $b, "⊃ - {$bub.gist} is a strict supermix of {$b.gist}";
    ok $b (<) $bub, "(<) - {$b.gist} is a strict submix of {$bub.gist} (texas)";
    nok $bub !(<) $buper, "!(<) - {$bub.gist} is a strict submix of {$buper.gist} (texas)";
    ok $bub (>) $b, "(>) - {$bub.gist} is a strict supermix of {$b.gist} (texas)";
    nok $buper !(>) $bub, "!(>) - {$buper.gist} is a strict supermix of {$bub.gist}";
}

# vim: ft=perl6
