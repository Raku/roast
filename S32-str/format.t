use v6.e.PREVIEW;

use Test;

# Basic Format class / Formatter::Syntax grammar tests

plan 6;

my $f = Format.new("%10s");
isa-ok $f, Format;
isa-ok $f.code, Callable;

is $f("foo"), '       foo', 'is it callable?';
is "$f", '%10s', 'does it stringify ok';
is "'$f("bar")'", "'       bar'", 'does it embed ok';

isa-ok Formatter::Syntax.parse("zippo%10sbar"), Match;

# vim: expandtab shiftwidth=4
