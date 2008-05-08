use v6;
use Test;

plan 15;

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

# string context on undef values
my $foo;
ok($foo eq "",     "Undef eq ''");
ok($foo ne "f",    "Undef ne 'f'");

my @foo;
ok(@foo[0] eq "",  "Array undef eq ''");
ok(@foo[0] ne "f",  "Array undef ne 'f'");

# numeric equality & inequality
ok(2 == 2,         "== true");
ok(!(2 == 3),      "== false");
ok(2 != 3,         "!= true");
ok(!(2 != 2),      "!= false");

# numeric context on undef values
ok($foo == 0,      "Undef == 0");
ok(@foo[0] == 0,   "Array undef == 0");

# XXX: need tests for coercion string and numeric coercions
