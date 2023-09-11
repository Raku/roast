use v6.e.PREVIEW;

use Test;

#-------------------------------------------------------------------------------
# Basic Format class / Formatter::Syntax grammar tests

plan 49;

my $f0 = Format.new("foo");
isa-ok $f0, Format;
isa-ok $f0.Callable, Callable;
isa-ok $f0.Callable.signature, Signature;
is $f0.arity, 0, 'arity no args';
is $f0.count, 0, 'count no args';

is $f0(),     'foo',   'is $f0 callable';
is "$f0",     'foo',   'does $f0 stringify ok';
is "'$f0()'", "'foo'", 'does $f0 embed ok';

is ().fmt($f0), "", 'an empty list is ok for argless';
throws-like { <a b c>.fmt($f0) },
  X::Str::Sprintf::Directives::Count,
  args-have => 0,
  args-used => 1,
  format    => 'foo';

my $f1 = Format.new("%5s");
isa-ok $f1, Format;
isa-ok $f1.Callable, Callable;
isa-ok $f1.Callable.signature, Signature;
is $f1.arity, 1, 'arity one arg';
is $f1.count, 1, 'count one arg';

is $f1("foo"),     '  foo',   'is $f1 callable?';
is "$f1",          '%5s',     'does $f1 stringify ok';
is "'$f1("bar")'", "'  bar'", 'does $f1 embed ok';

my $f2 = Format.new("%5s:%5s");
isa-ok $f2, Format;
isa-ok $f2.Callable, Callable;
isa-ok $f2.Callable.signature, Signature;
is $f2.arity, 2, 'arity two args';
is $f2.count, 2, 'count two args';

is $f2("foo","bar"),     '  foo:  bar',   'is $f2 callable?';
is "$f2",                '%5s:%5s',       'does $f2 stringify ok';
is "'$f2("foo","bar")'", "'  foo:  bar'", 'does $f2 embed ok';

isa-ok Formatter::Syntax.parse("zippo%10sbar"), Match;
isa-ok Formatter.CODE("zippo%10sbar"), Callable;
ok Formatter.AST("zippo%10sbar") ~~ RakuAST::Node,  # isa-ok fails??
  "The object is-a 'RakuAST::Node'";

#-------------------------------------------------------------------------------
# Tests for .fmt method taking Format objects

for <Set SetHash Bag BagHash Mix MixHash> -> $coercer {
    is <a b b>."$coercer"().fmt($f1, ':'), '    a:    b' | '    b:    a',
      "fmt on $coercer with one arg";
}

for <Set SetHash> -> $coercer {
    is <a b b>."$coercer"().fmt($f2, ','),
      '    a: True,    b: True' | '    b: True,    a: True',
      "fmt on $coercer with two args";
}

for <Bag BagHash Mix MixHash> -> $coercer {
    is <a b b>."$coercer"().fmt($f2, ','),
    '    a:    1,    b:    2' | '    b:    2,    a:    1',
      "fmt on $coercer with two args";
}

my $map := Map.new( (a => 1, b => 2) );
is $map.fmt($f1, ':'), '    a:    b' | '    b:    a',
  "fmt on Map with one arg";
is $map.fmt($f2, ','),
  '    a:    1,    b:    2' | '    b:    2,    a:    1',
  "fmt on Map with two args";

my $list := <a a b b>;
for <List Seq> -> $coercer {
    is $list."$coercer"().fmt($f1, ':'), '    a:    a:    b:    b',
      "fmt on $coercer with one arg";
    is $list."$coercer"().fmt($f2, ','), '    a:    a,    b:    b',
      "fmt on $coercer with two args";
    throws-like { $list.lazy."$coercer"().fmt($f1) },
      X::Cannot::Lazy,
      action => '.fmt';
}

# vim: expandtab shiftwidth=4
