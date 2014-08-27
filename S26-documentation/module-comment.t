use Test;

plan 1;

#| before
module M;
#= after

is M.WHY, "before\nafter", 'module + semicolon trailing comment';
