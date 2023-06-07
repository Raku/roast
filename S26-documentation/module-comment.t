use Test;

plan 1;

#| before
unit module M;
#= after

is M.WHY, "before\nafter", 'module + semicolon trailing comment';

# vim: expandtab shiftwidth=4
