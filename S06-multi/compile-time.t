use v6;
use Test;
BEGIN plan 2;

use lib $?FILE.IO.parent(2).child("packages/S06-multi/lib");
use compile-time;

# vim: ft=perl6
