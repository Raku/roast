use v6;
use Test;

plan 3;

# L<S11/"Compile-time Importation"/"In the absence of a specific scoping specified by the caller">

use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");
use OuterModule :ALL;

is(foo(), 'Inner::foo', 're-exporting works using is export(:DEFAULT)');
is(bar(), 'Inner::bar', 're-exporting works using is export');
is(baz(), 'Inner::baz', 're-exporting works using is export(:MANDATORY)');
# is(qux(), 'Inner::qux', 're-exporting works using is export(:sometag)');

# vim: expandtab shiftwidth=4
