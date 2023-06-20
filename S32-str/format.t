use v6.e.PREVIEW;

use Test;

# Basic Format class / Formatter::Syntax grammar tests

plan 8;

my $f = Format.new("%10s");
isa-ok $f, Format;
isa-ok $f.code, Callable;

is $f("foo"), '       foo', 'is it callable?';
is "$f", '%10s', 'does it stringify ok';
is "'$f("bar")'", "'       bar'", 'does it embed ok';

isa-ok Formatter::Syntax.parse("zippo%10sbar"), Match;
isa-ok Formatter.CODE("zippo%10sbar"), Callable;
ok Formatter.AST("zippo%10sbar") ~~ RakuAST::Node,  # isa-ok fails??
  "The object is-a 'RakuAST::Node'";

# vim: expandtab shiftwidth=4
