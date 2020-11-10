use v6;

use Test;

# More tests planned then really is in this test for testing the trailing skips.
plan 39;

=begin kwid

This file /exhaustively/ tests the Test module.

Every variant of each Test function is tried here because we are using this module to test Raku itself, so we need to be
sure that errors are not coming from within this module.

We need to test that these functions produce 'not ok' at the right times, too. Here, we do that by abusing todo to mean
"supposed to fail."  Thus, no "todo" failure indicates a missing feature.

If there is a bug in the implementation, you will see a (non-TODO) failure or an unexpected TODO passing.

=end kwid

## ok

ok(2 + 2 == 4, '2 and 2 make 4');

todo "mitigate failing ok";
ok(2 + 2 == 5, '2 and 2 doesnt make 5');

## is

is(2 + 2, 4, '2 and 2 make 4');

todo "mitigate failing is";
is(2 + 2, 5, '2 and 2 doesnt make 5');

## isnt

isnt(2 + 2, 5, '2 and 2 does not make 5');

todo "mitigate failing isnt";
isnt(2 + 2, 4, '2 and 2 does make 4');

## is-deeply

is-deeply([ 1..4 ], [ 1..4 ],
          "is-deeply (simple)");

is-deeply({ a => "b", c => "d", nums => ['1'..'6'] },
          { nums => ['1'..'6'], <a b c d> },
          "is-deeply (more complex)");

# This reverse-swap voodo is only to be on the safest side of things. Basically, makes no sense as keys are randomized
# anyway. But if something goes wrong with Hash initialization this mangling would let us hope that keys are not the
# same order in both hashes.
my @a = "a" .. "z";
my @b = @a.reverse;
@b = @b.map(sub ($a, $b) { |($b, $a) });
my %a = |@a;
my %b = |@b;
is-deeply(%a, %b, "is-deeply (test hash key ordering)");

## isa-ok

my @list = ( 1, 2, 3 );

isa-ok(@list, 'List');
isa-ok({ 'one' => 1 }, 'Hash');

todo "mitigate failing 2 isa-ok", 2;
isa-ok(@list, 'Hash', '... testing first failing isa-ok');
isa-ok(@list, Hash, '... testing second failing isa-ok');

class Foo {};
my $foo = Foo.new();
isa-ok($foo, 'Foo');
isa-ok(Foo.new(), 'Foo');

isa-ok Any.HOW, Metamodel::ClassHOW;
isa-ok Numeric.HOW, Metamodel::ParametricRoleGroupHOW;
my enum A <a b c>;
isa-ok A.HOW, Metamodel::EnumHOW;
isa-ok UInt.HOW, Metamodel::SubsetHOW;

## like

like("Hello World", rx:P5/\s/, '... testing like()');

todo "mitigate failing like";
like("HelloWorld", rx:P5/\s/, '... testing failing like()');

## unlike

unlike("HelloWorld", rx:P5/\s/, '... testing unlike()');

todo "mitigate failing unlike";
unlike("Hello World", rx:P5/\s/, '... testing failing unlike()');

## cmp-ok

cmp-ok('test', sub ($a, $b) { ?($a gt $b) }, 'me', '... testing gt on two strings');

todo "mitigate failing cmp-ok";
cmp-ok('test', sub ($a, $b) { ?($a gt $b) }, 'you', '... testing gt on two strings');

## use-ok

use lib $?FILE.IO.parent;
use-ok('use_ok_test');

# Need to do a test loading a package that is not there,
# and see that the load fails. Gracefully. :)
todo "mitigate failing use-ok";
use-ok('Non::Existent::Package');

## dies-ok

dies-ok -> { die "Testing dies-ok" }, '... it dies-ok';

todo "mitigate failing dies-ok";
dies-ok -> { "Testing dies-ok" }, '... testing failing dies-ok';

## lives-ok

lives-ok -> { "test" }, '... it lives-ok';

todo "mitigate Failing lives-ok";
lives-ok -> { die "test" }, '... testing failing lives-ok';

## diag

diag('some misc comments and documentation');

## pass

pass('This test passed');

## flunk

todo "mitigate flunk";
flunk('This test failed');

## skip

skip('skip this test for now');
skip('skip 3 more tests for now', 3);
skip-rest('skipping the rest');

#######################################################################
#######################################################################
#
# WARNING: do not add new tests below. The test above does "skip-rest",
#         so any tests you add will be skipped. Add them *above* the
#         "skip" chunk of tests instead.
#
#######################################################################
#######################################################################

# vim: expandtab shiftwidth=4
