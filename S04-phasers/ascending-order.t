use v6;

# Test the running order of BEGIN/CHECK/INIT/END
# These blocks appear in ascending order
# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

use Test;

plan 8;

# L<S04/Phasers/END "at run time" ALAP>

my $var;
my ($var_at_begin, $var_at_check, $var_at_init, $var_at_start, $var_at_enter);
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

START {
    $hist ~= 'start ';
    $var_at_start = $var + 1;
}

END {
    # tests for END blocks:
    is $var, 13, '$var gets initialized at END time';
    is $eof_var, 29, '$eof_var gets assigned at END time';
}

#?niecza todo 'niecza has "enter", also'
is $hist, 'begin check init start ', 'BEGIN {} runs only once';
nok $var_at_begin.defined, 'BEGIN {...} ran at compile time';
nok $var_at_check.defined, 'CHECK {...} ran at compile time';
nok $var_at_init.defined, 'INIT {...} ran at runtime, but ASAP';
nok $var_at_enter.defined, 'ENTER {...} at runtime, but before the mainline body';
is $var_at_start, 14, 'START {...} at runtime, just in time';

$eof_var = 29;

# vim: ft=perl6
