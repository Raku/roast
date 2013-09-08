use v6;
use Test;

plan 3;

# L<S29/Context/"=item exit">

BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

is_run 'say 3; exit; say 5',
    { out => "3\n", err => "", status => 0 },
    'bare exit; works';

#?rakudo.jvm todo "nigh"
is_run 'say 3; exit 5; say 5',
    { out => "3\n", err => "", status => 5 +< 8 },
    'exit 5; works';

#?rakudo.jvm todo "nigh"
is_run 'say 3; try { exit 5 }; say 5',
    { out => "3\n", err => "", status => 5 +< 8 },
    'try-block does not catch exit exceptions';

# vim: ft=perl6
