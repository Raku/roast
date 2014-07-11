use v6;
use Test;

plan 32;

# adapted from t/operators/eq.t and t/operators/cond.t
# relational ops are in relational.t
# cmp, leq, <=>, etc. are in comparison.t

#L<S03/Chaining binary precedence>
#L<S03/Comparison semantics>

# string equality & inequality
ok("a" eq "a",     "eq true");
ok(!("a" eq "ab"), "eq false");
ok("a" ne "ab",    "ne true");
ok(!("a" ne "a"),  "ne false");

# potential problem cases
ok("\0" eq "\0",   "eq on strings with null chars");
ok(!("\0" eq "\0\0"),   "!eq on strings with null chars but different lengths");
ok(!("a" eq "a\0"),   "eq doesn't have null-padding semantics");
ok(!("a" eq "a "),   "eq doesn't have space-padding semantics");
ok("a" ne "a\0",   "ne doesn't have null-padding semantics");
ok("a" ne "a ",   "ne doesn't have space-padding semantics");

# string context on undefined values
my $foo;
ok($foo eq "",     "Any eq ''");
ok($foo ne "f",    "Any ne 'f'");

my @foo;
ok(@foo[0] eq "",  "Array Any eq ''");
ok(@foo[0] ne "f",  "Array Any ne 'f'");

# numeric equality & inequality
ok(2 == 2,         "== true");
ok(!(2 == 3),      "== false");
ok(2 != 3,         "!= true");
ok(!(2 != 2),      "!= false");

#?niecza skip 'No value for parameter $r in CORE infix:<==>'
ok infix:<==>(False), "== with one argument is correct";
#?niecza skip 'No value for parameter $l in CORE infix:<==>'
ok  infix:<==>(),     "== with no arguments is correct";
#?niecza skip 'No value for parameter $r in CORE infix:<!=>'
ok infix:<!=>(False), "!= with one argument is correct";
#?niecza skip 'No value for parameter $l in CORE infix:<!=>'
ok  infix:<!=>(),     "!= with no arguments is correct";

#L<S03/Negated relational operators>
ok(2 !== 3,         "!== true");
ok(!(2 !== 2),      "!== false");
ok($foo !eq "f",    "!eq true undef");
ok("" !eq "f",    "!eq true empty string");
ok(!($foo !eq ""),  "!eq false undef and empty string");
ok(!($foo !eq $foo),  "!eq false undef twice");
ok(!("" !eq ""),  "!eq false empty string twice");
ok(!("xc" !eq "xc"),  "!eq false non-empty string twice");

# numeric context on undefined values
ok($foo == 0,      "Any == 0");
ok(@foo[0] == 0,   "Array Any == 0");

# XXX: need tests for coercion string and numeric coercions

# vim: ft=perl6
