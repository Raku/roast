use Test;

use lib $*PROGRAM.sibling("custom");
use client;

plan 1;

is-deeply bar(), "Success", 'did we compile and execute ok';

# vim: expandtab shiftwidth=4
