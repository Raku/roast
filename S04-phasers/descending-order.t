use v6;

# Test the running order of phasers
# These blocks appear in descending order
# [TODO] add tests for ENTER/LEAVE/KEEP/UNDO/PRE/POST/etc

use Test;

plan 7;

# L<S04/Phasers/END "at run time" ALAP>

my $var;
my ($var_at_enter, $var_at_init, $var_at_check, $var_at_begin);
my $eof_var;

$var = 13;

my $hist;

END {
    # tests for END blocks:
    is $var, 13, '$var gets initialized at END time';
    is $eof_var, 29, '$eof_var gets assigned at END time';
}

ENTER {
    $hist ~= 'enter ';
    $var_at_enter = $var;
}

INIT {
    $hist ~= 'init ';
    $var_at_init = $var;
}

CHECK {
    $hist ~= 'check ';
    $var_at_check = $var;
}

BEGIN {
    $hist ~= 'begin ';
    $var_at_begin = $var;
}

#?niecza todo 'niecza has "enter", also'
is $hist, 'begin check init enter ', 'BEGIN {} runs only once';
nok $var_at_begin.defined, 'BEGIN {...} ran at compile time';
nok $var_at_check.defined, 'CHECK {...} ran at compile time';
nok $var_at_init.defined, 'INIT {...} ran at runtime, but ASAP';
nok $var_at_enter.defined, 'ENTER {...} at runtime, but before the mainline body';

$eof_var = 29;

# vim: ft=perl6
