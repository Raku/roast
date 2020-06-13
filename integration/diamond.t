use v6;

use Test;

plan 2;

my $dir = $?FILE.IO.sibling("diamond");
my $script = $dir.child("a.raku");
my $module = $dir.child("D.rakumod");

$module.spurt: q:to/MODULE/;
use v6;
unit class D;
method foo { print "foo" }
MODULE

is run($*EXECUTABLE, $script,:out).out.slurp, "foo",
  "did the module get precompiled ok and return 'foo'";

$module.spurt: q:to/MODULE/;
use v6;
unit class D;
method foo { print "bar" }
MODULE

is run($*EXECUTABLE, $script,:out).out.slurp, "bar",
  "did the module get precompiled ok and return 'bar'";

# vim: expandtab shiftwidth=4
