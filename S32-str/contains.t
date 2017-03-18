use v6;

use Test;

plan 21;

# L<S32::Str/Str/=item contains>

my $s = "foobar";
ok $s.contains("foo"),      "'foobar' contains 'foo'";
ok $s.contains("foobar"),   "'foobar' contains 'foobar'";
nok $s.contains("goo"),     "'foobar' does not contain 'goo'";
nok $s.contains("foobarx"), "'foobar' does not contain 'foobarx'";

ok $s.contains("foo",0),      "pos 0, 'foobar' contains 'foo'";
ok $s.contains("foobar",0),   "pos 0, 'foobar' contains 'foobar'";
nok $s.contains("goo",0),     "pos 0, 'foobar' does not contain 'goo'";
nok $s.contains("foobarx",0), "pos 0, 'foobar' does not contain 'foobarx'";

ok $s.contains("oo",1),       "pos 1, 'foobar' contains 'oo'";
ok $s.contains("oobar",1),    "pos 1, 'foobar' contains 'oobar'";
nok $s.contains("goo",1),     "pos 1, 'foobar' does not contain 'goo'";
nok $s.contains("foobarx",1), "pos 1, 'foobar' does not contain 'foobarx'";

my $i = 342;
ok $i.contains(34),        "342 contains 34";
ok $i.contains(342),       "342 contains 342";
nok $i.contains(43),       "342 does not contain 43";
nok $i.contains(3428),     "342 does not contain 3428";

ok $i.contains(34,"0"),    "pos 0, 342 contains 34";
ok $i.contains(342,"0"),   "pos 0, 342 contains 342";
nok $i.contains(43,"0"),   "pos 0, 342 does not contain 43";
nok $i.contains(3428,"0"), "pos 0, 342 does not contain 3428";

try { 42.contains: Str }; pass "Cool.contains with wrong args does not hang";
#
# vim: ft=perl6
