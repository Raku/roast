use v6;
use Test;

plan 5;

is 3 [&atan2] 4, atan2(3, 4), "3 [&atan2] 4 == atan2(3, 4)";
is 3 R[&atan2] 4, atan2(4, 3), "3 R[&atan2] 4 == atan2(4, 3)";
is 3 R[&atan2] 4, atan2(4, 3), "... and you can do it twice";

is "%10s" [&sprintf] "step", "      step", "[&sprintf] works";
is ("%04x" X[&sprintf] 7, 11, 42), "0007 000b 002a", "X[&sprint] works";

# vim: ft=perl6
