use v6;
use Test;

plan 1;

# for https://rt.perl.org/Ticket/Display.html?id=122810
ok mix(my @large_arr = ("a"...*)[^50000]), "... a large array goes into a bar - I mean mix - with 50k elems and lives";

# vim: ft=perl6
