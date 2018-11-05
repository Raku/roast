use v6.d;

use lib $?FILE.IO.parent(2).add("packages").add("S11-modules");

use Test;
plan 1;

eval-lives-ok 'use RuntimeCreatedPackage;', "Runtime package creation doesn't screw up module loading";
