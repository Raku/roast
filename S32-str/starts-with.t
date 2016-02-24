use v6.c;

use Test;

plan 8;

# L<S32::Str/Str/=item starts-with>

my $s = "foobar";
ok $s.starts-with("foo"),      "'foobar' starting with 'foo'";
ok $s.starts-with("foobar"),   "'foobar' starting with 'foobar'";
nok $s.starts-with("goo"),     "'foobar' not starting with 'goo'";
nok $s.starts-with("foobarx"), "'foobar' not starting with 'foobarx'";

my $i = 342;
ok $i.starts-with(34),    "342 starting with 34";
ok $i.starts-with(342),   "342 starting with 342";
nok $i.starts-with(43),   "342 not starting with 43";
nok $i.starts-with(3428), "342 not starting with 3428";
