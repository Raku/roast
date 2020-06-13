use v6;
use Test;

plan 1;

# https://github.com/Raku/old-issue-tracker/issues/3690
is ([+] await do for ^8 {
    start {
        my $i;
        for ^1_000_000 { $i++; }
        $i
    }
 }), 8_000_000, 'Large number of iterations in threads work fine';

# vim: expandtab shiftwidth=4
