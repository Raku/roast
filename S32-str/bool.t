use v6.c;
use Test;
plan 12;

nok ?'', "?'' is false";
isa-ok ?'', Bool, "?'' is Bool";
ok ?'hello', "?'hello' is true";
isa-ok ?'hello', Bool, "?'hello' is Bool";
ok ?'0', "?'0' is true";
isa-ok ?'0', Bool, "?'0' is Bool";

nok ''.Bool, "''.Bool is false";
isa-ok ''.Bool, Bool, "''.Bool is Bool";
ok 'hello'.Bool, "'hello'.Bool is true";
isa-ok 'hello'.Bool, Bool, "'hello'.Bool is Bool";
ok '0'.Bool, "'0'.Bool is true";
isa-ok '0'.Bool, Bool, "'0'.Bool is Bool";

# vim: ft=perl6
