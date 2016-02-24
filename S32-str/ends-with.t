use v6.c;

use Test;

plan 8;

# L<S32::Str/Str/=item ends-with>

my $s = "foobar";
ok $s.ends-with("bar"),      "'foobar' ending with 'bar'";
ok $s.ends-with("foobar"),   "'foobar' ending with 'foobar'";
nok $s.ends-with("baz"),     "'foobar' not ending with 'baz'";
nok $s.ends-with("zfoobar"), "'foobar' not ending with 'zfoobar'";

my $i = 342;
ok $i.ends-with(42),    "342 ending with 42";
ok $i.ends-with(342),   "342 ending with 342";
nok $i.ends-with(43),   "342 not ending with 43";
nok $i.ends-with(7342), "342 not ending with 7342";
