use v6;
use Test;
plan 12;

nok ?'', "?'' is false";
isa_ok ?'', Bool, "?'' is Bool";
ok ?'hello', "?'hello' is true";
isa_ok ?'hello', Bool, "?'hello' is Bool";
nok ?'0', "?'0' is false";
isa_ok ?'0', Bool, "?'0' is Bool";

#?pugs 6 skip 'Bool'
nok ''.Bool, "''.Bool is false";
isa_ok ''.Bool, Bool, "''.Bool is Bool";
ok 'hello'.Bool, "'hello'.Bool is true";
isa_ok 'hello'.Bool, Bool, "'hello'.Bool is Bool";
nok '0'.Bool, "'0'.Bool is false";
isa_ok '0'.Bool, Bool, "'0'.Bool is Bool";

# vim: ft=perl6
