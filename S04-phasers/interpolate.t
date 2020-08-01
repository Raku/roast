use v6;

# Test phasers interpolated in double-quoted strings

use Test;

plan 5;

# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

# L<S04/Phasers/END "at run time" ALAP>

# IRC log:
# ----------------------------------------------------------------
# agentzh   question: should BEGIN blocks interpolated in double-quoted
#           strings be fired at compile-time or run-time?
#           for example, say "This is { BEGIN { say 'hi' } }";
# audreyt   compile time.
#           qq is not eval.

my $hist;

END {
    is $hist, 'BCIE', 'interpolated END {...} executed';
}

# END phaser doesn't have a return value.
nok "{ END { $hist ~= 'E' } // "" }",
    'END {...} not yet executed';

is "{ INIT { $hist ~= 'I'; $hist<> } }", 'BCI',
    'INIT {...} fired at the beginning of runtime';

is "{ CHECK { $hist ~= 'C'; $hist<> } }", "BC",
    'CHECK {...} fired at compile-time, ALAP';

is "{ BEGIN { $hist ~= 'B'; $hist<> } }", "B",
    'BEGIN {...} fired at compile-time, ASAP';

# vim: expandtab shiftwidth=4
