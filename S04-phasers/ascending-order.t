use v6;

# Test the running order of BEGIN/CHECK/INIT/ENTER/END
# These blocks appear in ascending order
# [TODO] add tests for LEAVE/KEEP/UNDO/PRE/POST/etc

use Test;

plan 7;

# L<S04/Phasers/END "at run time" ALAP>

my $var;
my ($var_at_begin, $var_at_check, $var_at_init, $var_at_enter, $var_at_leave);
my $eof_var;

$var = 13;

my $hist;

# XXX check if BEGIN blocks do have to remember side effects
BEGIN {
    $hist ~= 'begin ';
    $var_at_begin = $var;
}

CHECK {
    $hist ~= 'check ';
    $var_at_check = $var;
}

INIT {
    $hist ~= 'init ';
    $var_at_init = $var;
}

ENTER {
    $hist ~= 'enter ';
    $var_at_enter = $var;
}

END {
    # tests for END blocks:
    is $var, 13, '$var gets initialized at END time';
    is $eof_var, 29, '$eof_var gets assigned at END time';
}

#?pugs todo
is $hist, 'begin check init enter ', 'BEGIN {} runs only once';
nok $var_at_begin.defined, 'BEGIN {...} ran at compile time';
nok $var_at_check.defined, 'CHECK {...} ran at compile time';
nok $var_at_init.defined, 'INIT {...} ran at runtime, but ASAP';
nok $var_at_enter.defined, 'ENTER {...} at runtime, but before the mainline body';

$eof_var = 29;

# vim: ft=perl6
