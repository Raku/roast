use v6;
use Test;
need STD;

plan 1;

# test some STD methods

my $match = STD.parse('say <OH HAI>');
is(~$match, 'say <OH HAI>', '.parse works on STD');

# vim: ft=perl6
