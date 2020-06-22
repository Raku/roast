use v6;
use Test;

use lib $?FILE.IO.parent(2).add("packages/S11-modules/lib");

plan 1;

eval-lives-ok 'use RuntimeCreatedPackage;', "Runtime package creation doesn't screw up module loading";

# vim: expandtab shiftwidth=4
