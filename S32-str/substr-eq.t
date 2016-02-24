use v6.c;

use Test;

plan 12;

# L<S32::Str/Str/=item substr-eq>

my $s = "foobar";
ok $s.substr-eq("bar",3),       "'foobar' equal to 'bar',3";
ok $s.substr-eq("foobar",0),    "'foobar' equal to 'foobar',0";
nok $s.substr-eq("baz",3),      "'foobar' not equal to 'baz',3";
nok $s.substr-eq("zfoobar",0),  "'foobar' not equal to 'zfoobar',0";
nok $s.substr-eq("foobar",-42), "'foobar' not equal to 'foobar',-42";
nok $s.substr-eq("foobar",999), "'foobar' not equal to 'foobar',999";

my $i = 342;
ok $i.substr-eq(42,1),     "342 equal to 42,1";
ok $i.substr-eq(342,0),    "342 equal to 342,0";
nok $i.substr-eq(43,1),    "342 not equal to 43,1";
nok $i.substr-eq(7342,0),  "342 not equal to 7342,0";
nok $i.substr-eq(342,-42), "342 not equal to 342,-42";
nok $i.substr-eq(342,999), "342 not equal to 342,999";
