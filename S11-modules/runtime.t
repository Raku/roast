use v6;

use lib 't/spec/packages/S11-modules';

use Test;
plan 1;

eval-lives-ok 'use RuntimeCreatedPackage;', "Runtime package creation doesn't screw up module loading";
