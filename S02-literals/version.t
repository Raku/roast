use v6;
use Test;

is v1.2.3, 'v1.2.3', 'version literal stringification round-trips';
is v1.2.3+, 'v1.2.3+', 'version literal stringification with + round-trips';
is v1.*.3,  'v1.*.3',  'version literal stringification with * round-trips';
ok  v1.2.3 eqv v1.2.3, 'eqv works on version literals (+)';
nok v5.2.3 eqv v1.2.3, 'eqv works on version literals (-)';
nok v1.2+  eqv v1.2,   '+ makes a difference in eqv';
ok  v1.2   === v1.2,   'version literals are value types';
nok v1.2   === v1.3,   '=== (-)';
ok  v1.2   ~~  v1.2,   'smart-matching (same)';
nok v1.2   ~~  v6.2,   'smart-matching (different)';
ok  v1.2.0 ~~  v1.2,   'smart-matching treats trailing 0 correctly (left)';
ok  v1.2   ~~  v1.2.0, 'smart-matching treats trailing 0 correctly (right)';
ok  v1.2   ~~  v1.0+,  'smart-matching and plus (+1)';
ok  v1.2   ~~  v1.2+,  'smart-matching and plus (+2)';
ok  v5     ~~  v1.2+,  '+ scopes to the whole version, not just the last chunk';
ok  v5.2.3 ~~  v5.2.*, '* wildcard (1+)';
ok  v5.2   ~~  v5.2.*, '* wildcard (2+)';
nok v5.2.3 ~~  v5.3.*, '* wildcard (-)';
nok v1.2   ~~  v1.3+,  'smart-matching and plus (-)';
ok  v1.2.3 ~~  v1,     'smart-matching only cares about the length of the LHS';
nok v1.2.3 ~~  v2,     '... but it can still fail';
is  v1.2   cmp  v1.2,   Same,     'cmp: Same';
is  v1.2   cmp  v3.2,   Increase, 'cmp: Increase';
is  v1.2   cmp  v0.2,   Decrease, 'cmp: Decrease';
is  v1.2   cmp  v1.10,  Increase, "cmp isn't Stringy-based";
#?rakudo 3 todo "trailing zeroes fail"
ok  v1.2   eqv  v1.2.0, 'trailing zeroes are equivalent';
ok  v1.2.0 eqv  v1.2,   'trailing zeroes are equivalent';
ok  v1.2.0 eqv  v1.2.0.0.0.0.0,   'trailing zeroes are equivalent';

done;

