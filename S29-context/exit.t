use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;

plan 3;

# L<S29/Context/"=item exit">

use Test::Util;

is_run 'say 3; exit; say 5',
    { out => "3\n", err => "", status => 0 },
    'bare exit; works';

is_run 'say 3; exit 5; say 5',
    { out => "3\n", err => "", status => 5 },
    'exit 5; works';

is_run 'say 3; try { exit 5 }; say 5',
    { out => "3\n", err => "", status => 5 },
    'try-block does not catch exit exceptions';

# vim: ft=perl6
