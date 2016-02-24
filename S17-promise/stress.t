use v6;
use Test;

plan 1;

# RT #123883
is ([+] await do for ^8 {
    start {
        my $i;
        for ^1_000_000 { $i++; }
        $i
    }
 }), 8_000_000, 'Large number of iterations in threads work fine';
